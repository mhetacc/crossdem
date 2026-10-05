#import "../config/variables.typ": *
#import "../config/thesis-config.typ": *
#import "@preview/codelst:2.0.2": sourcecode

//#pagebreak(to:"odd")

#set heading(numbering:"1.")
#set math.equation(numbering: "1.", supplement: none)



= The Corpus <ch:corpus>


The purpose of this chapter is to explain and outline the choices I made while building the dataset and to describe the resulting corpus. By following the steps in section @sec:building_corpus, any external actor should be able to replicate the corpus as a whole.

== Similar Corpora <sec:similar_corpora>

The natural first step was to look at other corpora that aggregate similar data.

The *Europarl* dataset @koehn_europarl_2005 aggregates proceedings of the European Parliament in twenty-one different European languages#footnote[All 21 Europarl languages: Romanic (French, Italian, Spanish, Portuguese, Romanian), Germanic (English, Dutch, German, Danish, Swedish), Slavic (Bulgarian, Czech, Polish, Slovak, Slovene), Finno-Ugric (Finnish, Hungarian, Estonian), Baltic (Latvian, Lithuanian), and Greek.] with the goal of generating sentence-aligned text for statistical machine learning translation systems. The overall structure is akin to a collection of plaintext with minimal tagging.

*ItaParlCorpus* @cova_new_2025, on the other hand, is a comprehensive, annotated, and machine-readable database of Italy's parliamentary speeches spanning from 1948 to 2022. Each speech is identified by a precise date, the role of the speaker, their party name and family, and the legislature number. It is not, however, very rich in terms of linguistic processing tagging.

*IMPAQTS* @cominetti_impaqts_2024 is a multimodal corpus of around 2.65 million tokens, including 1,500 speeches uttered by 150 prominent politicians, spanning from 1946 to 2023. For each speaker, the corpus contains 4 parliamentary speeches, 2 rallies, 1 party assembly, and 3 statements (in person or broadcasted). The goal is to annotate political rhetoric that hides a deeper meaning, for example by employing sarcasm. There are four main types of annotation: implication (conventional, generalized, etc.), presupposition (e.g., pragmatic), vagueness (syntactic, semantic, metaphoric), and topicalization (either syntactic or prosodic).

*Parola di Leader*, and specifically the corpus LP4 @giuliano_corpus_2019, is a corpus of more than five million occurrences taken from the stenographic archives of the Chamber of Deputies of Italy#footnote[Chamber of Deputies official online public archive: #link("https://legislatureprecedenti.camera.it/").], between 1948 (first legislature of the Italian Republic) and 2011 (excluding the Monti Government, the 61#super[st] legislature).

They selected a list of thirty "highly influential politicians"#footnote[The full list of politicians follows: Giorgio Almirante, Giuliano Amato, Giulio Andreotti, Enrico Berlinguer, Silvio Berlusconi, Pier Luigi Bersani, Fausto Bertinotti, Rosy Bindi, Emma Bonino, Umberto Bossi, Pier Ferdinando Casini, Francesco Cossiga, Bettino Craxi, Massimo D'Alema, Alcide De Gasperi, Ciriaco De Mita, Antonio Di Pietro, Amintore Fanfani, Gianfranco Fini, Ugo La Malfa, Aldo Moro, Pietro Nenni, Achille Occhetto, Marco Pannella, Romano Prodi, Giuseppe Saragat, Giovanni Spadolini, Palmiro Togliatti, Valter Veltroni, Nichi Vendola.] and then for each of them they selected some speeches. Overall, they collected 1877 distinct speeches.

The corpus could be considered a collection of thirty distinct corpora, one for each politician. Each of these has, among others, the following features: name of the politician, role of the politician (for example, Prime Minister), whether the politician is in the majority party or in the opposition, legislature number and sitting number of the day, date of the sitting, topic of the speech, name of the current Government (e.g., _Berlusconi I_), and lastly a reference to the file that holds the actual speech.

There is also a corpus for the vocabulary that holds, for each word, the total number of occurrences, a part-of-speech#footnote[In grammar, a part of speech or part-of-speech (abbreviated as POS or PoS) is a category of words (or, more generally, of lexical items) that have similar grammatical properties @payne_describing_1997.] tag, its lemma, a count for the number of occurrences for each politician, majority party and opposition, and lastly the imprinting tag (e.g., masculine singular).

Lastly, *ParlaMint* @erjavec_parlamint_2023 @erjavec_parlamint_2025 is a compiled collection of comparable parliamentary corpora for a number of countries and languages. ParlaMint corpora are interoperable, i.e. encoded to a very constrained common ParlaMint schema, a specialization of the Parla-CLARIN#footnote[Parla-CLARIN, a TEI schema for corpora of parliamentary proceedings: #link("https://clarin-eric.github.io/parla-clarin/").] recommendations, which are a customization of the TEI Guidelines#footnote[P5 TEI Guidelines: #link("https://tei-c.org/guidelines/p5/").].

It is a collection of parliamentary sittings split into utterances. An example of two utterances could be _Politician: "I ask permission to speak."_, _President of the Senate: "Permission granted."_. For each utterance there are, among others, the following metadata: an ID for both the whole sitting and the utterance itself, a title of the sitting, a date of the sitting, the State Body where it took place (e.g., the Senate of the Republic), the name of the speaker and their affiliation, as well as the name of their coalition.

Speeches are collected before being split into their own datasets, and for each speech we have, among others, a unique ID and a date, the type of speech (e.g., _Interview_ or _Rally_), the venue channel (e.g., _BBC News_), the unique ID of the speaker and their role (e.g., _host_ or _main speaker_), the text of the speech itself and its type (e.g., _Question_, _Answer_, _Interruption_) and whether there have been any _Incidents_ and their types.

Incidents are breaks in the flow of the conversation, and they can be of different types#footnote[Full list of incident types: "action", "incident", "leaving", "entering", "break", "pause", "sound", "editorial".], for example _"leaving"_ or _"break"_. If an incident is of the kinesic type, it can be further subdivided into different kinesic types, such as _"applause"_ or _"laughter"_#footnote[Full list of kinesic types: "kinesic", "applause", "ringing", "signal", "playback", "gesture", "smiling", "laughter", "snapping", "noise".]. If the incident is of the vocal type, it can be further subdivided into different vocal types, such as _"question"_ or _"shouting"_#footnote[Full list of vocal types: "greeting", "question", "clarification", "speaking", "interruption", "exclamat", "laughter", "shouting", "murmuring", "noise", "signal".].

