#import "../config/variables.typ": *
#import "../config/thesis-config.typ": *
#pagebreak(to:"odd")

#set heading(numbering:"1.")
#set math.equation(numbering: "1.", supplement: none)

= The Corpus <ch:corpus>

== Similar Corpora <sec:similar_corpora>

The natural first step was to look at other corpora that aggregate similar data.

The *Europarl* dataset @koehn_europarl_2005 aggregates proceedings of the European Parliament in twenty-one different European languages#footnote[All 21 Europarl languages: Romanic (French, Italian, Spanish, Portuguese, Romanian), Germanic (English, Dutch, German, Danish, Swedish), Slavic (Bulgarian, Czech, Polish, Slovak, Slovene), Finno-Ugric (Finnish, Hungarian, Estonian), Baltic (Latvian, Lithuanian), and Greek.] with the goal of generating sentence-aligned text for statistical machine learning translation systems. The overall structure is akin to a collection of plaintext with minimal tagging.

*ItaParlCorpus* @cova_new_2025, on the other hand, is a comprehensive, annotated, and machine-readable database of Italy's parliamentary speeches spanning from 1948 to 2022. Each speech is identified by a precise date, the role of the speaker, their party name and family, and the legislature number. It is not, however, very rich in terms of linguistic processing tagging.

*IMPAQTS* @cominetti_impaqts_2024 is a multimodal corpus of around 2.65 million tokens, including 1,500 speeches uttered by 150 prominent politicians, spanning from 1946 to 2023. For each speaker, the corpus contains 4 parliamentary speeches, 2 rallies, 1 party assembly, and 3 statements (in person or broadcasted). The goal is to annotate political rhetoric that hides a deeper meaning, for example by employing sarcasm. There are four main types of annotation: implication (conventional, generalized, etc.), presupposition (e.g., pragmatic), vagueness (syntactic, semantic, metaphoric), and topicalization (either syntactic or prosodic).

*Parola di Leader*, and specifically the corpus LP4 @giuliano_il_2019, is a corpus of more than five million occurrences taken from the stenographic archives of the Chamber of Deputies of Italy#footnote[Chamber of Deputies official online public archive: #link("https://legislatureprecedenti.camera.it/").], between 1948 (first legislature of the Italian Republic) and 2011 (excluding the Monti Government, the 61#super[st] legislature).

They selected a list of thirty "highly influential politicians"#footnote[The full list of politicians follows: Giorgio Almirante, Giuliano Amato, Giulio Andreotti, Enrico Berlinguer, Silvio Berlusconi, Pier Luigi Bersani, Fausto Bertinotti, Rosy Bindi, Emma Bonino, Umberto Bossi, Pier Ferdinando Casini, Francesco Cossiga, Bettino Craxi, Massimo D'Alema, Alcide De Gasperi, Ciriaco De Mita, Antonio Di Pietro, Amintore Fanfani, Gianfranco Fini, Ugo La Malfa, Aldo Moro, Pietro Nenni, Achille Occhetto, Marco Pannella, Romano Prodi, Giuseppe Saragat, Giovanni Spadolini, Palmiro Togliatti, Valter Veltroni, Nichi Vendola.] and then for each of them they selected some speeches. Overall, they collected 1877 distinct speeches.

The corpus could be considered a collection of thirty distinct corpora, one for each politician. Each of these has, among others, the following features: name of the politician, role of the politician (for example, Prime Minister), whether the politician is in the majority party or in the opposition, legislature number and sitting number of the day, date of the sitting, topic of the speech, name of the current Government (e.g., _Berlusconi I_), and lastly a reference to the file that holds the actual speech.

There is also a corpus for the vocabulary that holds, for each word, the total number of occurrences, a part-of-speech#footnote[In grammar, a part of speech or part-of-speech (abbreviated as POS or PoS) is a category of words (or, more generally, of lexical items) that have similar grammatical properties @payne_describing_1997.] tag, its lemma, a count for the number of occurrences for each politician, majority party and opposition, and lastly the imprinting tag (e.g., masculine singular).

