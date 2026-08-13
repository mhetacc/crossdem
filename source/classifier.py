"""
classify_corpus_split.py

Same as classify_corpus_qwen.py, but the four crossdem label columns are now
produced by TWO different local LLMs instead of one:

    hate_speech, negativity, aggressiveness  -> Gemma  (OLLAMA_MODEL_LEVELS)
    target                                   -> Qwen   (OLLAMA_MODEL_TARGET)

Each speech is checked independently for each group of columns, so:
  - a speech missing only "target" gets ONE call (to the target model)
  - a speech missing only level cols gets ONE call (to the level model)
  - a speech missing everything gets TWO calls (one per model)
  - a speech that already has all 4 fields filled is skipped entirely, as
    before -> the script stays resumable.

Everything else (file discovery, CSV read/write, retry logic, verbosity)
is unchanged from classify_corpus_qwen.py.

REQUIRES YOU TO CHECK / EDIT:
1. TEXT_COL / "text" column assumption (see original script's note).
2. OLLAMA_MODEL_LEVELS / OLLAMA_MODEL_TARGET tags below — verify the exact
   local tags with `ollama list`. "gemma4" and "qwen 3.5" aren't tags I
   recognize; I've defaulted to gemma3:4b and qwen3:4b as the closest real
   models — swap these strings if your local tags differ.
3. POLITICIANS_TO_PROCESS — defaults to every key in POL_INFO.

Install deps:
    pip install ollama

Usage:
    $ cd ~/crossdem/source/ && source ~/crossdem/venv/bin/activate && python3 classify_corpus_split.py
"""

import os
import csv
import json
import time
import glob
from ollama import Client
import pandas

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath("__file__")))  # go to ~/crossdem/ by jumping up twice
DATA_DIR = os.path.join(BASE_DIR, "datasets")
PMS_DIR = os.path.join(DATA_DIR, "prime_ministers")
VALIDATION_DIR = os.path.join(DATA_DIR, "prime_ministers_validation")
IMGS_DIR = os.path.join(os.getcwd(), "imgs")

os.makedirs(IMGS_DIR, exist_ok=True)

POL_INFO = {
    "degasperi":   {"leaning": "C",  "color": "#2f4f4f"},
    "fanfani":     {"leaning": "CL", "color": "#e6194B"},
    "leone":       {"leaning": "C",  "color": "#ff4500"},
    "rumor":       {"leaning": "C",  "color": "#7f0067"},
    "colombo":     {"leaning": "C",  "color": "#008080"},
    "andreotti":   {"leaning": "CR", "color": "#c00000"},
    "cossiga":     {"leaning": "CR", "color": "#e6beff"},
    "forlani":     {"leaning": "CR", "color": "#ffe119"},
    "spadolini":   {"leaning": "C",  "color": "#a9a9a9"},
    "craxi":       {"leaning": "CL", "color": "#ffd8b1"},
    "goria":       {"leaning": "C",  "color": "#000075"},
    "demita":      {"leaning": "CL", "color": "#808000"},
    "amato":       {"leaning": "L",  "color": "#aaffc3"},
    "ciampi":      {"leaning": "C",  "color": "#9A6324"},
    "berlusconi":  {"leaning": "R",  "color": "#800000"},
    "dini":        {"leaning": "CL", "color": "#fabed4"},
    "prodi":       {"leaning": "CL", "color": "#469990"},
    "dalema":      {"leaning": "L",  "color": "#dcbeff"},
    "monti":       {"leaning": "CR", "color": "#bfef45"},
    "letta":       {"leaning": "L",  "color": "#f032e6"},
    "renzi":       {"leaning": "CL", "color": "#42d4f4"},
    "gentiloni":   {"leaning": "CL", "color": "#911eb4"},
    "conte":       {"leaning": "CL", "color": "#f58231"},
    "draghi":      {"leaning": "C",  "color": "#3cb44b"},
    "meloni":      {"leaning": "R",  "color": "#4363d8"},
}

POL_INFO = {
    "gentiloni":   {"leaning": "CL", "color": "#911eb4"},
}

DISPLAY_NAME_OVERRIDES = {
    "dalema": "D'Alema",
    "demita": "De Mita",
    "degasperi": "De Gasperi"
}

def display_name(pol):
    return DISPLAY_NAME_OVERRIDES.get(pol, pol.capitalize())

CHECK_INTEGRITY = False

# --------------------------------------------------------------------------- #
# CONFIG — check this section before running
# --------------------------------------------------------------------------- #