Speakers and Parties also have their own datasets, with unique IDs, names, affiliations, roles and the like.

Overall, the taxonomy of ParlaMint is strongly codified, which makes the dataset machine-readable and easier to interpret. All data is also saved in XML format.


























== Corpus Structure <sec:my_corpus>

The corpus comprises speeches from twenty four out of the thirty one Italian Prime Ministers of the Italian Republic, as shown in figure @fig:it_pms_timeline. Prime Ministers from the Kingdom of Italy (1861-1946) are excluded.

#align()[
    #figure(image("../images/italian_prime_ministers.jpg", width: 100%), 
    caption: "Italian Prime Ministers from 1946 to 2025 and their time in office. In grey Prime Ministers not included in the corpus. Colors will remain consistent throughout this work.")
    <fig:it_pms_timeline>
]

Overall, collected data amounts to $6,038$ speeches, for a total of $15,185,640$ words. Table @tab:corpus_total surmise the overall corpus, while @tab:corpus_pms shows metrics for each Prime Minister. One important notice: speeches were collected for each Prime Minister as a person, meaning that the corpus contains all the speeches delivered by each Prime Minister regardless of whether they were in office or not at the moment of the speech. For example, Giorgia Meloni's speeches date as far back as the sixteen of October 2000, even though she became Prime Minister twenty-two years later on the twenty-first of October 2022. The rationale is that the corpus is meant to track political rhetoric as a whole: politicians capable of becoming Prime Ministers were chosen as representatives of the political spectrum and ideas they embody. This also facilitated data collection, affording a denser and more informative dataset.

Its worth mentioning that reported tokens amount is obtained by using Spacy's tokenizer, so it will be slightly different in other use cases throughout the project. For example, corpus annotation is done with Gemma 4 via Ollama, which uses the model's own tokenizer (section @sec:corpus_annotation).