Lastly, *ParlaMint* @erjavec_parlamint_2023 @erjavec_parlamint_2025 is a compiled collection of comparable parliamentary corpora for a number of countries and languages. ParlaMint corpora are interoperable, i.e. encoded to a very constrained common ParlaMint schema, a specialization of the Parla-CLARIN#footnote[Parla-CLARIN, a TEI schema for corpora of parliamentary proceedings: #link("https://clarin-eric.github.io/parla-clarin/").] recommendations, which are a customization of the TEI Guidelines#footnote[P5 TEI Guidelines: #link("https://tei-c.org/guidelines/p5/").].

It is a collection of parliamentary sittings split into utterances. An example of two utterances could be _Politician: "I ask permission to speak."_, _President of the Senate: "Permission granted."_. For each utterance there are, among others, the following metadata: an ID for both the whole sitting and the utterance itself, a title of the sitting, a date of the sitting, the State Body where it took place (e.g., the Senate of the Republic), the name of the speaker and their affiliation, as well as the name of their coalition.

Speeches are collected before being split into their own datasets, and for each speech we have, among others, a unique ID and a date, the type of speech (e.g., _Interview_ or _Rally_), the venue channel (e.g., _BBC News_), the unique ID of the speaker and their role (e.g., _host_ or _main speaker_), the text of the speech itself and its type (e.g., _Question_, _Answer_, _Interruption_) and whether there have been any _Incidents_ and their types.

Incidents are breaks in the flow of the conversation, and they can be of different types#footnote[Full list of incident types: "action", "incident", "leaving", "entering", "break", "pause", "sound", "editorial".], for example _"leaving"_ or _"break"_. If an incident is of the kinesic type, it can be further subdivided into different kinesic types, such as _"applause"_ or _"laughter"_#footnote[Full list of kinesic types: "kinesic", "applause", "ringing", "signal", "playback", "gesture", "smiling", "laughter", "snapping", "noise".]. If the incident is of the vocal type, it can be further subdivided into different vocal types, such as _"question"_ or _"shouting"_#footnote[Full list of vocal types: "greeting", "question", "clarification", "speaking", "interruption", "exclamat", "laughter", "shouting", "murmuring", "noise", "signal".].

Speakers and Parties also have their own datasets, with unique IDs, names, affiliations, roles and the like.

Overall, the taxonomy of ParlaMint is strongly codified, which makes the dataset machine-readable and easier to interpret. All data is also saved in XML format.

== My Corpus <sec:my_corpus>

- Structure
- Content
  - prime ministers
  - transcriptions
  - annotations

#align()[
    #figure(image("../images/italian_prime_ministers.jpg", width: 100%), 
    caption: "Italian Prime Ministers from 1946 to 2025. In grey Prime Ministers not included in the corpus.")
    <fig:it_pms_timeline>
]


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
  caption: [@fig:dataset_words show the number of words collected for the dataset over the span of eighty years. In green are words pertaining to #text(fill: rgb("#2CA02C"))[center-leaning] Prime Ministers, in red are words pertaining to #text(fill: rgb("#D62728"))[left-leaning] Prime Ministers, and in blue are words pertaining to #text(fill: rgb("#1F77B4"))[right-leaning] Prime Ministers. @fig:dataset_tokens, on the other hand, shows the same data but in terms of tokens instead of whole words.],
  label: <fig:dataset>,
)

== Building the Corpus <sec:building_corpus>

=== Alcide De Gasperi's Corpus <sec:de_gasperi>

I would like to thank Sara Tonelli for providing me with the De Gasperi's Corpus @tonelli_prendo_2019, a collection of Alcide De Gasperi's public documents with gold and silver annotation.

