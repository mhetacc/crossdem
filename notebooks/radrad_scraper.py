from datetime import date, datetime
from urllib.parse import urljoin
from bs4 import BeautifulSoup
from pathlib import Path
from time import sleep
import subprocess
import requests
import time
import glob
import json
import csv
import re
import os


DATA = [
    ("draghi", "/soggetti/46315/mario-draghi"),
    ("meloni", "/soggetti/94729/giorgia-meloni"),
    ("conte", "/soggetti/110925/giuseppe-conte"),
    ("gentiloni", "/soggetti/243521/paolo-gentiloni"),
    ("renzi", "/soggetti/74722/matteo-renzi"),
    ("letta", "/soggetti/40755/enrico-letta"),
    ("monti", "/soggetti/35269/mario-monti"),
    ("dini", "/soggetti/24012/lamberto-dini"),
    ("prodi", "/soggetti/6661/romano-prodi"),
    ("d'alema", "/soggetti/4773/massimo-d-alema"),
    ("ciampi", "/soggetti/17588/carlo-azeglio-ciampi"),
    ("berlusconi", "/soggetti/11165/silvio-berlusconi"),
    ("amato", "/soggetti/311/giuliano-amato"),
    ("de mita", "/soggetti/1781/ciriaco-de-mita"),
    ("craxi", "/soggetti/286/bettino-craxi"),
    ("goria", "/soggetti/831/giovanni-goria"),
    ("spadolini", "/soggetti/253/giovanni-spadolini"),
    ("forlani", "/soggetti/1043/arnaldo-forlani"),
    ("cossiga", "/soggetti/595/francesco-cossiga"),
    ("rumor", "/soggetti/1769/mariano-rumor"),
    ("emilio", "/soggetti/6010/colombo-emilio"),
    ("andreotti", "/soggetti/99/giulio-andreotti"),
    ("moro", "/soggetti/1325/aldo-moro"),
    ("leone", "/soggetti/6656/giovanni-leone"),
    ("segni", "/soggetti/101437/antonio-segni"),
    ("scelba", "/soggetti/191965/mario-scelba"),
]

testing = False
model_name  = "medium"      # tiny, base, medium, large
lang_code   = "Italian"
                            
BASE_URL = "https://www.radioradicale.it"
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath("__file__")))  # go to ~/crossdem/ by jumping up twice
os.makedirs(os.path.join(BASE_DIR, "logs"), exist_ok=True)
DISCARD_LOG = os.path.join(BASE_DIR, "logs", "discarded.log")
last_commit = 0.0

"""
Execution: 
$ source crosscode/crosscode_venv/bin/activate
$ cd nodebooks/
$ python3 radarad_scraper.py
"""

###################################################
#--------------------------- Audio Download ----------------------------


def get_audio_url(page_url: str) -> str:
    resp = requests.get(page_url, headers={"User-Agent": "Mozilla/5.0"})
    resp.raise_for_status()
    match = re.search(r'rtsp://[^"]+\.mp3', resp.text)
    if not match:
        raise ValueError("No rtsp audio link found on the page")
    return match.group(0)

def sanitize_url(page_url: str) -> str:
    """
    go from https://www.radioradicale.it/scheda/000000/somethingsomethign
    to      https://www.radioradicale.it/scheda/000000
    """
    base = page_url.split("?")[0]
    parts = base.split("/")
    return "/".join(parts[:5])  # https: + '' + domain + scheda + ID

def extract_id_from_url(url):
    """Extract the scheda ID from a Radio Radicale URL."""
    # e.g. /scheda/58768/... → "58768"
    parts = url.split("/scheda/")
    if len(parts) > 1:
        return parts[1].split("/")[0]
    return None