#v(1em)
#figure(
table(
columns: (10em, auto),
align: (left, center),
stroke: none,
inset: 5pt,
fill: (col, row) => {
if row == 0 { rgb("#B5001B") }
else if calc.rem(row, 2) == 0 { rgb("#B5001B33") }
else { white }
    },
table.hline(stroke: 0.5pt),
text(fill:white)[*Metric*], text(fill:white)[*Value*],
    [\# Speeches], [6,038],
    [\# Words (Tokens)], [15,185,640 (16,878,514)],
    [$"Median" frac("Words(Tokens)", "Speech")$], [2,132 (2,356)],
table.hline(stroke: 0.5pt),
  ),
caption: [Overall corpus size and pooled median speech length. First row shows how many total speeches were collected, second row shows how many words (and tokens) were collected, and third row shows the overall median speech length, in words (and tokens). Tokenization done via `spacy.load("it_core_news_sm")`.]
) <tab:corpus_total>
#v(1em)

#v(1em)
#[
#show figure: set block(breakable: true)
#figure(
table(
columns: (auto, auto, auto, auto, auto),
align: (center, center, center, center, center),
stroke: none,
inset: 5pt,
fill: (col, row) => {
if row == 0 { rgb("#B5001B") }
else if calc.rem(row, 2) == 0 { rgb("#B5001B33") }
else { white }
    },
table.hline(stroke: 0.5pt),
text(fill:white)[*PM*], text(fill:white)[*Time Period*], text(fill:white)[*\# Speeches*], text(fill:white)[*\# Words (Tokens)*], text(fill:white)[*$"Median" frac("Words(Tokens)", "Speech")$*],
    [De Gasperi], [1901-09-21 – 1954-07-24], [473], [534,228 (609,142)], [701 (803)],
    [Fanfani], [1962-03-22 – 1993-07-25], [21], [26,520 (29,806)], [774 (948)],
    [Leone], [1987-04-02 – 2007-09-09], [8], [7,712 (8,921)], [886 (1,013)],
    [Rumor], [1986-09-03 – 1989-02-20], [5], [9,405 (10,234)], [1,880 (2,100)],
    [Colombo], [1984-05-23 – 1984-05-23], [1], [3,031 (3,393)], [3,031 (3,393)],
    [Andreotti], [1978-04-04 – 2009-05-11], [400], [1,014,190 (1,117,148)], [1,926 (2,122)],
    [Cossiga], [1977-04-21 – 2009-06-11], [225], [539,510 (608,165)], [2,014 (2,292)],
    [Forlani], [1985-12-01 – 2015-02-05], [75], [137,655 (153,626)], [1,718 (1,779)],
    [Spadolini], [1981-12-14 – 1994-04-22], [105], [208,077 (229,816)], [1,698 (1,853)],
    [Craxi], [1980-06-06 – 2005-09-17], [114], [228,924 (254,538)], [1,786 (1,973)],
    [Goria], [1986-09-04 – 1993-05-22], [42], [85,183 (94,885)], [1,930 (2,163)],
    [De Mita], [1985-02-15 – 2017-09-28], [208], [634,323 (706,142)], [3,044 (3,328)],
    [Amato], [1984-03-28 – 2024-11-20], [901], [2,576,265 (2,799,551)], [2,671 (2,877)],
    [Ciampi], [1990-07-04 – 2010-02-23], [73], [135,902 (152,299)], [1,545 (1,701)],
    [Berlusconi], [1984-01-09 – 2019-12-12], [535], [1,490,217 (1,644,026)], [2,188 (2,394)],
    [Dini], [1989-02-21 – 2023-06-01], [310], [415,560 (469,214)], [913 (1,018)],
    [Prodi], [1985-11-30 – 2024-11-09], [515], [1,508,664 (1,699,657)], [2,622 (2,911)],
    [D'Alema], [1987-03-13 – 2024-04-12], [829], [2,888,875 (3,245,195)], [3,158 (3,523)],
    [Monti], [1991-06-12 – 2017-03-14], [240], [605,443 (673,174)], [2,096 (2,312)],
    [Letta], [1992-09-06 – 2021-11-23], [509], [1,177,761 (1,301,164)], [2,176 (2,411)],
    [Renzi], [1997-06-13 – 2024-09-19], [143], [415,955 (467,270)], [1,683 (1,789)],
    [Gentiloni], [2023-06-28 – 2023-06-28], [1], [566 (637)], [566 (637)],
    [Conte], [2002-08-04 – 2026-02-24], [30], [50,177 (57,140)], [471 (545)],
    [Draghi], [1996-06-07 – 2015-12-14], [26], [87,947 (99,206)], [3,476 (3,897)],
    [Meloni], [2000-10-16 – 2026-05-21], [249], [403,550 (444,165)], [1,186 (1,327)],
table.hline(stroke: 0.5pt),
  ),
caption: [Corpus overview per prime minister. In order: Prime Minister's names, time period from which their speeches are pooled, how many speeches were pooled, how many words (and tokens) were pooled in total, and median speech length, in words (and tokens). Tokenization done via `spacy.load("it_core_news_sm")`.]
) <tab:corpus_pms>
]
#v(1em)

Figure @fig:dataset visualizes all the collected speeches (and tokens) and their distribution over time. We can immediately see an imbalance both in therms of time (most data is concentrated between 1995 and 2010) and in terms of political leaning (left-leaning speeches are overrepresented). There is also a big gap between 1955 and 1985 where there is almost no data at all, and between 2019 and 2024 we see a strong reduction in data density, which shoots back up in 2025 (all Giorgia Meloni's speeches).
Specifically, $3,936$ speeches (65.2%) are concentrated between 1995 and 2010, and $5,363$ (88.8%) between 1985 and 2020.


#subpar.grid(
  rows: 2,
  gutter: 5pt,
  figure(
    image("../images/speeches_stack_words.png", width: 100%),
    caption: [Dateset: words. The graph show strong data imbalances: years between 1995 and 2010 contain most of the data, and left-leaning Prime Ministers are overrepresented.]
  ), <fig:dataset_words>,
  figure(
    image("../images/speeches_stacked_tokens.png", width: 100%),
    caption: [Dataset: tokens. Tokenization done via `spacy.load("it_core_news_sm")`.]
  ), <fig:dataset_tokens>,
  v(0.2em),
  caption: [Figure @fig:dataset_words show the number of words collected for the dataset over the span of eighty years. In green are words pertaining to #text(fill: rgb("#2CA02C"))[center-leaning] Prime Ministers, in red are words pertaining to #text(fill: rgb("#D62728"))[left-leaning] Prime Ministers, and in blue are words pertaining to #text(fill: rgb("#1F77B4"))[right-leaning] Prime Ministers. Figure @fig:dataset_tokens, on the other hand, shows the same data but in terms of tokens instead of whole words.],
  label: <fig:dataset>,
)

The structure of the dataset is as follows:
#import "@preview/treet:0.1.1": *

#tree-list[
  - crossdem/
    - datasets/
      - prime_ministers/
        - pm_1/
          - csv_out/
            - speech_1.csv
            - speech_2.csv
            - ...
        - pm_2/
          - csv_out/
            - speech_1.csv
            - speech_2.csv
            - ...
        - ...
        - pm_N/
          - csv_out/
            - ...
]

Each speech (with few exceptions) is structured with the following fields: 
- `politician`: the name of the Prime Minister who delivered the speech, in lower case without spaces or punctuation (e.g., "dalema" and not "D'Alema");
- `historical_date`: the date when the speech was delivered, in the format _YYYY-MM-DD_;
- `location`: the location where the speech was delivered;
- `title`: the title of the video from which the speech was retrieved;
- `url`: the URL of the page from which the speech was retrieved;
- `audio_file`: the audio file of the speech in the local machine;
- `text`: the transcribed text of the speech;
- `hate_speech`: hate speech level, can be either `low`, `mid`, or `high`;
- `negativity`: negativity level, can be either `low`, `mid`, or `high`;
- `aggressiveness`: aggressiveness level, can be either `low`, `mid`, or `high`;
- `target`: target of the speech, can be either `none` if there is no target, `pol_adv` for political adversaries, `minor_etn` for ethnic minorities, `minor_gnd` for gender minorities, or `minor_rel` for religious minorities;

De Gasperi's corpus is structured differently, as it is not scraped but rather taken from a pre-existing dataset instead (section @sec:de_gasperi). Each speech has the following fields: `politician`, `historical_date`, `location`, `keywords` (extracted keywords about the speech itself),`text`, `hate_speech`, `negativity`, `aggressiveness`, `target`. 

Some of Meloni's speeches also have a slightly different structure, as they were scraped from YouTube instead of Radio Radicale. They are easy to recognize in the dataset because all files that contain transcriptions of speeches scraped from Radio Radicale are in the form `123456_meloni_s2t.csv`, with the first characters being all numbers, while speeches scraped from YouTube are in the form `_DA9zjY_meloni_speech2text.csv`, with the first characters being a mix of letters, numbers, and symbols. Each of these speeches has the following fields: `politician`, `historical_date`, `location`, `tags` (tags of the YouTube video),`description` (description of the YouTube video),`title`, `url`, `audio_file`, `text`, `hate_speech`, `negativity`, `aggressiveness`, `target`.



























== Building the Corpus <sec:building_corpus>

This section will explain how the corpus was built, starting from the collection of the speeches, to their transcription, and finally their annotation. For clarification on the corpus' structure, refer to section @sec:my_corpus.

=== Alcide De Gasperi's Corpus <sec:de_gasperi>

I would like to thank Sara Tonelli for providing me with the De Gasperi's Corpus @tonelli_prendo_2019, a collection of Alcide De Gasperi's public documents with gold and silver annotation.

The corpus is a collection of 2,762 documents issued between 1901 and 1954, formatted into XML files which include metadata that covers not only the title, the date and the place of publication, but also key-concepts automatically extracted from each text (with the corresponding relevance score) and genre labels manually assigned by domain experts. Furthermore, the release includes silver annotation for lemma, part of speech, person names and place names witPh associated coordinates in a CoNLL-like format. 

An example of the XML formatting can be seen at listing @code:xml_degasperi.
Thanks to the `\<genres\>` tag, I was able to extract 474 public speeches, each of which with a location, a precise date and a list of keywords.

#figure(
  sourcecode(
  ```xml
    <?xml version="1.0" encoding="UTF-8" standalone="no"?>
    <document id="I.doc_7">
      <publication_date>1901-11-26</publication_date>
      <publication_place>
          <place_name>Trento</place_name>
          <place_latitude>46.0664228</place_latitude>
          <place_longitude>11.1257601</place_longitude>
      </publication_place>
      <keywords>
          <keyword score="39.16">first keyword</keyword>
          ...
          <keyword score="5.59">last keyword</keyword>
      </keywords>
      <genres>
          <genre>Speech Type</genre>
      </genres>
      <text>The speech itself if stored between these brackets</text>
    </document>
  ``` 
), caption: "An example of how a single speech in De Gasperi's Corpus is formatted in XML"
) <code:xml_degasperi>


=== Scraping <sec:scraping>
  
In this section I will show how I scraped two websites to retrieve the speeches of the Italian Prime Ministers. The sites are YouTube (#link("https://www.youtube.com/")) and Radio Radicale #link("https://www.radioradicale.it/").



















==== Scraping Radio Radicale

The whole pipeline (scraping and transcribing) can be executed by running the script `~/crossdem/source/radrad_scraper.py`. Make sure to have the dependencies listed in `~/crossdem/requirements.txt`. \
To choose which Prime Minster to scrape, simply edit the `DATA` list at line 22 with the appropriate name and second half of the URL. For example, to scrape Amintore Fanfani, whose URL is #link("https://www.radioradicale.it/soggetti/545/amintore-fanfani"), add the following tuple in the `DATA` list: `("fanfani", "/soggetti/545/amintore-fanfani")`.

The pipeline works as follows: the script iterates trough all URLs in `DATA`, and for each #pm run the main function `main(politician, SUBJECT_URL)`.  \
First, all URLs for all speeches of the given #pm are collected by calling the function `get_all_audio_urls`, which returns a list of strings, each of which a URL for a speech. \
Then, each speech gets processed. The details and metadata are collected with function `extract_speech_details`, the audio is downloaded with function `download_audio_subprocess`, which then gets trimmed based on the timestamp where the specific politician speaks with the function `trim_to_speaker`. \
Then, the audio is transcribed with the function `speech_to_text` and lastly all downloaded audios are trimmed down to 1 second to save space. If, for any reason, the pipeline halts, the failed speech is logged in `~/crossdem/logs/discarded.log` and the pipeline continues with the next speech. \
A summary of the `run` pipeline can be seen in listing @code:scraper_run_main. The source code for the script is available in the repository at the link: #link("https://github.com/mhetacc/crossdem/blob/main/source/radrad_scraper.py").


#figure(
  sourcecode(
  ```py
def main (politician, SUBJECT_URL):
    urls = get_all_audio_urls(SUBJECT_URL=SUBJECT_URL)
    for url in urls:
        # Skip any file already processed
        processed_ids = get_processed_ids(AUDIO_DIR)
        scheda_id = extract_id_from_url(url)
        if scheda_id in processed_ids:
            print(f"Skipping {scheda_id}, already processed.")
            continue

        try:
            speech_details = extract_speech_details(url, speaker=politician)
            timestamps = speech_details["interventions"]
            if any(i["start_time"] is None for i in timestamps):
                raise ValueError("No timestamps") #skip

            # Download metadata, trim to speaker timestamps, and transcribe
            audio_metadata = download_audio_subprocess(
                              url, 
                              AUDIO_DIR, 
                              politician)
            audio_path = trim_to_speaker(
                          audio_metadata["filename"],
                          timestamps, 
                          AUDIO_DIR)
            speech_to_text(
              audio_metadata, 
              speech_details, 
              audio_path, 
              politician, OUT_DIR, AUDIO_DIR, CSV_DIR, url)

            trim_to_1s(AUDIO_DIR)
        except Exception as e:
            log_discard(politician, url, e)   # Log which speech failed and why
            continue                          # Move on to the next speech

if __name__ == "__main__":
    for politician, SUBJECT_URL in DATA:
        main(politician, f"{BASE_URL}/{SUBJECT_URL}")
  ``` 
), caption: [
  Example of the _"run"_ pipeline to scrape and transcribe all #pms from Radio Radicale.
]
) <code:scraper_run_main>

Let's now explain the pipeline's main phases in greater detail.

#let ems = 0.5em


===== Speeches URL Extraction


Since most #pms have hundreds of speeches, selecting each one by hand (as I did for Giorgia Meloni's speeches on YouTube, section @sec:scraping_youtube) would be asinine. Instead, I wrote a function that, given the URL of a #pm's page on Radio Radicale, scrapes all the URLs of all their public speeches (parliamentary speeches are excluded).

In Radio Radicale's website, the speeches of each #pm can be filtered by categories (for example, "All" or "Interviews"). The categories to scrape are defined in the `CATEGORIES` dictionary, which maps each category name to its filter value. The _Istituzioni_ category is left out, as it contains the parliamentary speeches.

The function `_scrape_category` (listing @code:scrape_category) scrapes a single category. It requests the #pm page with the category filter and the page number (many #pms have multiple pages of speeches) as query parameters, and parses the HTML with the Python library _BeautifulSoup_ #footnote[Beautiful Soup is a library that makes it easy to scrape information from web pages. It sits atop an HTML or XML parser, providing Pythonic idioms for iterating, searching, and modifying the parse tree. Source: #link("https://pypi.org/project/beautifulsoup4/")]. The resulting page contains, among the usual elements such as header, footer, and menus, a list of links that point to speeches #footnote[An example of the HTML can be seen in appendix @appx:list_of_schede]. The code iterates trough all list elements `<li>`, extracting the absolute ULRs for the ones pointing to a speech. This process is repeated for each successive page. A pause of 0.5 seconds between requests avoids overloading the server. A the end of this process, a list containing all URLs for a specific category (of a specific #pm) is returned.

#figure(
  sourcecode(
```python
def _scrape_category(session, cat_value, SUBJECT_URL):
    urls = []
    page = 0

    while True:
        params = {"field_registrazione_raggruppamenti_radio": cat_value,
                  "page": page}
        resp = session.get(SUBJECT_URL, params=params,
                           headers=HEADERS, timeout=20)
        resp.raise_for_status()
        soup = BeautifulSoup(resp.text, "html.parser")

        for li in soup.select("ol.lista_list li.views-row"):
            if not li.select_one("div.tipo_media.audio"):
                continue
            a = li.select_one("div.ls_text h3 a")
            if a and a.get("href"):
                urls.append(urljoin(BASE_URL, a["href"]))

        if not soup.select_one("li.pager__item--next a"):
            break

        page += 1
        time.sleep(0.5)

    return urls
```
  ), caption: "Scraping the audio URLs of a single category"
) <code:scrape_category>

