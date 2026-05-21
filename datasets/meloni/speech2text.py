import json
import os
import subprocess
import csv
from datetime import datetime
from pathlib import Path

# Get the directory where the script is located
BASE_DIR = Path(__file__).resolve().parent

# ─── Config ───────────────────────────────────────────────────────────────────
politician  = "meloni"
model_name  = "tiny"
lang_code   = "Italian"
# Use BASE_DIR to join paths
#audio_file  = str(BASE_DIR / "audio.mp3")

output_dir  = str(BASE_DIR / f"output-{model_name}")
csv_output  = str(BASE_DIR / "meloni_speech2text.csv")

# ──────────────────────────────────────────────────────────────────────────────
def process_video(video_url):
    unique_id = video_url[-5:]
    audio_file  = str(BASE_DIR / f"{unique_id}_audio.mp3")
    # 1. Download metadata and audio in a single pass
    print("Fetching metadata and downloading audio...")

    # Use --print-json to get metadata without creating a temporary .json file
    # Use -x and --audio-format to handle the extraction internally
    result = subprocess.run([
        "yt-dlp",
        "--print-json",
        "-x",                             # Extract audio
        "--audio-format", "mp3",          # Specify format (mp3, m4a, wav, etc.)
        "--cookies", "yt_cookies.txt",
        # 2. Rate limiting & Human-like delays
        "--sleep-requests", "2",      # Sleep 2s between requests
        "--sleep-interval", "5",      # Sleep 5s between downloads
        "--max-sleep-interval", "15", # Randomize up to 15s
        "--limit-rate", "5M",         # Throttle to 5MB/s (mimics streaming)
        "-o", audio_file.replace('.mp3', ''), # yt-dlp adds the extension automatically
        video_url
    ], capture_output=True, text=True, check=True)

    meta = json.loads(result.stdout)

    # Parse metadata fields
    raw_date = meta.get("upload_date", "")
    historical_date = (
        datetime.strptime(raw_date, "%Y%m%d").strftime("%Y-%m-%d")
        if raw_date else ""
    )
    location    = meta.get("location") or ""
    tags        = meta.get("tags") or []
    description = meta.get("description") or ""
    title       = meta.get("title") or ""

    print("Task Complete")
    print(f"  Title : {title}")
    print(f"  Date  : {historical_date}")
    print(f"  Saved : {audio_file}")

    # ──────────────────────────────────────────────────────────────────────────────
    # 3. Transcribe with Whisper
    if not os.path.exists(audio_file):
        raise FileNotFoundError(f"Audio file '{audio_file}' not found.")

    print("Transcribing")
    subprocess.run([
        "whisper",
        "--language",        lang_code,
        "--word_timestamps", "True",
        "--model",           model_name,
        "--output_dir",      output_dir,
        "--device",          "cuda",
        audio_file
    ], check=True)

    # ──────────────────────────────────────────────────────────────────────────────
    # 4. Read the plain-text transcript (.txt produced by Whisper)
    #transcript_path = os.path.join(output_dir, os.path.splitext(audio_file)[0] + ".txt")
    audio_path = Path(audio_file)
    transcript_path = Path(output_dir) / f"{audio_path.stem}.txt"

    # If you need it as a string for the open() function:
    transcript_path = str(transcript_path)
    if not os.path.exists(transcript_path):
        raise FileNotFoundError(
            f"Transcript not found at '{transcript_path}'. "
            "Check the output_dir and audio filename."
        )

    with open(transcript_path, "r", encoding="utf-8") as f:
        text = f.read().strip()

    # ──────────────────────────────────────────────────────────────────────────────
    # 5. Write CSV
    row = {
        "politician":      f"{politician}",
        "historical_date": datetime.strptime(historical_date, "%Y-%m-%d").date() if historical_date else "",
        "location":        location,
        "tags":            tags,
        "description":     description.replace("\n", " ").replace("\r", " ").strip(),
        "title":           title.replace("\n", " ").replace("\r", " ").strip(),
        "text":            text.replace("\n", " ").replace("\r", " ").strip(),
    }
    return row

urls = [
    "https://youtu.be/A_pHRztwshY?si=XCFp-BbJXx0Hh8zV",
    "https://youtu.be/iOFR7Ae9cHU?si=ayJkXKCef7HQVHu_",
    "https://youtu.be/1tgNs_fr4w0?si=Ab48jlbcUs_im1rH"
]
rows = []

for url in urls:
    rows.append(process_video(url))

for row in rows:
    write_header = not os.path.exists(csv_output)
    with open(csv_output, "a", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=row.keys())
        if write_header:
            writer.writeheader()
        writer.writerow(row)

print(f"Done! Row appended to '{csv_output}'")