The corpus is a collection of 2,762 documents issued between 1901 and 1954, formatted into XML files which include metadata that covers not only the title, the date and the place of publication, but also key-concepts automatically extracted from each text (with the corresponding relevance score) and genre labels manually assigned by domain experts. Furthermore, the release includes silver annotation for lemma, part of speech, person names and place names witPh associated coordinates in a CoNLL-like format.

An example of the XML formatting can be seen at listing @code:xml_degasperi.
Thanks to the _\<genres\>_ tag, I was able to extract 474 public speeches, each of which with a location, a precise date and a list of keywords.

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
  
- Scraping
  - Meloni YouTube


==== Giorgia Meloni's YouTube Channel

My objective was to build Meloni's corpus by transcribing videos of her public speeches, such as talks and interviews. Fortunately, there is an unofficial YouTube channel (that I reached from the Prime Minister's official website) which aggregates more than four thousand videos of her public appearances. The channel is called "Giorgia Meloni News"\footnote{Giorgia Meloni News: \url{https://www.youtube.com/@GiorgiaMeloniTv}}.

Given a YouTube URL, I can use Python's library \textit{yt-dlp} to retrieve the video's metadata and download its audio content in mp3 format, as shown in listing \ref{code:yt_download}. I had to manually pass the cookies taken from my web-browser, and I used some extra commands to prevent YouTube to block the requests due to suspicious activity. 

Then, the mp3 file just retrieved gets injected into OpenAI's Whisper library, which uses an encoder-decoder Transformer to transcribe it into text, as shown in listing \ref{code:whisper}. The model I used is the \textit{"medium"}\footnote{Whisper model sizes available are tiny, base, medium and large.}, which at 5 GB fits within the total 6 GB of VRAM available to my RTX 4050 GPU. The model was instructed to predict Italian. 

The difference in precision between the models "tiny" (which requires less than 1 GB of VRAM) and "medium" is quite high, as can be seen in the following pieces of text that have been generated from the same audio file:

\begin{itemize}
    \item \textbf{Model tiny:} "iamo con se è beruto fuori da questa rio neone sotto il profiro tecnico per quanto riguarda la franha e come il governo un tino era ad essere vicino alla popolazione di Nishenia."
    \item \textbf{Model medium:} "Diciamo cosa è venuto fuori da questa riunione sotto il profilo tecnico per quanto riguarda la frana e come il governo continuerà ad essere vicino alla popolazione diniscemeca."
\end{itemize}

The last step of the pipeline saves the transcription into a csv file, along with the extracted metadata. Each file has the following fields: \textit{politician} ("meloni" in this case), \textit{historical\_date} (the upload date of the video), \textit{location} and \textit{tags} (extracted from the metadata if available, empty strings otherwise), \textit{description} and \textit{title} of the video, \textit{url} which stores the permalink of the video itself, and lastly \textit{text} which holds the whole transcription.

Each video is processed immediately after being retrieved, and until it has been saved in a csv file the program does not try to fetch the next one. This is done for two reasons: first, to prevent \textit{yt-dlp} from sending requests too close to each other, which could result in YouTube denying them due to suspicious activity. Second, even if the pipeline halts for any reason, the videos processed up to that point will not be lost.  

\begin{lstlisting}[language={python},label={code:yt_download}, caption={Downloading audio and metadata from a YouTube video}]
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
\end{lstlisting}

\begin{lstlisting}[language={python},label={code:whisper}, caption={Transcribe the audio file into text using Whisper}]
subprocess.run([
    "whisper",
    "--language",        lang_code,     # "Italian" chosen
    "--word_timestamps", "True",
    "--model",           model_name,    # model "medium" chosen
    "--output_dir",      output_dir,
    "--device",          "cuda",        # ensures the model gets loaded in GPU
    audio_file
], check=True)
\end{lstlisting}


  - Radio Radicale 
- Speech-to-text via OpenAI _Whisper_

==== Scraping Sanity Check <sec:sanity_check>

Is the corpus correct? Yes, check with n-gram centroid.

=== Corpus Annotation <sec:corpus_annotation>

- Choosing how to annotate the corpus
  - Choosing the right LLMs
- Pipeline

=== V-DEM <sec:vdem>

\section{Democracy Index}

There are plenty of sources for measuring democracy levels. Our World in Data mainly uses six: Varieties of Democracy (V-Dem), the Lexical Index of Electoral Democracy (LIED) by Skaaning et al. (2015), Freedom House's (FH) Freedom in the World index, the Bertelsmann Transformation Index (BTI) by the Bertelsmann Foundation, the Economist Intelligence Unit's (EIU) Democracy Index, and Polity by the Center for Systemic Peace \cite{herre_democracy_2025}. 

Out of the six mentioned datasets, only V-Dem and LIED have data spanning between 1946 and 2025. However, V-Dem offers more granularity and is generally considered a more complete and robust dataset. It is the best choice if we are interested in both large and small differences in varieties of democracy far into the past, or if we want to use country experts to measure characteristics of political systems that are difficult to observe. These experts are anonymous and are primarily academics or members of the media and civil society. They are also often nationals or residents of the country they assess; therefore, they know its political system well and can evaluate aspects that are difficult to observe. V-Dem's own team of researchers supplements these expert evaluations \cite{herre_varieties_2025}.

\subsection{Varieties of Democracy Dataset}

All data is available for download at \url{https://v-dem.net/data/the-v-dem-dataset/} or can be accessed directly as an R package.

V-Dem distinguishes between \textit{indicators}—lower-level data that is often not normalized—and \textit{indices}, which aggregate indicators and are normalized on a scale between zero and one.

There are four datasets: \textit{Coder-Level}, with raw data and 273 indicators intended for the experts; \textit{CD Country-Date}, with day-to-day granularity, 531 indicators, and 95 aggregated indices; \textit{CY Country-Year}, with year-level granularity, 5 indices, 93 sub-indices, and 179 indicators; and lastly, \textit{CY Full + Others}, with year-level granularity, 531 indicators, 251 indices, and 62 external indicators. 

I must use the \textit{CD Country-Date} dataset (version 16, released in March 2026) since, to keep track of Italian governments, year-level granularity is not enough. This is evident from Figure \ref{fig:italyPms}: half of Italy's governments lasted less than a year.

\begin{figure}[h]
  \centering
  \includegraphics[width=.7\linewidth]{images/italian_prime_ministers.jpg}
  \caption{Italian Prime Ministers for each Italian Republic, from the first (1946) to the latest (2025).}
  \Description{All Italian Prime Ministers shown by their days in charge.}
  \label{fig:italyPms}
\end{figure}

The dataset covers Italy (ID 82) between 1861 and 2025, France (ID 76) between 1789 and 2025, and the U.S. (ID 20) between 1789 and 2025.

Useful identifiers include: \texttt{country\_id}, unique for each country; \texttt{country\_text\_id}, ISO 3166-1 alpha-2 country codes (e.g., \textit{IT}, \textit{FR}); \texttt{historical\_date}, in \textit{YYYY-MM-DD} format, used for election-date-specific variables (all other variables use January 1st); and \texttt{gapstart} and \texttt{gapend}, representing time periods where no data is available.

\textbf{Democracy Indices} are the highest-level indices, each normalized to a scale between zero and one unless otherwise specified: \texttt{v2x\_polyarchy}, the \textit{electoral} democracy index (aggregates \texttt{v2x\_elecoff}, \texttt{v2xel\_frefair}, \texttt{v2x\_frassoc\_thick}, \texttt{v2x\_suffr}, \texttt{v2x\_freexp\_altinf}); \texttt{v2x\_libdem}, the \textit{liberal} democracy index (aggregates \texttt{v2x\_polyarchy}, \texttt{v2x\_liberal}); \texttt{v2x\_partipdem}, the \textit{participatory} democracy index (aggregates \texttt{v2x\_polyarchy}, \texttt{v2x\_partip}); \texttt{v2x\_delibdem}, the \textit{deliberative} democracy index focusing on process, respectful dialogue, and the common good (aggregates \texttt{v2x\_polyarchy}, \texttt{v2xdl\_delib}); and \texttt{v2x\_egaldem}, the \textit{egalitarian} democracy index considering social status, inequalities, and resource distribution (aggregates \texttt{v2x\_polyarchy}, \texttt{v2x\_egal}).

\textbf{Components of Democracy Indices} consist of second-level indices and subcomponents: \texttt{v2x\_freexp\_altinf}, freedom of expression and alternative information (aggregates \textit{v2mecenefm}, \textit{v2meharjrn}, \textit{v2meslfcen}, \textit{v2xcl\_disc}, \textit{v2clacfree}, \textit{v2mebias}, \textit{v2mecrit}, \textit{v2merange}); \texttt{v2x\_frassoc\_thick}, freedom of association for parties and civil society organizations (aggregates \textit{v2psparban}, \textit{v2psbars}, \textit{v2psoppaut}, \textit{v2elmulpar}, \textit{v2cseeorgs}, \textit{v2csreprss}, \texttt{v2x\_elecreg}); \texttt{v2x\_suffr}, the percentage of adult suffrage (aggregates \textit{v2elsuffrage}); \texttt{v2xel\_frefair}, the quality of free and fair elections (aggregates \textit{v2elembaut}, \textit{v2elembcap}, \textit{v2elrgstry}, \textit{v2elvotbuy}, \textit{v2elirreg}, \textit{v2elintim}, \textit{v2elpeace}, \textit{v2elfrfair}, \texttt{v2x\_elecreg}); \texttt{v2xcl\_rol}, rule of law, transparency, and fair enforcement (aggregates \textit{v2clrspct}, \textit{v2cltrnslw}, \textit{v2cltort}, \textit{v2clkill}, \textit{v2clrelig}, \textit{v2clfmove}, \texttt{v2xcl\_dmove}, \texttt{v2xcl\_slave}, \texttt{v2xcl\_acjst}, \texttt{v2xcl\_prpty}); \texttt{v2x\_jucon}, executive law compliance and judiciary independence (aggregates \textit{v2exrescon}, \textit{v2jucomp}, \textit{v2juhccomp}, \textit{v2juhcind}, \textit{v2juncind}); \texttt{v2xlg\_legcon}, executive external scrutiny (aggregates \textit{v2lgqstexp}, \textit{v2lgotovst}, \textit{v2lginvstp}, \textit{v2lgoppart}); \texttt{v2x\_partip}, individual participation (aggregates \texttt{v2x\_cspart}, \texttt{v2xdd\_dd}, \texttt{v2xel\_locelec}, \texttt{v2xel\_regelec}); \texttt{v2x\_cspart}, participation in associations like labor unions or NGOs (aggregates \textit{v2pscnslnl}, \textit{v2cscnsult}, \textit{v2csprtcpt}, \textit{v2csgender}); \texttt{v2xdd\_dd}, the direct vote index for referendums and ballots (aggregates \textit{v2ddlexci} through \textit{v2ddthreci}); \texttt{v2xel\_regelec} and \texttt{v2xel\_locelec}, regional and local government elections; \texttt{v2xeg\_eqprotec}, equal rights across social groups; \texttt{v2xeg\_eqaccess}, equality of accessing power; and \texttt{v2xeg\_eqdr}, equality of resource distribution (aggregates \textit{v2dlencmps}, \textit{v2dlunivl}, \textit{v2peedueq}, \textit{v2pehealth}).

#include "../bibliography/bibliography.typ"


#include "conclusions.typ"
#include "results.typ"
#include "future_works.typ"
