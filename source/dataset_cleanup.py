import csv
import shutil
import sys
from pathlib import Path

import pandas as pd

csv.field_size_limit(sys.maxsize)  # some speeches are very long

SCRIPT_DIR = Path(__file__).resolve().parent     # .../crossdem/source
BASE_DIR = SCRIPT_DIR.parent                     # .../crossdem
DATA_DIR = BASE_DIR / "datasets"

PMS_DIR = DATA_DIR / "prime_ministers"
DISCARD_ROOT = DATA_DIR / "pms_discarded"
OUTLIERS_CSV = SCRIPT_DIR / "outlier_speeches.csv"
TODO_CSV = SCRIPT_DIR / "outlier_speeches_copy.csv"      # progressively shrinks
DISCARDED_CSV = SCRIPT_DIR / "discarded_speeches.csv"
MOVE_CSV = True

_index_cache = {}

def resolve(p):
    """Turn a path like 'crossdem/datasets/...' into an absolute path."""
    p = Path(p)
    return p if p.is_absolute() else BASE_DIR.parent / p

def load_index(pol):
    """{mp3 file name: (csv path, transcript)} for one politician."""
    if pol not in _index_cache:
        idx = {}
        for f in (PMS_DIR / pol / "csv_out").glob("*.csv"):
            with open(f, newline="", encoding="utf-8") as fh:
                row = next(csv.DictReader(fh), None)
            if row and row.get("audio_file"):
                idx[Path(row["audio_file"]).name] = (f, row.get("text", ""))
        _index_cache[pol] = idx
    return _index_cache[pol]


def find_speech(row):
    return load_index(row["politician"]).get(Path(row["audio_file"]).name, (None, None))


def clean_id(x):
    return x[:-2] if x.endswith(".0") else x


def log_discard(row, src, dest):
    new_file = not DISCARDED_CSV.exists()
    with open(DISCARDED_CSV, "a", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        if new_file:
            w.writerow(["politician", "speech_id", "file_name", "original_path", "new_path"])
        w.writerow([row["politician"], clean_id(row["speech_id"]), src.name, str(src), str(dest)])


def ask():
    while True:
        ans = input("Discard? [y/n] (q = quit, progress is saved): ").strip().lower()
        if ans in ("y", "n", "q"):
            return ans
        print("Please type y, n or q.")


def discard(row, csv_path):
    src = resolve(row["audio_file"])
    dest_dir = DISCARD_ROOT / row["politician"]
    dest_dir.mkdir(parents=True, exist_ok=True)
    moved = False

    if src.exists():
        dest = dest_dir / src.name
        shutil.move(str(src), str(dest))
        log_discard(row, src, dest)
        print(f"  -> audio moved to {dest}")
        moved = True
    else:
        print(f"  ! audio not found: {src} (already moved?)")

    if MOVE_CSV and csv_path is not None and csv_path.exists():
        shutil.move(str(csv_path), str(dest_dir / csv_path.name))
        print(f"  -> csv moved to {dest_dir / csv_path.name}")
        moved = True

    if not moved:
        print("  ! nothing was moved.")


def main():
    if not TODO_CSV.exists():
        if not OUTLIERS_CSV.exists():
            print(f"{OUTLIERS_CSV} not found.")
            return
        shutil.copy(OUTLIERS_CSV, TODO_CSV)

    todo = pd.read_csv(TODO_CSV, dtype=str, keep_default_na=False)
    if len(todo) == 0:
        print("Nothing left to review.")
        return

    # rows with no audio path (e.g. degasperi) can't be located: leave them in the file
    n_unlocatable = int((todo["audio_file"] == "").sum())
    total = len(todo) - n_unlocatable
    done = 0

    try:
        while True:
            pending = todo[todo["audio_file"] != ""]
            if pending.empty:
                break
            idx_label = pending.index[0]
            row = pending.loc[idx_label]
            done += 1

            csv_path, text = find_speech(row)
            print("\n" + "=" * 80)
            print(f"[{done}/{total}] {row['politician']} | id={clean_id(row['speech_id'])} | "
                  f"chars={row['n_chars']} | self_sim={float(row['self_sim']):.3f}")
            print(f"file: {row['audio_file']}")
            print("-" * 80)
            print(text if text is not None else "[transcript not found in csv_out/]")
            print("-" * 80)

            ans = ask()
            if ans == "q":
                break
            if ans == "y":
                discard(row, csv_path)

            todo = todo.drop(index=idx_label)       # checked (y or n): remove and save
            todo.to_csv(TODO_CSV, index=False)
    except KeyboardInterrupt:
        print("\nInterrupted. Progress saved.")

    print(f"\n{len(todo)} rows left in {TODO_CSV}.")
    if n_unlocatable:
        print(f"({n_unlocatable} of them have no audio_file and are skipped by this script.)")


if __name__ == "__main__":
    main()