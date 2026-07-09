"""
Run this once inside your notebook (where `politicians_dfs` and `POL_COLORS`
already exist) to produce data.json for the GitHub Pages site.

Usage (in a notebook cell):
    exec(open("export_data.py").read())

Or just paste the body below directly into a cell.
"""

import json
from pathlib import Path

OUT_PATH = Path("data.json")

data = {}
for pol, df in politicians_dfs.items():
    vals = df["mtld"].dropna().tolist()
    data[pol] = {
        "mtld": vals,
        "color": POL_COLORS[pol],
    }

with OUT_PATH.open("w", encoding="utf-8") as f:
    json.dump(data, f)

print(f"Wrote {OUT_PATH.resolve()} with {len(data)} politicians")