The main function, `get_all_audio_urls` (listing @code:get_all_urls), calls `_scrape_category` on every category and merges the results. The same recording can appear under more than one category, and multiple times in the same category. Speeches URL are in the from _".../scheda/55884/...?i=00000"_, and by stripping everything after the key _"?"_ duplicates can be removed, since they point to the same _"scheda"_, meaning to the same speech. The function thus returns a list of unique URls, which point to all the speeches of the target #pm.

#figure(
  sourcecode(
```python
def get_all_audio_urls(categories=None, verbose=True, SUBJECT_URL="."):
    if categories is None:
        categories = CATEGORIES

    session = requests.Session()
    all_urls = []
    seen_paths = set()

    for label, value in categories.items():
        cat_urls = _scrape_category(session, value, SUBJECT_URL)
        new = []
        for u in cat_urls:
            path = u.split("?")[0]
            if path not in seen_paths:
                seen_paths.add(path)
                new.append(u)
        all_urls.extend(new)

    return all_urls
```
  ), caption: "Get all URLs of all speeches of a single Prime Minister, without duplicates."
) <code:get_all_urls>


===== Speech Download

The audio of each speech is downloaded with `yt-dlp`, a command line and Python tool for downloading media from web pages #footnote[`yt-dlp` is a feature-rich command-line audio/video downloader with support for thousands of sites. Source: #link("https://github.com/yt-dlp/yt-dlp").]. The function `download_audio_subprocess` (@code:download_audio) takes the URL of a speech page, an output directory and the name of the #pm, and saves the audio as `<id>_<pm>.mp3`.

