"""
classify_corpus_qwen.py

Walks every per-speech CSV in PMS_DIR/<politician>/csv_out/*.csv and, for any
speech that is MISSING (or has empty) one or more of the four crossdem label
columns:

    hate_speech     : low | mid | high
    negativity      : low | mid | high
    aggressiveness  : low | mid | high
    target          : none | pol_adv | minor_etn | minor_gnd | minor_rel

...classifies it with Qwen2.5-7B-Instruct (via Ollama) and writes the labels
back into that SAME csv file, overwriting it in place. Speeches that already
have all four fields filled are left untouched (skipped) — so the script is
naturally resumable: re-running it only processes what's left to do.

"Overwriting" here means: the row's 4 label columns are added/updated and the
file is rewritten with the same rows + (possibly new) header. Everything else
in the row is preserved as-is.

Assumes BASE_DIR / DATA_DIR / PMS_DIR / POL_INFO are already defined
(e.g. from your crossdem setup cell/module, see setup.py) before this
script/cell runs.

Design notes (mirrors compare_llm_classifiers.py):
- Uses Ollama's JSON-schema `format` param for grammar-constrained decoding.
- temperature=0 for reproducibility.
- VERBOSE=True prints, for every call: the file path, the text fed to the
  model, the raw model output, and the parsed prediction.
- Only Qwen is used here (compare_llm_classifiers.py already established it
  outperforms Mistral on your validation set).

REQUIRES YOU TO CHECK / EDIT:
1. TEXT_COL below — the column holding the speech transcript in your
   csv_out files (may differ from the validation CSVs' "text" column —
   verify against an actual csv_out file before running).
2. OLLAMA_MODEL tag — verify with `ollama list`.
3. The RUBRIC text in SYSTEM_PROMPT should match your manual annotation
   rubric — kept identical to compare_llm_classifiers.py, update both
   together if you change it.
4. POLITICIANS_TO_PROCESS — defaults to every key in POL_INFO. Trim this
   list if you only want to (re)run a subset.

Install deps:
    pip install ollama

Usage:
    python classify_corpus_qwen.py
"""

import os
import csv
import json
import time
import glob
from ollama import Client
import pandas
import glob
import time
import json
import csv
import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath("__file__")))  # go to ~/crossdem/ by jumping up twice
DATA_DIR = os.path.join(BASE_DIR, "datasets")
PMS_DIR = os.path.join(DATA_DIR, "prime_ministers")
VALIDATION_DIR = os.path.join(DATA_DIR, "prime_ministers_validation")
IMGS_DIR = os.path.join(os.getcwd(), "imgs")

os.makedirs(IMGS_DIR, exist_ok=True)

# De Gasperi was not scraped, a dataset with all speeches was taken from https://github.com/StefanoMenini/De-Gasperi-s-Corpus/
#degasperi_df = pandas.read_csv(f"{DATA_DIR}/degasperi/degasperi_speeches.csv")