def download_audio_subprocess(url: str, out_dir: str, politician: str = "politician") -> dict:
    """
    Alternative to download_audio that does not struggle with long videos.
    """
    import glob, os
    url = sanitize_url(url)
    id = extract_id_from_url(url)
    stem = f"{id}_{politician}"
    final_file = f"{out_dir}/{stem}.mp3"

    print(f"Downloading {url}")
    print(f"Resulting file {final_file}")

    result = subprocess.run([
        "yt-dlp",
        "-x",
        "--audio-format", "mp3",
        "--audio-quality", "0",
        "-o", f"{out_dir}/{stem}_part%(playlist_index)s.%(ext)s",
        "--concat-playlist", "always",
        "-o", f"pl_video:{out_dir}/{stem}_part%(playlist_index)s.%(ext)s",
        url
    ], capture_output=False, text=True)



    if result.returncode != 0:
        raise RuntimeError(f"yt-dlp exited {result.returncode}")
    print("Concatenate fragments")
    ## ---------- concatenate audio fragments -------------------------
    # yt-dlp concat destination is always part0 (it overwrites the first part in-place)
    concat_result = f"{out_dir}/{stem}_part0.mp3"
    if not os.path.exists(concat_result):
        # fallback: maybe it was a single-part download with no index
        candidates = glob.glob(f"{out_dir}/{stem}*.mp3")
        if not candidates:
            raise FileNotFoundError(f"No mp3 found in {out_dir} for stem {stem}")
        concat_result = candidates[0]

    os.rename(concat_result, final_file)
    print("Fetch metadata")
        # ── 3. Fetch rich metadata (no re-download) ───────────────────────────────
    meta_result = subprocess.run([
        "yt-dlp",
        "--dump-json",
        "--no-playlist",       # get the page-level info, not per-entry
        "--flat-playlist",     # don't resolve individual entries
        url,
    ], capture_output=True, text=True)

    if meta_result.returncode == 0 and meta_result.stdout.strip():
        # --dump-json may emit one JSON object per line for playlists; take the last
        # (the playlist container) or first (single video) depending on structure
        lines = [l for l in meta_result.stdout.splitlines() if l.strip()]
        try:
            info = json.loads(lines[-1])
        except json.JSONDecodeError:
            info = {}
    else:
        info = {}

    # ── 4. Normalise to the same shape as download_audio's sanitize_info ──────
    info["filename"] = os.path.basename(final_file)
    info["file_id"] = id
    info.setdefault("url", url)
    return info


#----------------------- Extract information from html page ---------------------------------
# ── HTTP ────────────────────────────────────────────────────────────────────

HEADERS = {
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:125.0) Gecko/20100101 Firefox/125.0",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    "Accept-Language": "it-IT,it;q=0.9,en;q=0.5",
}

def fetch_page(url: str, timeout: int = 20) -> BeautifulSoup:
    resp = requests.get(url, headers=HEADERS, timeout=timeout)
    resp.raise_for_status()
    return BeautifulSoup(resp.text, "html.parser")


# ── Date patterns ───────────────────────────────────────────────────────────

MONTHS_IT = {
    "gennaio": 1, "febbraio": 2, "marzo": 3, "aprile": 4,
    "maggio": 5, "giugno": 6, "luglio": 7, "agosto": 8,
    "settembre": 9, "ottobre": 10, "novembre": 11, "dicembre": 12,
}
MONTHS_IT_SHORT = {
    "gen": 1, "feb": 2, "mar": 3, "apr": 4, "mag": 5, "giu": 6,
    "lug": 7, "ago": 8, "set": 9, "ott": 10, "nov": 11, "dic": 12,
}

RE_DATE_LONG   = re.compile(r"\b(\d{1,2})\s+(" + "|".join(MONTHS_IT) + r")\s+(\d{4})\b", re.I)
RE_DATE_SHORT  = re.compile(r"\b(\d{1,2})\s+(" + "|".join(MONTHS_IT_SHORT) + r")\s+(\d{4})\b", re.I)
RE_DATE_DOTTED = re.compile(r"\b(\d{1,2})\.(\d{2})\.(\d{4})\b")
RE_DATE_ISO    = re.compile(r"(\d{4})-(\d{2})-(\d{2})")

def _try_long(text):   m = RE_DATE_LONG.search(text);   return date(int(m[3]), MONTHS_IT[m[2].lower()],       int(m[1])) if m else None
def _try_short(text):  m = RE_DATE_SHORT.search(text);  return date(int(m[3]), MONTHS_IT_SHORT[m[2].lower()], int(m[1])) if m else None
def _try_dotted(text): m = RE_DATE_DOTTED.search(text); return date(int(m[3]), int(m[2]),                      int(m[1])) if m else None
def _try_iso(text):    m = RE_DATE_ISO.search(text);    return date(int(m[1]), int(m[2]),                      int(m[3])) if m else None

