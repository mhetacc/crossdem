#!/bin/bash

# ── Configuration ─────────────────────────────────────────────
DIR="${1:-.}"          # first argument = directory, default = current dir
KEEP_GENRE="Discorsi Pubblici"   # change this to your target genre
# ──────────────────────────────────────────────────────────────

if [ ! -d "$DIR" ]; then
    echo "Error: '$DIR' is not a valid directory."
    exit 1
fi

echo "Directory : $DIR"
echo "Keep genre: $KEEP_GENRE"
echo ""

# ── Dry run: collect files to delete ──────────────────────────
TO_DELETE=()

for f in "$DIR"/*.xml; do
    [ -f "$f" ] || continue   # skip if no .xml files found

    if ! grep -qF "<genre>$KEEP_GENRE</genre>" "$f"; then
        TO_DELETE+=("$f")
    fi
done

# ── Report ────────────────────────────────────────────────────
if [ ${#TO_DELETE[@]} -eq 0 ]; then
    echo "No files to delete — all XML files contain the target genre."
    exit 0
fi

echo "── DRY RUN: files that will be DELETED (${#TO_DELETE[@]}) ──"
for f in "${TO_DELETE[@]}"; do
    echo "  $f"
done
echo ""

# ── Confirm ───────────────────────────────────────────────────
read -rp "Permanently delete these ${#TO_DELETE[@]} file(s)? [y/N] " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
    for f in "${TO_DELETE[@]}"; do
        rm "$f" && echo "Deleted: $f"
    done
    echo ""
    echo "Done. ${#TO_DELETE[@]} file(s) removed."
else
    echo "Aborted. No files were deleted."
fi