The URLs collected in the previous step have to be sanitized, going from _".../scheda/55884/..."_ to _".../scheda/55884"_. The function `sanitize_url` (@code:url_helpers) reduces them to the form _"https://www.radioradicale.it/scheda/<id>"_, and `extract_id_from_url` returns the numeric ID which is then used in the file name, so that each file can be traced back to its recording page.

#figure(
  sourcecode(
```python
def sanitize_url(page_url: str) -> str:
    base = page_url.split("?")[0]
    parts = base.split("/")
    return "/".join(parts[:5])  # https: + '' + domain + scheda + ID

def extract_id_from_url(url):
    parts = url.split("/scheda/")
    if len(parts) > 1:
        return parts[1].split("/")[0]
    return None
```
  ), caption: "Helper functions to normalise a recording URL and extract its ID"
) <code:url_helpers>

`yt-dlp` is called through `subprocess`. Spawning a process each time is not a big concern, since between downloading the speech (often one hour long if not more) and transcribing it, this operation is never done more than five to ten times per hour. Only the audio is downloaded (`-x`) and then converted to MP3 at the highest quality (`--audio-quality 0`). Recordings split into multiple parts are treated by `yt-dlp` as a playlist, so each part is saved with its playlist index in the file name, and `--concat-playlist always` merges the parts into a single file, which in the end overwrites all the previous parts so that only one file per speech remains.

The metadata of the recording is fetched with a second call to `yt-dlp` (`--dump-json`), which does not download anything. The output is parsed as JSON, and an empty dictionary is used if the call or the parsing fails. The file name, the recording ID and the URL are added to the dictionary, which is returned to be used by other functions in the script.

#figure(
  sourcecode(
```python
def download_audio_subprocess(url, out_dir, politician="politician"):
    url = sanitize_url(url)
    id = extract_id_from_url(url)
    stem = f"{id}_{politician}"
    final_file = f"{out_dir}/{stem}.mp3"

    result = subprocess.run([
        "yt-dlp",
        "-x",
        "--audio-format", "mp3",
        "--audio-quality", "0",
        "--concat-playlist", "always",
        "-o", f"{out_dir}/{stem}_part%(playlist_index)s.%(ext)s",
        url
    ], text=True)
    if result.returncode != 0:
        raise RuntimeError(f"yt-dlp exited {result.returncode}")

    # concatenation overwrites the first part
    concat_result = f"{out_dir}/{stem}_part0.mp3"
    if not os.path.exists(concat_result):
        candidates = glob.glob(f"{out_dir}/{stem}*.mp3")
        if not candidates:
            raise FileNotFoundError(f"No mp3 found for stem {stem}")
        concat_result = candidates[0]
    os.rename(concat_result, final_file)

    meta_result = subprocess.run([
        "yt-dlp", "--dump-json", "--no-playlist", "--flat-playlist", url
    ], capture_output=True, text=True)

    info = {}
    if meta_result.returncode == 0 and meta_result.stdout.strip():
        lines = [l for l in meta_result.stdout.splitlines() if l.strip()]
        try:
            info = json.loads(lines[-1])
        except json.JSONDecodeError:
            pass

    info["filename"] = os.path.basename(final_file)
    info["file_id"] = id
    info.setdefault("url", url)
    return info
```
  ), caption: "Downloading, merging and renaming the audio of a recording"
) <code:download_audio>


===== Extract Speech Metadata and Timestamps

Each recording page on Radio Radicale lists the interventions of all the speakers at an event, so we need to trim the downloaded audio to only the parts (can be more than one) where the target #pm speaks. For example, in a 1-hour long debate, the target #pm could intervene between minute 14 and minute 20, and between minute 48 and minute 53. \
The function `extract_speech_details` (listing @code:extract_details) takes the URL of a recording page and the name of the #pm, and returns the date, the location and the timestamps of all their interventions. The page is fetched by `fetch_page`, which sends a GET request with browser-like headers and returns the parsed HTML as a _BeautifulSoup_ object.

*Historical Date.* Different dates appear in the pages in several formats, and the helpers in listing @code:date_helpers handle four of them: with the full Italian month name (_22 marzo 1962_), with the abbreviated month (_22 mar 1962_), dotted (_22.03.1962_) and ISO (_1962-03-22_). The function `find_date` tries them in this order and returns the first match. Each helper has the same structure as `_try_long`, so only the latter is shown.

#figure(
  sourcecode(
```python
MONTHS_IT = {"gennaio": 1, "febbraio": 2, ..., "dicembre": 12}
MONTHS_IT_SHORT = {"gen": 1, "feb": 2, ..., "dic": 12}

RE_DATE_LONG = re.compile(
    r"\b(\d{1,2})\s+(" + "|".join(MONTHS_IT) + r")\s+(\d{4})\b", re.I)
RE_DATE_SHORT = ...   # same, with MONTHS_IT_SHORT
RE_DATE_DOTTED = re.compile(r"\b(\d{1,2})\.(\d{2})\.(\d{4})\b")
RE_DATE_ISO = re.compile(r"(\d{4})-(\d{2})-(\d{2})")

def _try_long(text):
    m = RE_DATE_LONG.search(text)
    return date(int(m[3]), MONTHS_IT[m[2].lower()], int(m[1])) if m else None

def find_date(text):
    return (_try_long(text) or _try_short(text)
            or _try_dotted(text) or _try_iso(text))
```
  ), caption: "Parsing dates in the formats found on the pages"
) <code:date_helpers>

