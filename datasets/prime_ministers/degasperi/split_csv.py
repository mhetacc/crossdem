#!/usr/bin/env python3
"""
Split a CSV file into N separate CSV files, one per data row.
Each output file contains the header row + exactly one data row.

Usage:
    python split_csv.py input.csv [output_dir] [--prefix row_]
"""

import csv
import sys
import argparse
from pathlib import Path


def split_csv(input_path: str, output_dir: str = "split_output", prefix: str = "row_"):
    input_path = Path(input_path)
    output_dir = Path(output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    with open(input_path, newline="", encoding="utf-8") as infile:
        reader = csv.reader(infile)
        try:
            header = next(reader)
        except StopIteration:
            print("Input CSV is empty.")
            return

        count = 0
        for i, row in enumerate(reader, start=1):
            out_path = output_dir / f"{prefix}{i}.csv"
            with open(out_path, "w", newline="", encoding="utf-8") as outfile:
                writer = csv.writer(outfile)
                writer.writerow(header)
                writer.writerow(row)
            count += 1

    print(f"Done. Wrote {count} files to '{output_dir}/'")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Split a CSV into one file per row.")
    parser.add_argument("input_csv", help="Path to the input CSV file")
    parser.add_argument("output_dir", nargs="?", default="split_output",
                         help="Directory to write output files into (default: split_output)")
    parser.add_argument("--prefix", default="row_",
                         help="Filename prefix for output files (default: row_)")
    args = parser.parse_args()

    split_csv(args.input_csv, args.output_dir, args.prefix)