def find_date(text: str) -> date | None:
    return _try_long(text) or _try_short(text) or _try_dotted(text) or _try_iso(text)


# ── Extract location ─────────────────────────────────────────────────────────

RE_LOCATION = re.compile(r'-\s+([A-ZÀÈÉÌÒÙ][A-ZÀÈÉÌÒÙ\s]+?)\s+-\s+\d{2}:\d{2}')

def extract_location(soup: BeautifulSoup) -> str | None:
    tag = soup.find("div", class_="primo_suffisso")
    if not tag:
        return None
    m = RE_LOCATION.search(tag.get_text())
    return m.group(1).strip() if m else None


# ── Timestamp parsing ───────────────────────────────────────────────────────

RE_DURATA = re.compile(r'(\d+:\d+)\s+Durata:\s+(\d+)\s+min', re.I)
RE_INT_ID = re.compile(r'^int(\d+)$')
RE_D_SEC  = re.compile(r'^d(\d+)$')

def parse_timestamps(li, is_clock_time: bool = False, event_start: str | None = None) -> dict:
    result = {"int_id": None, "start_time": None, "duration_min": None, "duration_seconds": None}

    print(f"parse timestamps")
    print(f"is clock time = {is_clock_time}")
    print(f"event start = {event_start}")
    for cls in li.get("class", []):
        if m := RE_INT_ID.match(cls):
            result["int_id"] = int(m.group(1))
        if m := RE_D_SEC.match(cls):
            result["duration_seconds"] = int(m.group(1))

    durata_div = li.find("div", class_="durata")
    if durata_div:
        if m := RE_DURATA.search(durata_div.get_text()):
            raw_time = m.group(1)
            result["duration_min"] = int(m.group(2))
            
            if is_clock_time and event_start:
                h0, m0 = (int(x) for x in event_start.split(":"))
                h1, m1 = (int(x) for x in raw_time.split(":"))
                offset_min = (h1 * 60 + m1) - (h0 * 60 + m0)
                result["start_time"] = f"{offset_min // 60:02d}:{offset_min % 60:02d}"
            else:
                result["start_time"] = raw_time

    return result


# ── Date extraction ─────────────────────────────────────────────────────────

def extract_page_date(soup: BeautifulSoup) -> tuple[date | None, str]:
    """Page-level event date (meta > title > stamp > sommario prose)."""
    for attr, val in [("name", "dcterms.date"), ("property", "article:published_time")]:
        tag = soup.find("meta", {attr: val})
        if tag and tag.get("content"):
            d = _try_iso(tag["content"])
            if d: return d, "meta_tag"

    title = soup.find("title")
    if title:
        d = _try_dotted(title.get_text())
        if d: return d, "page_title"

    page_text = soup.get_text(" ", strip=True)
    d = _try_short(page_text)
    if d: return d, "page_stamp"

    d = _try_long(page_text)
    if d: return d, "page_sommario"

    return None, "not_found"


def extract_speaker_date(soup: BeautifulSoup, speaker: str) -> tuple[date | None, str]:
    """
    Per-speaker date, checked in priority order:
      1. The speaker's own int_subtext
      2. The preceding li's int_subtext (introduction pattern,
         e.g. 'L\'on. Fanfani a una conferenza stampa del 22 marzo 1962')
      3. Any date anywhere in the speaker's <li> block
    Only uses the FIRST occurrence of the speaker for date purposes.
    """
    items = [li for li in soup.select("li.intervento") if li.find("h2")]

    for idx, li in enumerate(items):
        if speaker.lower() not in li.find("h2").get_text().lower():
            continue

        subtext = li.find("div", class_="int_subtext")
        if subtext:
            d = find_date(subtext.get_text())
            if d: return d, "speaker_subtext"

        if idx > 0:
            prev_subtext = items[idx - 1].find("div", class_="int_subtext")
            if prev_subtext:
                text = prev_subtext.get_text()
                if speaker.lower() in text.lower():
                    d = find_date(text)
                    if d: return d, "preceding_subtext"

        d = find_date(li.get_text(" ", strip=True))
        if d: return d, "speaker_block"

        return None, "speaker_block_no_date"

    return None, "speaker_not_found"


# ── Main ────────────────────────────────────────────────────────────────────


