import csv
import re
import sys
from pathlib import Path

"""
Removes from the datasets the strings:"Sottotitoli a cura di QTSS"; "..."; "Sottotitoli creati dalla comunità Amara.org"
"""

csv.field_size_limit(sys.maxsize)  # some speeches are very long

SCRIPT_DIR = Path(__file__).resolve().parent      # .../crossdem/source
PMS_DIR = SCRIPT_DIR.parent / "datasets" / "prime_ministers"

STRINGS = [
    "Sottotitoli a cura di QTSS",
    "Sottotitoli creati dalla comunità Amara.org",
    "...",
]
TEXT_COL = "text"
SUBDIRS = ("csv_out", "splitted")   # splitted = De Gasperi's per-speech csvs
TIDY_WHITESPACE = True              # collapse leftover double spaces where a string was removed

APPLY = "--apply" in sys.argv       # without it: dry run, nothing is written


def clean(text):
    counts = {}
    for s in STRINGS:
        counts[s] = text.count(s)
        text = text.replace(s, "")
    if TIDY_WHITESPACE and any(counts.values()):
        text = re.sub(r"[ \t]{2,}", " ", text).strip()
    return text, counts


def process_file(path):
    with open(path, newline="", encoding="utf-8") as fh:
        reader = csv.DictReader(fh)
        fields = reader.fieldnames
        rows = list(reader)

    if not fields or TEXT_COL not in fields:
        return None  # not a speech csv

    totals = {s: 0 for s in STRINGS}
    for row in rows:
        row[TEXT_COL], counts = clean(row[TEXT_COL] or "")
        for s, c in counts.items():
            totals[s] += c

    if not any(totals.values()):
        return totals

    if APPLY:
        tmp = path.with_suffix(".csv.tmp")
        with open(tmp, "w", newline="", encoding="utf-8") as fh:
            w = csv.DictWriter(fh, fieldnames=fields)
            w.writeheader()
            w.writerows(rows)
        tmp.replace(path)   # swap in only after a complete write
    return totals


def main():
    grand = {s: 0 for s in STRINGS}
    files_changed = 0
    files_seen = 0

    for pol_dir in sorted(p for p in PMS_DIR.iterdir() if p.is_dir()):
        pol_changed = 0
        for sub in SUBDIRS:
            for f in sorted((pol_dir / sub).glob("*.csv")):
                totals = process_file(f)
                if totals is None:
                    continue
                files_seen += 1
                if any(totals.values()):
                    pol_changed += 1
                    for s, c in totals.items():
                        grand[s] += c
        files_changed += pol_changed
        if pol_changed:
            print(f"{pol_dir.name}: {pol_changed} files {'modified' if APPLY else 'would be modified'}")

    print(f"\nScanned {files_seen} speech files, {files_changed} "
          f"{'modified' if APPLY else 'would be modified'}.")
    for s, c in grand.items():
        print(f"  {c:>7} x {s!r}")
    if not APPLY:
        print("\nDry run only. Re-run with --apply to write the changes.")


if __name__ == "__main__":
    main()