The date of the event is extracted by `extract_page_date` (listing @code:page_date). The sources are checked from the most to the least reliable: the metadata tags, the page title, a date with abbreviated month in the page text, and a date with full month name in the page text. The function returns the date together with a label indicating which source it came from.

#figure(
  sourcecode(
```python
def extract_page_date(soup):
    for attr, val in [("name", "dcterms.date"),
                      ("property", "article:published_time")]:
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
```
  ), caption: "Extracting the date of the event from the page"
) <code:page_date>

Sometimes the date of the speech is explicitly mentioned (for example _"L'on. Fanfani a una conferenza stampa del 22 marzo 1962..."_), and it can be different to any other date fetched with `extract_page_date`. Since such dates are more precise, I extract them with `extract_speaker_date` (listing @code:speaker_date). The speaker-level date has the priority, and is thus used instead of the page-level date (if present).

#figure(
  sourcecode(
```python
def extract_speaker_date(soup, speaker):
    items = [li for li in soup.select("li.intervento") if li.find("h2")]

    for idx, li in enumerate(items):
        if speaker.lower() not in li.find("h2").get_text().lower():
            continue

        subtext = li.find("div", class_="int_subtext")
        if subtext:
            d = find_date(subtext.get_text())
            if d: return d, "speaker_subtext"

        if idx > 0:
            prev = items[idx - 1].find("div", class_="int_subtext")
            if prev and speaker.lower() in prev.get_text().lower():
                d = find_date(prev.get_text())
                if d: return d, "preceding_subtext"

        d = find_date(li.get_text(" ", strip=True))
        if d: return d, "speaker_block"
        return None, "speaker_block_no_date"

    return None, "speaker_not_found"
```
  ), caption: "Extracting the date of the #pm's intervention"
) <code:speaker_date>

*Location.* The location is read from the `primo_suffisso` element of the page by `extract_location`. A regular expression matches the uppercase name between two hyphens that precedes the time of the event (e.g. _- ROMA - 17:00_). If no location is found, or if it is the generic value `RADIO`, the location is set to `UNKNOWN`.

*Timestamps.* Each video in Radio Radicale has a column associated with it that contains a list of all timestamps for each intervention of each speaker. An example HTML can be seen at appendix @appx:list_of_interventions.\
Each intervention is a list item that contains, among others, the class _"durata"_ which stores the starting timestamp of an intervention and how long the intervention lasts (for example `<div class="durata"> 1:07 Durata: 16 min</div>`). The function `parse_timestamps` (listing @code:parse_timestamps) extracts the timestamps. \
The start times are written in one of two ways: as time elapsed since the start of the recording (e.g., _0:30_ meaning half an hour since the start), or as the time of the day (e.g., _17:30_). In the second case, the start time is converted into the elapsed time format, meaning if starting time is _17:00_, and _intervention A_ starts at _17:30_, then _intervention A_ starting time is converted to _0:30_.\
To differentiate between the two cases, the script looks at the start time of the first intervention. If its value is _0:00_, the format is considered elapsed time.


#figure(
  sourcecode(
```python
RE_DURATA = re.compile(r'(\d+:\d+)\s+Durata:\s+(\d+)\s+min', re.I)
RE_INT_ID = re.compile(r'^int(\d+)$')
RE_D_SEC  = re.compile(r'^d(\d+)$')

def parse_timestamps(li, is_clock_time=False, event_start=None):
    result = {"int_id": None, "start_time": None,
              "duration_min": None, "duration_seconds": None}

    for cls in li.get("class", []):
        if m := RE_INT_ID.match(cls):
            result["int_id"] = int(m.group(1))
        if m := RE_D_SEC.match(cls):
            result["duration_seconds"] = int(m.group(1))

    durata_div = li.find("div", class_="durata")
    if durata_div and (m := RE_DURATA.search(durata_div.get_text())):
        raw_time = m.group(1)
        result["duration_min"] = int(m.group(2))

        if is_clock_time and event_start:
            h0, m0 = (int(x) for x in event_start.split(":"))
            h1, m1 = (int(x) for x in raw_time.split(":"))
            offset = (h1 * 60 + m1) - (h0 * 60 + m0)
            result["start_time"] = f"{offset // 60:02d}:{offset % 60:02d}"
        else:
            result["start_time"] = raw_time

    return result
```
  ), caption: "Parsing the identifier, start time and duration of an intervention"
) <code:parse_timestamps>

*Main function.* `extract_speech_details` (listing @code:extract_details) combines the previous steps. It returns a dictionary with the page URL, the date and its source, the location and the list of the #pm's interventions. All the interventions of the #pm are collected, not only the first, and the match on the speaker name is case-insensitive. If the page cannot be fetched, the error is stored in the dictionary. If the #pm is not found among the interventions, the error is stored too. The date of the speech is the one found by `extract_speaker_date`, with the date of the event as fallback. When neither is found, the source is set to `llm_needed`, which flags the recording for separate handling. Thankfully, this was never needed while collecting the data.

#figure(
  sourcecode(
```python
def extract_speech_details(url, speaker, timeout=20):
    result = dict(
        url=url, speaker_query=speaker, speaker_found=False,
        speech_date=None, date_source=None, page_event_date=None,
        interventions=[], error=None,
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

    event_start = None
    first_li = soup.select_one("li.intervento")
    if first_li and (d := first_li.find("div", class_="durata")):
        if m := RE_DURATA.search(d.get_text()):
            event_start = m.group(1)
    is_clock_time = event_start != "0:00"

    for li in soup.select("li.intervento"):
        h2 = li.find("h2")
        if h2 and speaker.lower() in h2.get_text().lower():
            result["speaker_found"] = True
            ts = parse_timestamps(li, is_clock_time, event_start)
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
```
  ), caption: "Extracting date, location and timestamps of a #pm's speech"
) <code:extract_details>


===== Trim Audio to Timestamps

Almost all videos in Radio Radicale's website are integral recordings of events, such as conferences or interviews, and they often include more than one speaker. Only the target #pm's interventions are needed, so the audio file is trimmed to those segments. The function `trim_to_speaker` (listing @code:trim_speaker) takes the name of the audio file, the list of interventions returned by `extract_speech_details` and the audio directory. It uses `ffmpeg` #footnote[FFmpeg is a complete, cross-platform solution to record, convert and stream audio and video. In this project I used the command line tool installed via Fedora's package manager. Source: #link("https://ffmpeg.org/").] through `subprocess` (once again, for the reasons mentioned above the overhead of spawning new processes can be ignored).