POL_INFO = {
    "degasperi":   {"leaning": "C",  "color": "#2f4f4f"},  # dark slate grey — PM from 1945
    "fanfani":     {"leaning": "CL", "color": "#e6194B"},  # red — 1954
    #"scelba":      {"leaning": "CR", "color": "#8b4513"},  # saddle brown — 1954 (no data)
    #"segni":       {"leaning": "CR", "color": "#1e90ff"},  # dodger blue — 1955 (no data)
    "leone":       {"leaning": "C",  "color": "#ff4500"},  # orange-red — 1963
    #"moro":        {"leaning": "CL", "color": "#556b2f"},  # dark olive green — 1963 (no data)
    "rumor":       {"leaning": "C",  "color": "#7f0067"},  # deep magenta/plum — 1968
    "colombo":     {"leaning": "C",  "color": "#008080"},  # dark teal — 1970
    "andreotti":   {"leaning": "CR", "color": "#c00000"},  # bright crimson — 1972
    "cossiga":     {"leaning": "CR", "color": "#e6beff"},  # light violet — 1979
    "forlani":     {"leaning": "CR", "color": "#ffe119"},  # yellow — 1980
    "spadolini":   {"leaning": "C",  "color": "#a9a9a9"},  # grey — 1981
    "craxi":       {"leaning": "CL", "color": "#ffd8b1"},  # apricot — 1983
    "goria":       {"leaning": "C",  "color": "#000075"},  # navy — 1987
    "demita":     {"leaning": "CL", "color": "#808000"},  # olive — 1988
    "amato":       {"leaning": "L",  "color": "#aaffc3"},  # mint — 1992
    "ciampi":      {"leaning": "C",  "color": "#9A6324"},  # brown — 1993
    "berlusconi":  {"leaning": "R",  "color": "#800000"},  # dark red / maroon — 1994
    "dini":        {"leaning": "CL", "color": "#fabed4"},  # pink — 1995
    "prodi":       {"leaning": "CL", "color": "#469990"},  # teal — 1996
    "dalema":     {"leaning": "L",  "color": "#dcbeff"},  # lavender — 1998
    "monti":       {"leaning": "CR", "color": "#bfef45"},  # lime — 2011
    "letta":       {"leaning": "L",  "color": "#f032e6"},  # magenta — 2013
    "renzi":       {"leaning": "CL", "color": "#42d4f4"},  # cyan — 2014
    "gentiloni":   {"leaning": "CL", "color": "#911eb4"},  # purple — 2016
    "conte":       {"leaning": "CL", "color": "#f58231"},  # orange — 2018
    "draghi":      {"leaning": "C",  "color": "#3cb44b"},  # green — 2021
    "meloni":      {"leaning": "R",  "color": "#4363d8"},  # blue — 2022
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

LABEL_COLS = ["hate_speech", "negativity", "aggressiveness", "target"]

LEVEL_VALUES = ["low", "mid", "high"]
TARGET_VALUES = ["none", "pol_adv", "minor_etn", "minor_gnd", "minor_rel"]

OLLAMA_MODEL = "qwen2.5:7b-instruct-q4_K_M"   # <-- CHECK exact local tag

RETRIES = 3
RETRY_SLEEP_S = 2

# --- verbosity ---
VERBOSE = True
PRINT_TEXT_CHARS = 400  # set to None to print the full speech text every call

# which politician subfolders (under PMS_DIR) to walk; defaults to every
# politician in POL_INFO. Note: degasperi's and meloni's big combined CSVs
# (degasperi_speeches.csv / meloni_validation.csv) are NOT per-speech files
# and are intentionally not touched by this script — only PMS_DIR/<pol>/csv_out/*.csv

POLITICIANS_TO_PROCESS = list(POL_INFO.keys())
#POLITICIANS_TO_PROCESS = ['gentiloni']

client = Client()  # assumes `ollama serve` is running locally

# --------------------------------------------------------------------------- #
# PROMPT — identical to compare_llm_classifiers.py, keep both in sync
# --------------------------------------------------------------------------- #

SYSTEM_PROMPT = """Sei un annotatore esperto di scienze politiche e linguistica computazionale.
Il tuo compito è classificare un discorso pronunciato da un Presidente del Consiglio italiano secondo quattro dimensioni.

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

4) target: il bersaglio principale di eventuale ostilità/critica nel discorso (assegna il target anche se i punteggi sopra sono "low", identificando verso chi è orientato il discorso).
   - none: nessun bersaglio specifico identificabile.
   - pol_adv: avversari politici, opposizioni, partiti, burocrazia europea o altre istituzioni.
   - minor_etn: minoranze etniche, persone straniere, migranti di specifiche etnie.
   - minor_gnd: minoranze di genere, donne, comunità LGBTQ+.
   - minor_rel: minoranze religiose (es. musulmani, ebrei).

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

Rispondi ESCLUSIVAMENTE con un oggetto JSON con queste quattro chiavi, senza testo
aggiuntivo, markdown o spiegazioni."""

JSON_SCHEMA = {
    "type": "object",
    "properties": {
        "hate_speech": {"type": "string", "enum": LEVEL_VALUES},
        "negativity": {"type": "string", "enum": LEVEL_VALUES},
        "aggressiveness": {"type": "string", "enum": LEVEL_VALUES},
        "target": {"type": "string", "enum": TARGET_VALUES},
    },
    "required": ["hate_speech", "negativity", "aggressiveness", "target"],
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

def needs_classification(row: dict) -> bool:
    """True if any of the 4 label columns is missing from the row, or empty/blank."""
    for col in LABEL_COLS:
        val = row.get(col)
        if val is None:
            return True
        if str(val).strip() == "":
            return True
    return False


def read_speech_csv(path: str):
    with open(path, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        rows = list(reader)
        fieldnames = list(reader.fieldnames or [])
    return rows, fieldnames


def write_speech_csv(path: str, rows: list, fieldnames: list):
    # ensure the 4 label columns are present in the header (appended at the
    # end if they weren't already there), everything else preserved as-is
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

def classify_one(text: str, path: str) -> dict | None:
    for attempt in range(1, RETRIES + 1):
        if VERBOSE:
            preview = text if PRINT_TEXT_CHARS is None else text[:PRINT_TEXT_CHARS]
            truncated_note = "" if PRINT_TEXT_CHARS is None or len(text) <= PRINT_TEXT_CHARS else " [truncated]"
            print(f"\n{'=' * 80}")
            print(f"[qwen2.5-7b] {path}  attempt {attempt}/{RETRIES}")
            print(f"--- PROMPT FED TO MODEL ({len(text)} chars{truncated_note}) ---")
            print(preview)

        try:
            resp = client.chat(
                model=OLLAMA_MODEL,
                messages=[
                    {"role": "system", "content": SYSTEM_PROMPT},
                    {"role": "user", "content": text},
                ],
                format=JSON_SCHEMA,
                options={"temperature": 0},
            )
            raw = resp["message"]["content"]

            if VERBOSE:
                print(f"--- RAW MODEL OUTPUT ---\n{raw}")

            parsed = json.loads(raw)
            # validate values are in-range; raises if not
            assert parsed["hate_speech"] in LEVEL_VALUES
            assert parsed["negativity"] in LEVEL_VALUES
            assert parsed["aggressiveness"] in LEVEL_VALUES
            assert parsed["target"] in TARGET_VALUES

            if VERBOSE:
                print(f"--- PARSED PREDICTION --- {parsed}")

            return parsed
        except Exception as e:
            print(f"  [qwen2.5-7b] {path} attempt {attempt}/{RETRIES} failed: {e}")
            time.sleep(RETRY_SLEEP_S)
    return None


# --------------------------------------------------------------------------- #
# Main
# --------------------------------------------------------------------------- #

def main():
    files = find_speech_files()
    print(f"Found {len(files)} speech files under csv_out/ across {len(POLITICIANS_TO_PROCESS)} politicians.")

    n_skipped_already = 0
    n_skipped_no_text = 0
    n_classified = 0
    n_failed = 0
    n_files_saved = 0

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
            if not needs_classification(row):
                n_skipped_already += 1
                continue

            text = (row.get("text") or "").strip()
            if not text:
                print(f"  [SKIP] {path}: empty '{"text"}' field, cannot classify.")
                n_skipped_no_text += 1
                continue

            result = classify_one(text, path)
            if result is None:
                print(f"  [FAIL] giving up on {path} after {RETRIES} retries.")
                n_failed += 1
                continue

            row.update(result)
            file_changed = True
            n_classified += 1

        if file_changed:
            write_speech_csv(path, rows, fieldnames)
            n_files_saved += 1
            print(f"  [SAVED] {path}")

    print("\n===== SUMMARY =====")
    print(f"Files scanned:           {len(files)}")
    print(f"Files rewritten:         {n_files_saved}")
    print(f"Speeches classified:     {n_classified}")
    print(f"Already labeled (skip):  {n_skipped_already}")
    print(f"Empty text (skip):       {n_skipped_no_text}")
    print(f"Failed after retries:    {n_failed}")


if __name__ == "__main__":
    main()