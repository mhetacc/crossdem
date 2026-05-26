#!/usr/bin/env python3

import csv
import glob
import os
import re
import xml.etree.ElementTree as ET

BASE_DIR = os.path.dirname(os.path.abspath(__file__))  # same folder as this script
XML_DIR  = os.path.join(BASE_DIR, "xml")
OUT_CSV  = os.path.join(BASE_DIR, "out.csv")

POLITICIAN = "alcide"

def clean_text(text):
    """Collapse whitespace / newlines inside text nodes."""
    if text is None:
        return ""
    return re.sub(r"\s+", " ", text).strip()

rows = []

xml_files = sorted(glob.glob(os.path.join(XML_DIR, "*.xml")))
if not xml_files:
    print(f"No XML files found in {XML_DIR}")
    exit(1)

for path in xml_files:
    try:
        tree = ET.parse(path)
        root = tree.getroot()

        date  = clean_text(root.findtext("publication_date"))
        place = clean_text(root.findtext("publication_place/place_name"))
        text  = clean_text(root.findtext("text"))

        keywords = [
            clean_text(kw.text)
            for kw in root.findall("keywords/keyword")
        ]

        rows.append({
            "politician":     POLITICIAN,
            "historical_date": date,
            "place":          place,
            "keywords":       str(keywords),   # e.g. ['operai', 'università italiana', ...]
            "text":           text,
        })

    except ET.ParseError as e:
        print(f"Skipping {path}: parse error — {e}")

with open(OUT_CSV, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=["politician", "historical_date", "place", "keywords", "text"])
    writer.writeheader()
    writer.writerows(rows)

print(f"Done — {len(rows)} records written to {OUT_CSV}")