The start time of each intervention is converted from the `h:mm` format into seconds by `hhmm_to_seconds`. For each intervention, `ffmpeg` cuts the segment that starts at that time and lasts `duration_seconds`, and saves it to a temporary file. The audio stream is copied (`-acodec copy`) instead of being re-encoded, which is fast and does not degrade the audio quality. The segments are then listed in a text file and joined with the `concat` command into a single file, in the order of the interventions. The temporary files are deleted and the result replaces the original file, so in the end one trimmed audio file per event is kept.

#figure(
  sourcecode(
```python
def trim_to_speaker(audio_filename, interventions, AUDIO_DIR):
    input_path = Path(AUDIO_DIR) / audio_filename

    def hhmm_to_seconds(t):
        h, m = t.split(":")
        return int(h) * 3600 + int(m) * 60

    # extract each segment to a temporary file
    tmp_files = []
    for i, iv in enumerate(interventions):
        tmp = input_path.with_name(f"_tmp_{i}_{input_path.name}")
        cmd = [
            "ffmpeg", "-y",
            "-ss", str(hhmm_to_seconds(iv["start_time"])),
            "-i", str(input_path),
            "-t", str(iv["duration_seconds"]),
            "-acodec", "copy",
            str(tmp),
        ]
        subprocess.run(cmd, stdout=subprocess.DEVNULL,
                       stderr=subprocess.DEVNULL)
        tmp_files.append(tmp)

    # concatenate the segments
    concat_list = input_path.with_name("_concat_list.txt")
    concat_list.write_text("\n".join(f"file '{f.name}'" for f in tmp_files))

    tmp_out = input_path.with_name(f"_out_{input_path.name}")
    cmd = [
        "ffmpeg", "-y",
        "-f", "concat", "-safe", "0",
        "-i", str(concat_list),
        "-acodec", "copy",
        str(tmp_out),
    ]
    subprocess.run(cmd, stdout=subprocess.DEVNULL,
                   stderr=subprocess.DEVNULL)

    # remove temporary files and overwrite the original
    for f in tmp_files:
        f.unlink(missing_ok=True)
    concat_list.unlink(missing_ok=True)
    tmp_out.replace(input_path)

    return input_path
```
  ), caption: "Trimming a recording to the segments of the speaker"
) <code:trim_speaker>


===== Audio Transcription





 
==== Scraping YouTube <sec:scraping_youtube>

Almost all the corpus is composed of speeches scraped from Radio Radicale, so to diversify it a bit I decided to scrape some of Giorgia Meloni's speeches from YouTube. 
Fortunately, there is an unofficial YouTube channel (that I reached from the Prime Minister's official website) which aggregates more than four thousand videos of her public appearances. The channel is called "Giorgia Meloni News"#footnote[Giorgia Meloni News: #link("https://www.youtube.com/@GiorgiaMeloniTv")]. In total, I manually selected and scraped 72 YouTube videos.

Given a YouTube URL, I can use Python's library _yt-dlp_ to retrieve the video's metadata and download its audio content in mp3 format, as shown in listing @code:yt_download. I had to manually pass the cookies taken from my web-browser, and I used some extra commands to prevent YouTube to block the requests due to suspicious activity.

Then, the mp3 file just retrieved gets injected into OpenAI's Whisper library, which uses an encoder-decoder Transformer to transcribe it into text, as shown in listing @code:whisper_yt. The model I used is the _"medium"_#footnote[Whisper model sizes available are tiny, base, medium and large.], which at 5 GB fits within the total 6 GB of VRAM available to my RTX 4050 GPU. The model was instructed to predict Italian.

The difference in precision between the model sizes _tiny_ (which requires less than 1 GB of VRAM) and _medium_ is quite high, as can be seen in the following transcriptions of the same audio file:

#blockquote[
  *Model tiny:* "iamo con se è beruto fuori da questa rio neone sotto il profiro tecnico per quanto riguarda la franha e come il governo un tino era ad essere vicino alla popolazione di Nishenia."
]
#blockquote[
  *Model medium:* "Diciamo cosa è venuto fuori da questa riunione sotto il profilo tecnico per quanto riguarda la frana e come il governo continuerà ad essere vicino alla popolazione diniscemeca."
]

The transcription obtained with the model _medium_ is very close to the original:

#blockquote[
  *Original speech:* "Diciamo cosa è venuto fuori da questa riunione sotto il profilo tecnico per quanto riguarda la frana e come il governo continuerà ad essere vicino alla popolazione di Niscemi #footnote[Niscemi is a small city and comune in the free municipal consortium of Caltanissetta, Sicily, Italy.]."
]

The last step of the pipeline saves the transcription into a csv file, along with the extracted metadata. Each file has the following fields: _politician_ ("meloni" in this case), _historical\_date_ (the upload date of the video), _location_ and _tags_ (extracted from the metadata if available, empty strings otherwise), _description_ and _title_ of the video, _url_ which stores the permalink of the video itself, and lastly _text_ which holds the whole transcription.

Each video is processed immediately after being retrieved, and until it has been saved in a csv file the program does not try to fetch the next one. This is done for two reasons: first, to prevent _yt-dlp_ from sending requests too close to each other, which could result in YouTube denying them due to suspicious activity. Second, even if the pipeline halts for any reason, the videos processed up to that point will not be lost.

#figure(
  sourcecode(
  ```py
    result = subprocess.run([
        "yt-dlp",
        "--print-json",
        "-x",                               # download audio only
        "--audio-format", "mp3",            
        "--cookies", "yt_cookies.txt",      # manually extracted cookies
        "--sleep-requests", "2",            # Sleep 2s between requests
        "--sleep-interval", "5",            # Sleep 5s between downloads
        "--max-sleep-interval", "15",       # Randomize up to 15s
        "--limit-rate", "5M",               # Throttle to 5MB/s (mimics streaming)
        "-o", audio_file.replace('.mp3', ''), 
        video_url
    ], capture_output=True, text=True, check=True)
  ``` 
), caption: "Downloading audio and metadata from a YouTube video"
) <code:yt_download>

#figure(
  sourcecode(
  ```py
    subprocess.run([
        "whisper",
        "--language",        lang_code,     # "Italian" chosen
        "--word_timestamps", "True",
        "--model",           model_name,    # model "medium" chosen
        "--output_dir",      output_dir,
        "--device",          "cuda",        # ensures the model gets loaded in GPU
        audio_file
    ], check=True)
  ``` 
), caption: "Transcribe the audio file into text using Whisper"
) <code:whisper_yt>


==== Scraping Sanity Check <sec:sanity_check>