LEVEL_COLS = ["hate_speech", "negativity", "aggressiveness"]
TARGET_COLS = ["target"]
LABEL_COLS = LEVEL_COLS + TARGET_COLS  # kept for reference / full-row checks

LEVEL_VALUES = ["low", "mid", "high"]
TARGET_VALUES = ["none", "pol_adv", "minor_etn", "minor_gnd", "minor_rel"]

# <-- CHECK these exact local tags with `ollama list`. Best-guess mapping:
#     "gemma4 e4b"   -> gemma3:4b
#     "qwen 3.5 4b"  -> qwen3:4b  (Qwen has no "3.5" line; Qwen3 4B is the
#                                  closest real model)
OLLAMA_MODEL_LEVELS = "gemma4:e4b"
OLLAMA_MODEL_TARGET = "qwen3.5:4b"

RETRIES = 3
RETRY_SLEEP_S = 2

# --- verbosity ---
VERBOSE = True
PRINT_TEXT_CHARS = 400  # set to None to print the full speech text every call

POLITICIANS_TO_PROCESS = list(POL_INFO.keys())

client = Client()  # assumes `ollama serve` is running locally

# --------------------------------------------------------------------------- #
# PROMPTS — split from the original combined SYSTEM_PROMPT
# --------------------------------------------------------------------------- #

RUBRIC_HEADER = """Sei un annotatore esperto di scienze politiche e linguistica computazionale.
Il tuo compito è classificare un discorso pronunciato da un Presidente del Consiglio italiano."""

SYSTEM_PROMPT_LEVELS = RUBRIC_HEADER + """

---
### DIMENSIONI E CATEGORIE

1) hate_speech: presenza di incitamento all'odio verso individui o gruppi protetti.
   - low: assente o non significativa.
   - mid: presente in forma velata, allusiva, tramite "dog whistles" o pregiudizi impliciti.
   - high: presente in forma esplicita, deumanizzante o aperta ostilità sistematica.

2) negativity: tono complessivo negativo del discorso (critica, pessimismo, minacce percepite, allarmismo).
   - low: tono prevalentemente neutro, costruttivo o positivo.
   - mid: presenza moderata di toni critici o allarmi su specifici problemi nazionali.
   - high: tono fortemente cupo, allarmista, focalizzato su crisi imminenti o declino.

3) aggressiveness: aggressività verbale, toni polemici o ostili verso interlocutori/avversari.
   - low: tono pacato, formale, istituzionale.
   - mid: presenza moderata di polemica, velate stoccate o sarcasmo istituzionale.
   - high: tono marcatamente polemico, attacchi diretti e personali, linguaggio di scontro.

---
### ESEMPI GUIDA PER LA CALIBRAZIONE

#### Esempi per `hate_speech`:
- **low**:
  - "Dobbiamo investire nella scuola pubblica e garantire il salario minimo per sostenere le famiglie in difficoltà."
  - "La transizione ecologica richiede una visione industriale chiara che tuteli l'occupazione e le piccole imprese."
  - "Rafforzeremo il presidio del territorio e la cooperazione tra le forze dell'ordine e le comunità locali."
- **mid**:
  - "Non possiamo permettere che i valori della nostra civiltà vengano diluiti da chi arriva da fuori senza alcuna intenzione di assimilarsi."
  - "Certe culture tradizionaliste restano intrinsecamente incompatibili con la tutela dei diritti fondamentali e dello Stato di diritto."
  - "I quartieri storici stanno perdendo la propria identità a causa di una presenza straniera ormai dominante che rifiuta le nostre regole."
- **high**:
  - "L'immigrazione è un'invasione pianificata che porterà degrado e criminalità nelle nostre città. Bisogna eliminarla sistematicamente strada per strada, casa per casa."
  - "Questi gruppi parassitari infestano la nostra società e vanno estirpati prima che distruggano definitivamente la nostra razza e la nostra storia."
  - "Alcune minoranze sono portatrici biologiche di violenza e inciviltà: vanno cacciate con ogni mezzo dal nostro suolo patrio."

#### Esempi per `negativity`:
- **low**:
  - "I dati sull'occupazione sono incoraggianti e la crescita economica dimostra la resilienza del nostro tessuto produttivo."
  - "La riforma della giustizia procede spedita, restituendo efficienza e tempi certi a cittadini e imprese."
  - "Il nostro posizionamento internazionale si rafforza grazie a nuove partnership strategiche sull'energia."
- **mid**:
  - "I sistemi sanitario e scolastico presentano problematiche infrastrutturali apparentemente insanabili."
  - "L'instabilità geopolitica globale proietta ombre preoccupanti sull'approvvigionamento delle nostre materie prime."
  - "La burocrazia soffocante e i tempi della giustizia civile continuano a frenare gli investimenti esteri nel Paese."
- **high**:
  - "Il paese è sull'orlo del baratro finanziario; ereditiamo un disastro sistemico che rischia di spazzare via i risparmi degli italiani."
  - "Siamo di fronte a un declino demografico e sociale irreversibile che sta portando la Nazione alla completa estinzione."
  - "Il collasso della sicurezza urbana ha trasformato le nostre metropoli in zone di guerra allo sbaraglio."

#### Esempi per `aggressiveness`:
- **low**:
  - "Accogliamo le osservazioni delle opposizioni nel merito, tuttavia il Governo continuerà con la linea dettata dagli elettori."
  - "Il confronto parlamentare è la sede naturale per affinare i testi di legge nell'interesse generale."
  - "Valuteremo con attenzione tutti gli emendamenti proposti dalle forze di minoranza durante il percorso in commissione."
- **mid**:
  - "Riconosco il diritto dell'opposizione di protestare, anche se la loro memoria storica appare alquanto corta e di comodo."
  - "Ci danno lezioni di rigore di bilancio gli stessi banchieri e tecnocrati che hanno affossato i conti pubblici nel decennio scorso."
  - "Spiace constatare come parte dei media preferisca la polemica strumentale all'analisi obiettiva dei fatti."
- **high**:
  - "Dall'opposizione arrivano solo menzogne sfrontate e sciacallaggio politico da parte di chi ha svenduto la nazione per anni."
  - "Siete dei traditori del popolo italiano, dei cospiratori servili che prendono ordini da potenze e burocrazie straniere."
  - "La vostra ipocrisia fa schifo: avete le mani sporche di sangue per le politiche criminali che avete approvato!"

---
### FORMATO DI OUTPUT

Rispondi ESCLUSIVAMENTE con un oggetto JSON con queste tre chiavi, senza testo
aggiuntivo, markdown o spiegazioni."""

