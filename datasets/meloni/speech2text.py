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
model_name  = "medium"            # tiny, base, medium, large
lang_code   = "Italian"
# Use BASE_DIR to join paths
#audio_file  = str(BASE_DIR / "audio.mp3")

output_dir  = str(BASE_DIR / f"output-{model_name}")
csv_dir     = BASE_DIR / "csv_out"
audio_dir   = BASE_DIR / "audio_out"

csv_dir.mkdir(parents=True, exist_ok=True)
# ──────────────────────────────────────────────────────────────────────────────
def process_video(video_url):
    unique_id = video_url[-5:]
    audio_file  = str(audio_dir / f"{unique_id}_audio.mp3")
    csv_output  = str(csv_dir / f"{unique_id}_meloni_speech2text.csv")

    # 1. Download metadata and audio in a single pass
    print(f"Fetching metadata and downloading audio of video {video_url}...")

    # Use --print-json to get metadata without creating a temporary .json file
    # Use -x and --audio-format to handle the extraction internally
    result = subprocess.run([
        "yt-dlp",
        "--print-json",
        "-x",                               # download audio only
        "--audio-format", "mp3",            
        "--cookies", "yt_cookies.txt",      # manual cookies, extract with browser extension
        "--sleep-requests", "2",            # Sleep 2s between requests
        "--sleep-interval", "5",            # Sleep 5s between downloads
        "--max-sleep-interval", "15",       # Randomize up to 15s
        "--limit-rate", "5M",               # Throttle to 5MB/s (mimics streaming)
        "-o", audio_file.replace('.mp3', ''), 
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

    print("Start transcription...")
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

    print("Transcribed")
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
    print("Writing into csv...")
    audio_path_str = str(audio_path)

    row = {
        "politician":      f"{politician}",
        "historical_date": datetime.strptime(historical_date, "%Y-%m-%d").date() if historical_date else "",
        "location":        location,
        "tags":            tags,
        "description":     description.replace("\n", " ").replace("\r", " ").strip(),
        "title":           title.replace("\n", " ").replace("\r", " ").strip(),
        "url":             url,
        "audio_file":      audio_path_str[audio_path_str.index("crossdem"):],
        "text":            text.replace("\n", " ").replace("\r", " ").strip(),
    }

    write_header = not os.path.exists(csv_output)
    with open(csv_output, "a", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=row.keys())
        if write_header:
            writer.writeheader()
        writer.writerow(row)

    print(f"Done! Row appended to '{csv_output}'")

urls = [
    "https://youtu.be/iOFR7Ae9cHU?si=0jxlIq30L1GWEz6v", 
    "https://youtu.be/i4Dyv8CQ7VA?si=dmvMAn8kQ7L65bjC",
    "https://youtu.be/F4-PR5iJv0E?si=xOoatF-_4Kz6rOAc",
    "https://youtu.be/A_pHRztwshY?si=g12j2iNOGap5gm3A",
    "https://youtu.be/RL-q9N7EtQE?si=gnA73YDdUye1GqzU",
    "https://youtu.be/6gJWd0_AlTI?si=QEgiswzWpwDsMzNn",
    "https://youtu.be/T6OsYCkszK0?si=yIzfFmLtlTHaD5q4",
    "https://youtu.be/V9Tj0GjsG2I?si=fi303tNdgziDGS89",
    "https://youtu.be/zw0Y88qmlns?si=_BgAaAB6mmI0tEB-",
    "https://youtu.be/Brqc3jMuh0w?si=GkVqVWWRRUS7FZlV",
    "https://youtu.be/kPoyF7qxgBU?si=dL7Qr8ucC_R0NQSz",
    "https://youtu.be/3oUPE1mNUoM?si=5M7D9HgoU-q0yHzW",
    "https://youtu.be/4Hgz1b3i6VE?si=aTKTU9uQgzKJFKzG",
    "https://youtu.be/TFP7iXysQdY?si=9sS5a09YA4vqtub6",
    "https://youtu.be/AXIGN6uR_CI?si=qAuLGhJ_4azyzIXy",
    "https://youtu.be/yGP2Z1p9_eQ?si=j61iqqaKTOvfnZ67",
    "https://youtu.be/ZSpJo7drdaY?si=GToexGNvc9PoSKhw",
    "https://youtu.be/CTJNixke0HU?si=2Q3yMvOHSQt-TodI",
    "https://youtu.be/h2VxlKeVnSA?si=bptlWkK2jr1TeTO3",
    "https://youtu.be/an8w2xXr7c8?si=tt45S0AylN2TcPIH",
    "https://youtu.be/bJJTSEqfwi0?si=f-zQP58umOu4BsP4",
    "https://youtu.be/5lITnGoLpdw?si=0SY0Yg7791gzkEjl",
    "https://youtu.be/UQcpHzsLHCA?si=_Qc4PXW6fVU5CPq6",
    "https://youtu.be/gOiD_-pTYIk?si=S5qzWQD7v3HZr7Ia",
    "https://youtu.be/O7SN-mS9P1k?si=u92YXNjv_tnYo3ij",
    "https://youtu.be/0OEnXqOEKRw?si=aTF_Bw2n8U08Hamy",
    "https://youtu.be/cKwgRPzXoKI?si=rQuI2pbP0aW_vj0Y",
    "https://youtu.be/FEp56xwMXXs?si=2fbYXvfQl_aCHe4J",
    "https://youtu.be/y8nJhjYyFCI?si=czGmu7PcLfLcGf18",
    "https://youtu.be/JUJEUI6xIME?si=BSEso6O7v5gXJwcm",
    "https://youtu.be/24A7-kSsUVY?si=bnt2iomhQRM1sGW4",
    "https://youtu.be/oVZIh7strxE?si=pvZKW-ewFvq4iU9F",
    "https://youtu.be/fIXWcXXybaI?si=j7IA2FVPsWj2YbPP",
    "https://youtu.be/EOxCyw5tj9c?si=DQcpNyuDSaJX85AI",
    "https://youtu.be/Vgg_82Eqx_M?si=p9btenm5bnwQp6uF&t=170",
    "https://youtu.be/857GHLw4__U?si=sKp50kwa5LoFZNRh",
    "https://youtu.be/2Mfvzoy11K4?si=5IuLQdtlWMp2J-Iu",
    "https://youtu.be/XzSl714f39I?si=2YLHKeTIYfpSx04k",
    "https://youtu.be/swgcqGD642U?si=df_sTYMHgnVCNjVx",
    "https://youtu.be/fBgGSF2Fq4g?si=VYUXE52JbAyV34KU",
    "https://youtu.be/V3N1ZCarPGI?si=jZ2KegGpNiFlpPWm",
    "https://youtu.be/VRLtvz8IDEc?si=Ax2zjkTTAYBvuOfv",
    "https://youtu.be/sQYKu-JcD_c?si=fFdnVYtnY6OHopjT",
    "https://youtu.be/b8hmiUt9YYQ?si=-0D1RGvAw49eRssi",
    "https://youtu.be/FpYtQrQeZPk?si=cHRPeIPtg3ulYIj9",
    "https://youtu.be/Jqna2Io0xzY?si=IT5MJT4mvQAFUKxf",
    "https://youtu.be/DtePssuz2j8?si=AiwxIkXZssGGrN2N",
    "https://youtu.be/vgln19zUtZk?si=5H1xiTodCrhwAqnL",
    "https://youtu.be/nvPC5cR-QAU?si=9MoRYktODePZJLj6",
    "https://youtu.be/3_C4ZNAjGAw?si=yhQ2bMKQfIHO-050",
    "https://youtu.be/0n1Es4IqJ7M?si=efeaXMDLzIz_DAzj",
    "https://youtu.be/HuI1CNvBEp8?si=9LoPvWPofNPu9-LF",
    "https://youtu.be/imvDL8rNLZg?si=R_Nkqhc8TEDbwykb",
    "https://youtu.be/lgsLDA3vwvQ?si=i-tzCstTrfwXn00t",
    "https://youtu.be/L_oqg8GNmyA?si=fUednrgWg8UmwUcQ",
    "https://youtu.be/mzoMWe0akMI?si=zMbjgoHYMiXxd6jX",
    "https://youtu.be/kyfQKqv8Frc?si=rFOSJIlBy8OpdbRy",
    "https://youtu.be/GOx5k7gdH6M?si=YRAUv9e5qlXoP5W4",
    "https://youtu.be/KmYVoawOVbU?si=svqGrT0c8oy6P4E-",
    "https://youtu.be/BLQ1rjDCgpE?si=sUSk94QuAzoyfIjb",
    "https://youtu.be/Wh97m1eNp88?si=ZJkjkeMEpcWs_jYV",
    "https://youtu.be/81ydpm2Ygzg?si=Ugt2oKUBZveq--RZ",
    "https://youtu.be/tl3XnAr_8Io?si=eP-xKrrACq8QYrdZ",
    "https://youtu.be/BOK3ay68DPs?si=c8rn83GYDr4xVLbF",
    "https://youtu.be/VZUZ74XMKH0?si=cvJDiASh5baj0_EA",
    "https://youtu.be/saf_05yblDQ?si=dVjS5jmEsicWM4JD",
    "https://youtu.be/FDy7fCsqbNs?si=1Zrl4cAKGLHSgM9q",
    "https://youtu.be/huFE_0ZdeNM?si=1R3k5j6TVs4FCopn",
    "https://youtu.be/Hxdq4eIW8WM?si=HwAxNN7zgZDvB7ut",
    "https://youtu.be/k3A4GnyqgZs?si=vSq_aUWDRVwkV9Dq",
    "https://youtu.be/kK3D1iJedgM?si=2IvWElX1Xt_tAq2v",
    "https://youtu.be/OSMZN_ldJww?si=sIQbqvbVBqOrBHLJ"
]


for url in urls:
    process_video(url)


# request rejected by youtube only once about halfway trough