Is the corpus correct? Yes, check with n-gram centroid.

=== Corpus Annotation <sec:corpus_annotation>

- Choosing how to annotate the corpus
  - Choosing the right LLMs
- Pipeline

=== V-DEM <sec:vdem>

==== Democracy Index

There are plenty of sources for measuring democracy levels. Our World in Data mainly uses six: Varieties of Democracy (V-Dem), the Lexical Index of Electoral Democracy (LIED) by Skaaning et al. (2015), Freedom House's (FH) Freedom in the World index, the Bertelsmann Transformation Index (BTI) by the Bertelsmann Foundation, the Economist Intelligence Unit's (EIU) Democracy Index, and Polity by the Center for Systemic Peace @herre_democracy_2025. 

Out of the six mentioned datasets, only V-Dem and LIED have data spanning between 1946 and 2025. However, V-Dem offers more granularity and is generally considered a more complete and robust dataset. It is the best choice if we are interested in both large and small differences in varieties of democracy far into the past, or if we want to use country experts to measure characteristics of political systems that are difficult to observe. These experts are anonymous and are primarily academics or members of the media and civil society. They are also often nationals or residents of the country they assess; therefore, they know its political system well and can evaluate aspects that are difficult to observe. V-Dem's own team of researchers supplements these expert evaluations @herre_varieties_2025.

==== Varieties of Democracy Dataset
All data is available for download at #link("https://v-dem.net/data/the-v-dem-dataset/") or can be accessed directly as an R package.

V-Dem distinguishes between _indicators_—lower-level data that is often not normalized—and _indices_, which aggregate indicators and are normalized on a scale between zero and one.

There are four datasets: _Coder-Level_, with raw data and 273 indicators intended for the experts; _CD Country-Date_, with day-to-day granularity, 531 indicators, and 95 aggregated indices; _CY Country-Year_, with year-level granularity, 5 indices, 93 sub-indices, and 179 indicators; and lastly, _CY Full + Others_, with year-level granularity, 531 indicators, 251 indices, and 62 external indicators.

I must use the _CD Country-Date_ dataset (version 16, released in March 2026) since, to keep track of Italian governments, year-level granularity is not enough. This is evident from @fig:italyPms: half of Italy's governments lasted less than a year.

#figure(
  image(
    "../images/italian_prime_ministers.jpg",
    width: 70%,
    alt: "All Italian Prime Ministers shown by their days in charge.",
  ),
  caption: [Italian Prime Ministers for each Italian Republic, from the first (1946) to the latest (2025).],
) <fig:italyPms>

The dataset covers Italy (ID 82) between 1861 and 2025, France (ID 76) between 1789 and 2025, and the U.S. (ID 20) between 1789 and 2025.

Useful identifiers include: `country_id`, unique for each country; `country_text_id`, ISO 3166-1 alpha-2 country codes (e.g., _IT_, _FR_); `historical_date`, in _YYYY-MM-DD_ format, used for election-date-specific variables (all other variables use January 1st); and `gapstart` and `gapend`, representing time periods where no data is available.

*Democracy Indices* are the highest-level indices, each normalized to a scale between zero and one unless otherwise specified: `v2x_polyarchy`, the _electoral_ democracy index (aggregates `v2x_elecoff`, `v2xel_frefair`, `v2x_frassoc_thick`, `v2x_suffr`, `v2x_freexp_altinf`); `v2x_libdem`, the _liberal_ democracy index (aggregates `v2x_polyarchy`, `v2x_liberal`); `v2x_partipdem`, the _participatory_ democracy index (aggregates `v2x_polyarchy`, `v2x_partip`); `v2x_delibdem`, the _deliberative_ democracy index focusing on process, respectful dialogue, and the common good (aggregates `v2x_polyarchy`, `v2xdl_delib`); and `v2x_egaldem`, the _egalitarian_ democracy index considering social status, inequalities, and resource distribution (aggregates `v2x_polyarchy`, `v2x_egal`).

*Components of Democracy Indices* consist of second-level indices and subcomponents: `v2x_freexp_altinf`, freedom of expression and alternative information (aggregates _v2mecenefm_, _v2meharjrn_, _v2meslfcen_, _v2xcl\_disc_, _v2clacfree_, _v2mebias_, _v2mecrit_, _v2merange_); `v2x_frassoc_thick`, freedom of association for parties and civil society organizations (aggregates _v2psparban_, _v2psbars_, _v2psoppaut_, _v2elmulpar_, _v2cseeorgs_, _v2csreprss_, `v2x_elecreg`); `v2x_suffr`, the percentage of adult suffrage (aggregates _v2elsuffrage_); `v2xel_frefair`, the quality of free and fair elections (aggregates _v2elembaut_, _v2elembcap_, _v2elrgstry_, _v2elvotbuy_, _v2elirreg_, _v2elintim_, _v2elpeace_, _v2elfrfair_, `v2x_elecreg`); `v2xcl_rol`, rule of law, transparency, and fair enforcement (aggregates _v2clrspct_, _v2cltrnslw_, _v2cltort_, _v2clkill_, _v2clrelig_, _v2clfmove_, `v2xcl_dmove`, `v2xcl_slave`, `v2xcl_acjst`, `v2xcl_prpty`); `v2x_jucon`, executive law compliance and judiciary independence (aggregates _v2exrescon_, _v2jucomp_, _v2juhccomp_, _v2juhcind_, _v2juncind_); `v2xlg_legcon`, executive external scrutiny (aggregates _v2lgqstexp_, _v2lgotovst_, _v2lginvstp_, _v2lgoppart_); `v2x_partip`, individual participation (aggregates `v2x_cspart`, `v2xdd_dd`, `v2xel_locelec`, `v2xel_regelec`); `v2x_cspart`, participation in associations like labor unions or NGOs (aggregates _v2pscnslnl_, _v2cscnsult_, _v2csprtcpt_, _v2csgender_); `v2xdd_dd`, the direct vote index for referendums and ballots (aggregates _v2ddlexci_ through _v2ddthreci_); `v2xel_regelec` and `v2xel_locelec`, regional and local government elections; `v2xeg_eqprotec`, equal rights across social groups; `v2xeg_eqaccess`, equality of accessing power; and `v2xeg_eqdr`, equality of resource distribution (aggregates _v2dlencmps_, _v2dlunivl_, _v2peedueq_, _v2pehealth_).


#include "../bibliography/bibliography.typ"


#include "conclusions.typ"
#include "results.typ"
#include "future_works.typ"
#include "../appendix/appendix-A.typ"