SYSTEM_PROMPT_TARGET = RUBRIC_HEADER + """

---
### DIMENSIONE E CATEGORIE

target: il bersaglio principale di eventuale ostilità/critica nel discorso (assegna il target
anche se il discorso è nel complesso pacato, identificando verso chi è orientato).
   - none: nessun bersaglio specifico identificabile.
   - pol_adv: avversari politici, opposizioni, partiti, burocrazia europea o altre istituzioni.
   - minor_etn: minoranze etniche, persone straniere, migranti di specifiche etnie.
   - minor_gnd: minoranze di genere, donne, comunità LGBTQ+.
   - minor_rel: minoranze religiose (es. musulmani, ebrei).

---
### ESEMPI GUIDA PER LA CALIBRAZIONE

#### Esempi per `target`:
- **none**:
  - "Oggi approviamo la riforma del codice della strada per ridurre gli incidenti e tutelare i giovani."
  - "Il piano di digitalizzazione della pubblica amministrazione consentirà di ridurre radicalmente i tempi di attesa."
  - "I finanziamenti per la prevenzione del dissesto idrogeologico copriranno tutte le regioni a rischio."
- **pol_adv**:
  - "La precedente maggioranza ha lasciato buchi di bilancio incalcolabili per fare propaganda elettorale."
  - "L'Unione Europea pretende di imporre direttive ideologiche che penalizzano le nostre filiere produttive nazionali."
  - "La magistratura politicamente orientata continua a travalicare i propri confini costituzionali per ostacolare l'esecutivo."
- **minor_etn**:
  - "È necessario bloccare le partenze e combattere le reti di clandestinità che destabilizzano la sicurezza nazionale."
  - "Certi flussi migratori incontrollati provenienti dall'Africa subsahariana importano modelli criminali inaccettabili."
  - "Non tollereremo zone di franchigia gestite da bande etniche straniere nelle periferie dei nostri capoluoghi."
- **minor_gnd**:
  - "Ci opporremo a chi vuole scardinare la famiglia naturale imponendo teorie ideologiche nelle scuole."
  - "La propaganda sull'identità di genere mira a cancellare la figura della madre e il ruolo biologico della donna."
  - "I diritti delle donne vengono calpestati dall'ossessione per il politicamente corretto e la fluidità di genere."
- **minor_rel**:
  - "Alcune comunità religiose pretendono di applicare le proprie leggi teocratiche sul nostro territorio nazionale."
  - "Il proliferare di centri di preghiera abusivi legati all'Islam radicale rappresenta una minaccia diretta ai nostri valori laici."
  - "Non faremo concessioni a chi usa il proprio culto per giustificare la sottomissione femminile e l'odio verso l'Occidente."

---
### FORMATO DI OUTPUT

Rispondi ESCLUSIVAMENTE con un oggetto JSON con questa unica chiave, senza testo
aggiuntivo, markdown o spiegazioni."""