def extract_speech_details(url: str, speaker: str, timeout: int = 20) -> dict:
    result = dict(
        url=url, speaker_query=speaker, speaker_found=False,
        speech_date=None, date_source=None, page_event_date=None,
        interventions=[],
        error=None,
    )
    try:
        soup = fetch_page(url, timeout=timeout)
    except Exception as e:
        result["error"] = str(e)
        return result

    page_date, page_src = extract_page_date(soup)
    if page_date:
        result["page_event_date"] = page_date.isoformat()

    location = extract_location(soup)
    result["location"] = location if (location is not None and location != "RADIO") else "UNKNOWN"

    # Extract event_start from the first intervento on the page
    event_start = None
    first_li = soup.select_one("li.intervento")
    if first_li:
        durata_div = first_li.find("div", class_="durata")
        if durata_div:
            m = RE_DURATA.search(durata_div.get_text())
            if m:
                event_start = m.group(1)
                
    if (event_start == "0:00"):
        is_clock_time = False
        print(f"Timestamps format not clock eg 0:00 -> 0:30")
    else:
        is_clock_time = True
        print(f"Timestamps format clock eg 17:00 -> 17:30")

    
    # Collect ALL occurrences of the speaker
    for li in soup.select("li.intervento"):
        h2 = li.find("h2")
        if h2 and speaker.lower() in h2.get_text().lower():
            result["speaker_found"] = True
            ts = parse_timestamps(li, is_clock_time=is_clock_time, event_start=event_start)
            if ts["start_time"] or ts["duration_seconds"] is not None:
                result["interventions"].append(ts)

    if not result["speaker_found"]:
        result["error"] = f"'{speaker}' not found in interventi"
        result["date_source"] = "llm_needed"
        return result

    if not result["interventions"]:
        result["interventions"] = "no timestamps"

    spk_date, spk_src = extract_speaker_date(soup, speaker)
    if spk_date:
        result["speech_date"] = spk_date.isoformat()
        result["date_source"] = spk_src
    elif page_date:
        result["speech_date"] = page_date.isoformat()
        result["date_source"] = f"page_event ({page_src})"
    else:
        result["date_source"] = "llm_needed"

    return result


#----------------------------- Trim audio to politician timestamps ----------------------------