JSON_SCHEMA_LEVELS = {
    "type": "object",
    "properties": {
        "hate_speech": {"type": "string", "enum": LEVEL_VALUES},
        "negativity": {"type": "string", "enum": LEVEL_VALUES},
        "aggressiveness": {"type": "string", "enum": LEVEL_VALUES},
    },
    "required": LEVEL_COLS,
}

JSON_SCHEMA_TARGET = {
    "type": "object",
    "properties": {
        "target": {"type": "string", "enum": TARGET_VALUES},
    },
    "required": TARGET_COLS,
}


# --------------------------------------------------------------------------- #
# File discovery
# --------------------------------------------------------------------------- #
def find_speech_files() -> list:
    files = []
    for pol in POLITICIANS_TO_PROCESS:
        if pol == 'degasperi':
            pattern = os.path.join(PMS_DIR, pol, "degasperi_speeches.csv")
        else:
            pattern = os.path.join(PMS_DIR, pol, "csv_out", "*.csv")
        matches = sorted(glob.glob(pattern))
        if not matches:
            continue
        files.extend(matches)
    return files

# --------------------------------------------------------------------------- #
# Row helpers
# --------------------------------------------------------------------------- #

def _cols_missing(row: dict, cols: list) -> bool:
    """True if any of `cols` is missing from the row, or empty/blank."""
    for col in cols:
        val = row.get(col)
        if val is None:
            return True
        if str(val).strip() == "":
            return True
    return False


def needs_level_classification(row: dict) -> bool:
    return _cols_missing(row, LEVEL_COLS)


def needs_target_classification(row: dict) -> bool:
    return _cols_missing(row, TARGET_COLS)


def read_speech_csv(path: str):
    with open(path, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        rows = list(reader)
        fieldnames = list(reader.fieldnames or [])
    return rows, fieldnames


def write_speech_csv(path: str, rows: list, fieldnames: list):
    out_fieldnames = list(fieldnames)
    for col in LABEL_COLS:
        if col not in out_fieldnames:
            out_fieldnames.append(col)

    with open(path, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=out_fieldnames)
        writer.writeheader()
        writer.writerows(rows)


# --------------------------------------------------------------------------- #
# Classification
# --------------------------------------------------------------------------- #

def classify_one(text: str, path: str, *, model: str, system_prompt: str,
                  schema: dict, valid_cols: dict, tag: str,
                  think: bool | None = None) -> dict | None:
    """
    Generic single-call classifier.
    valid_cols: {col_name: [allowed values]} — used to validate the response.
    tag: short label for log lines, e.g. "gemma3:4b levels" / "qwen3:4b target".
    think: pass False for Qwen3-family models to suppress reasoning tokens
           (they otherwise return empty/garbage `content` with the reasoning
           in `message.thinking` instead). Leave None for non-thinking models.
    """
    for attempt in range(1, RETRIES + 1):
        if VERBOSE:
            preview = text if PRINT_TEXT_CHARS is None else text[:PRINT_TEXT_CHARS]
            truncated_note = "" if PRINT_TEXT_CHARS is None or len(text) <= PRINT_TEXT_CHARS else " [truncated]"
            print(f"\n{'=' * 80}")
            print(f"[{tag}] {path}  attempt {attempt}/{RETRIES}")
            print(f"--- PROMPT FED TO MODEL ({len(text)} chars{truncated_note}) ---")
            print(preview)

        try:
            chat_kwargs = dict(
                model=model,
                messages=[
                    {"role": "system", "content": system_prompt},
                    {"role": "user", "content": text},
                ],
                format=schema,
                options={"temperature": 0},
            )
            if think is not None:
                chat_kwargs["think"] = think

            resp = client.chat(**chat_kwargs)
            raw = resp["message"]["content"]

            if VERBOSE:
                print(f"--- RAW MODEL OUTPUT ---\n{raw}")

            parsed = json.loads(raw)
            for col, allowed in valid_cols.items():
                assert parsed[col] in allowed

            if VERBOSE:
                print(f"--- PARSED PREDICTION --- {parsed}")

            return parsed
        except Exception as e:
            print(f"  [{tag}] {path} attempt {attempt}/{RETRIES} failed: {e}")
            time.sleep(RETRY_SLEEP_S)
    return None


def classify_levels(text: str, path: str) -> dict | None:
    return classify_one(
        text, path,
        model=OLLAMA_MODEL_LEVELS,
        system_prompt=SYSTEM_PROMPT_LEVELS,
        schema=JSON_SCHEMA_LEVELS,
        valid_cols={c: LEVEL_VALUES for c in LEVEL_COLS},
        tag=f"{OLLAMA_MODEL_LEVELS} levels",
    )


def classify_target(text: str, path: str) -> dict | None:
    return classify_one(
        text, path,
        model=OLLAMA_MODEL_TARGET,
        system_prompt=SYSTEM_PROMPT_TARGET,
        schema=JSON_SCHEMA_TARGET,
        valid_cols={"target": TARGET_VALUES},
        tag=f"{OLLAMA_MODEL_TARGET} target",
        think=False,  # Qwen3 needs this or content comes back empty
    )


# --------------------------------------------------------------------------- #
# Main
# --------------------------------------------------------------------------- #

def run_pass(files: list, *, group_label: str, model_tag: str,
             needs_fn, classify_fn) -> dict:
    """
    One full sweep over every speech file, filling in ONLY the columns this
    pass is responsible for (per needs_fn). Keeping this to a single model
    for the whole pass means Ollama loads it once and doesn't swap it out of
    GPU memory mid-corpus.
    """
    print(f"\n----- PASS: {group_label} ({model_tag}) -----")

    stats = dict(skipped_already=0, skipped_no_text=0, classified=0,
                 failed=0, files_saved=0)

    for path in files:
        try:
            rows, fieldnames = read_speech_csv(path)
        except Exception as e:
            print(f"  [SKIP] could not read {path}: {e}")
            continue

        if not rows:
            print(f"  [SKIP] {path} is empty.")
            continue

        file_changed = False

        for row in rows:
            if not needs_fn(row):
                stats["skipped_already"] += 1
                continue

            text = (row.get("text") or "").strip()
            if not text:
                print(f"  [SKIP] {path}: empty 'text' field, cannot classify.")
                stats["skipped_no_text"] += 1
                continue

            result = classify_fn(text, path)
            if result is None:
                print(f"  [FAIL] {model_tag} giving up on {path} after {RETRIES} retries.")
                stats["failed"] += 1
            else:
                row.update(result)
                file_changed = True
                stats["classified"] += 1

        if file_changed:
            write_speech_csv(path, rows, fieldnames)
            stats["files_saved"] += 1
            print(f"  [SAVED] {path}")

    return stats


def main():
    files = find_speech_files()
    print(f"Found {len(files)} speech files under csv_out/ across {len(POLITICIANS_TO_PROCESS)} politicians.")
    print(f"Levels model: {OLLAMA_MODEL_LEVELS}  |  Target model: {OLLAMA_MODEL_TARGET}")

    # Pass 1: every level (hate_speech/negativity/aggressiveness) call, one
    # model loaded for the whole sweep.
    levels_stats = run_pass(
        files,
        group_label="hate_speech / negativity / aggressiveness",
        model_tag=OLLAMA_MODEL_LEVELS,
        needs_fn=needs_level_classification,
        classify_fn=classify_levels,
    )

    # Pass 2: every target call. By the time this starts, Ollama only needs
    # to swap models once (Gemma -> Qwen) instead of per-row.
    target_stats = run_pass(
        files,
        group_label="target",
        model_tag=OLLAMA_MODEL_TARGET,
        needs_fn=needs_target_classification,
        classify_fn=classify_target,
    )

    print("\n===== SUMMARY =====")
    print(f"Files scanned:                    {len(files)}")
    print(f"Files rewritten (levels pass):     {levels_stats['files_saved']}")
    print(f"Files rewritten (target pass):     {target_stats['files_saved']}")
    print(f"Speeches: levels labeled:          {levels_stats['classified']}  ({OLLAMA_MODEL_LEVELS})")
    print(f"Speeches: target labeled:          {target_stats['classified']}  ({OLLAMA_MODEL_TARGET})")
    print(f"Already labeled, levels pass:      {levels_stats['skipped_already']}")
    print(f"Already labeled, target pass:      {target_stats['skipped_already']}")
    print(f"Empty text (skip), levels pass:    {levels_stats['skipped_no_text']}")
    print(f"Empty text (skip), target pass:    {target_stats['skipped_no_text']}")
    print(f"Failed calls after retries:        {levels_stats['failed'] + target_stats['failed']}")


if __name__ == "__main__":
    main()