def trim_to_speaker(audio_filename: str, interventions: list, AUDIO_DIR) -> Path:
    """
    Given a list of interventions (from extract()), concatenate only the
    speaker's segments back-to-back and overwrite the original file.
    
    audio_filename must be a string like "85823_politician.mp3"
    interventions is r["interventions"] — list of dicts with start_time (h:mm)
    and duration_seconds.
    """
    print(f"trim_to_speaker(audio_filename = {audio_filename}, interventions: list) -> Path:")
    input_path = Path(AUDIO_DIR) / audio_filename

    def hhmm_to_seconds(t: str) -> int:
        h, m = t.split(":")
        return int(h) * 3600 + int(m) * 60

    # Build one -ss/-t segment filter per intervention
    # Using ffmpeg's trim+adelay approach is complex; simpler: extract each
    # segment to a temp file, then concatenate with concat demuxer
    tmp_files = []
    for i, iv in enumerate(interventions):
        tmp = input_path.with_name(f"_tmp_{i}_{input_path.name}")
        start_sec = hhmm_to_seconds(iv["start_time"])
        cmd = [
            "ffmpeg", "-y",
            "-ss", str(start_sec),
            "-i", str(input_path),
            "-t", str(iv["duration_seconds"]),
            "-acodec", "copy",
            str(tmp),
        ]
        subprocess.run(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        tmp_files.append(tmp)

    # Write concat list file
    concat_list = input_path.with_name("_concat_list.txt")
    concat_list.write_text("\n".join(f"file '{f.name}'" for f in tmp_files))

    # Concatenate into a temp output, then overwrite original
    tmp_out = input_path.with_name(f"_out_{input_path.name}")
    cmd = [
        "ffmpeg", "-y",
        "-f", "concat", "-safe", "0",
        "-i", str(concat_list),
        "-acodec", "copy",
        str(tmp_out),
    ]
    subprocess.run(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    # Cleanup temps, overwrite original
    for f in tmp_files:
        f.unlink(missing_ok=True)
    concat_list.unlink(missing_ok=True)
    if False:                               # replace or create a new one
        trimmed_path = input_path.with_stem(input_path.stem + "_trimmed")   
        tmp_out.replace(trimmed_path)
    else:
        tmp_out.replace(input_path)

    return input_path


#---------------------------- Speech to text ----------------------------------


def speech_to_text(audio_metadata, speech_details, audio_path, politician, OUT_DIR, AUDIO_DIR, CSV_DIR, url):

    historical_date = speech_details["speech_date"]
    location = speech_details["location"]
    title = audio_metadata["fulltitle"]
    file_id = audio_metadata["file_id"]
    filename = audio_metadata["filename"]


    output_dir  = str(Path(OUT_DIR) / f"output-{model_name}")
    audio_file  = str(Path(AUDIO_DIR) / filename)
    csv_output  = str(Path(CSV_DIR) / f"{file_id}_{politician}_s2t.csv")


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


#------------------------------ URLs scraper ---------------------------------

# Category filter values to scrape (skipping 1=Istituzioni and All)
# To scrape all either scrape "Tutti" so only one category or add "Istituzioni : 1,"
CATEGORIES = {
    "Dibattiti":     2,
    "Rubriche":      3,
    "Interviste":    4,
    "Manifestazioni":5,
    "Processi":      6,
    "Partiti":       7,
}

HEADERS = {
    "User-Agent": (
        "Mozilla/5.0 (X11; Linux x86_64) "
        "AppleWebKit/537.36 (KHTML, like Gecko) "
        "Chrome/124.0 Safari/537.36"
    )
}


def _scrape_category(session: requests.Session, cat_value: int, SUBJECT_URL) -> list[str]:
    """Scrape all audio scheda URLs for one category, following pagination."""
    urls: list[str] = []
    page = 0

    while True:
        params = {"field_registrazione_raggruppamenti_radio": cat_value, "page": page}
        resp = session.get(SUBJECT_URL, params=params, headers=HEADERS, timeout=20)
        resp.raise_for_status()

        soup = BeautifulSoup(resp.text, "html.parser")

        # Each audio entry: <li class="views-row ...">
        #   <div class="ls_text"><h3><a href="/scheda/...?i=...">
        for li in soup.select("ol.lista_list li.views-row"):
            # Only rows that have audio
            if not li.select_one("div.tipo_media.audio"):
                continue
            a = li.select_one("div.ls_text h3 a")
            if a and a.get("href"):
                full_url = urljoin(BASE_URL, a["href"])
                urls.append(full_url)

        # Check for a "next page" link
        next_link = soup.select_one("li.pager__item--next a")
        if not next_link:
            break

        page += 1
        time.sleep(0.5)   # be polite

    return urls


def get_all_audio_urls(
    categories: dict[str, int] | None = None,
    verbose: bool = True,
    SUBJECT_URL: str = "."
) -> list[str]:
    """
    Scrape all Politician audio scheda URLs from Radio Radicale.

    Parameters
    ----------
    categories : dict mapping label → filter value (defaults to the six
                 non-Istituzioni categories defined at module level).
    verbose    : print progress info.

    Returns
    -------
    Deduplicated list of absolute scheda URLs, e.g.
    ['https://www.radioradicale.it/scheda/55884/...?i=2447650', ...]
    """
    if categories is None:
        categories = CATEGORIES

    session = requests.Session()
    all_urls: list[str] = []
    seen_paths: set[str] = set()   # keyed on URL path, ignoring ?i=

    for label, value in categories.items():
        if verbose:
            print(f"  Scraping category: {label} (value={value}) …", flush=True)
        cat_urls = _scrape_category(session, value, SUBJECT_URL)
        new = []
        for u in cat_urls:
            path = u.split("?")[0]
            if path not in seen_paths:
                seen_paths.add(path)
                new.append(u)
        all_urls.extend(new)
        if verbose:
            print(f"    → {len(cat_urls)} found, {len(new)} new (total so far: {len(all_urls)})")

    if verbose:
        print(f"\nDone. {len(all_urls)} unique audio URLs collected.")

    return all_urls

#-----------------------------------------------------------------------------------------------#
#------------------------------------------ RUN ------------------------------------------------#
#-----------------------------------------------------------------------------------------------#

# ── Run ─────────────────────────────────────────────────────────────────────
#urls = ["https://www.radioradicale.it/scheda/265208/andreotti-la-vita-di-un-uomo-politico-la-storia-di-unepoca?i=735960"]
import glob
from time import sleep

def gitall(politician, repo: str = BASE_DIR) -> None:
    cmds = [
        ["git", "add", "."],
        ["git", "commit", "-m", f"periodic commit: {politician}"],
        ["git", "push"],
    ]
    for cmd in cmds:
        result = subprocess.run(cmd, cwd=repo, capture_output=True, text=True)
        if result.returncode != 0:
            print(f"[{' '.join(cmd)}] failed:\n{result.stderr}")
            return
    print(f"[git] periodic commiT")

def trim_to_1s(audio_dir):
    for audio_file in Path(audio_dir).glob("*.mp3"):  # adjust extension as needed
        tmp = audio_file.with_suffix(".tmp.mp3")
        subprocess.run([
            "ffmpeg", "-y",
            "-i", str(audio_file),
            "-t", "1",          # trim to 1 second
            "-c", "copy",       # no re-encode (fast)
            str(tmp)
        ], check=True)
        tmp.rename(audio_file)  # overwrite original

def get_processed_ids(output_dir):
    processed = set()
    for path in glob.glob(os.path.join(output_dir, "*_*.mp3")):
        stem = os.path.splitext(os.path.basename(path))[0]
        scheda_id = stem.split("_")[0]
        processed.add(scheda_id)
    return processed

def extract_id_from_url(url):
    """Extract the scheda ID from a Radio Radicale URL."""
    # e.g. /scheda/58768/... → "58768"
    parts = url.split("/scheda/")
    if len(parts) > 1:
        return parts[1].split("/")[0]
    return None

def log_discard(url, exc):
    with open(DISCARD_LOG, "a") as f:
        f.write(f"{url}  {type(exc).__name__}: {exc}\n")

def main (politician, SUBJECT_URL):

    global last_commit
    OUT_DIR = os.path.join(BASE_DIR, f"datasets/{politician}")
    AUDIO_DIR = os.path.join(OUT_DIR, f"audio_out")
    CSV_DIR = os.path.join(OUT_DIR, f"csv_out")

    if testing:
        OUT_DIR = os.path.join(BASE_DIR, "notebooks/out")
        AUDIO_DIR = OUT_DIR
        CSV_DIR = OUT_DIR

    os.makedirs(OUT_DIR, exist_ok=True)
    os.makedirs(AUDIO_DIR, exist_ok=True)
    os.makedirs(CSV_DIR, exist_ok=True)
    
    print(f"-------------------- Politician = {politician} --------------------")

    urls = get_all_audio_urls(SUBJECT_URL=SUBJECT_URL)

    for url in urls:
        """
        One audio at a time, extract date and timestamps, then download, then trim it based on extracted timestamps, 
        then transcribe it with OpenAI Whisper and finally save it in a unique CSV file.
        """
        processed_ids = get_processed_ids(AUDIO_DIR)
        scheda_id = extract_id_from_url(url)
        if scheda_id in processed_ids:
            print(f"Skipping {scheda_id}, already processed.")
            continue

        print(f"Processing {url}")
        try:
            speech_details = extract_speech_details(url, speaker=politician)
            for key, value in speech_details.items():
                print(f"{key:<18} {value}")
            timestamps = speech_details["interventions"]
            if any(i["start_time"] is None for i in timestamps):
                raise ValueError("No timestamps")
            audio_metadata = download_audio_subprocess(url, AUDIO_DIR, politician)
            sleep(1)
            audio_path = trim_to_speaker(audio_metadata["filename"], timestamps, AUDIO_DIR)
            speech_to_text(audio_metadata, speech_details, audio_path, politician, OUT_DIR, AUDIO_DIR, CSV_DIR, url)
            trim_to_1s(AUDIO_DIR)
            if time.time() - last_commit >= 3600:
                gitall(politician)
                last_commit = time.time()
        except Exception as e:
            log_discard(url, e)
            print(f"  ✗ Failed: {e}")
            continue

if __name__ == "__main__":
    for politician, SUBJECT_URL in DATA:
        main(politician, f"{BASE_URL}/{SUBJECT_URL}")