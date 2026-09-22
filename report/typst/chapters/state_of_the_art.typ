#import "../config/variables.typ": *
#import "../config/thesis-config.typ": *
//#pagebreak(to:"odd")

= State of the Art <ch:state-of-the-art>

== Textual Complexity <sec:sots_textual_complexity>

Text complexity or readability refers to how difficult a text is to understand @dubay_principles_2004, influenced by linguistic factors such as word choice (e.g., "utilize" vs. "use"), sentence structure (complex vs. simple), and content type (academic vs. children’s books) @dale_formula_1948 @graesser_cohmetrix_2004. \
Common comprehension metrics are Flesch Reading Ease (FRE) @flesch_new_1948, which considers the average sentence length and syllables per word, and outputs a value between zero (hard to read) and one hundred (easy to read); Dale-Chall @dale_formula_1948, which measures a raw score taking in consideration a list of 3000 words that groups of fourth-grade American students could reliably understand, considering any word not on that list to be difficult; and SMOG @mclaughlin_smog_1969, which uses intuitive features like sentence length and word complexity. 

Another way to measure the complexity is by measuring the *lexical diversity*, which is the ratio of different unique word types compared to the total number of words. In a sense, it measures the vocabulary richness of a sample. \
The most common metric is the Type-Token Ratio, obtained by simply dividing word types over tokens. A TTR of $0.5$ means that half of the words in the sample appear only once. \
A more refined metric was introduced McCarthy in 2005: it is the measure of textual lexical diversity (MTLD) @mccarthy_assessment_2005. 
It uses a sequential algorithm to count tokens until lexical repetition forces the ratio below a fixed threshold, reducing text-length bias, and its widely applied in computational linguistics for corpus profiling, tracking writing development, and evaluating machine translation quality.
MTLD has become a standard tool in applied linguistics and computational text analysis, and it is often used as a measure of lexical diversity, lexical complexity, or lexical sophistication  @lin_large_2025.

Let's now have a look at the recent research. \
Bestgen (2024) @bestgen_measuring_2024 published a methodological review on the subject of lexical diversity, comparing TTR( type–token ratio), MTTRRS (mean type–token ratio in random samples), MATTR (moving-average type–token ratio), MSTTR (mean segmental type–token ratio), MTTRSS (mean type–token ratio in sequential samples), and MTLD (measure of textual lexical diversity). Its findings show that for a local estimation, MATTR and MTLD are recommended. While MTLD appeared to be slightly more sensitive to length than MATTR, the differences were insufficient to declare one superior to the other.

#v(1em)

Velasco and Roque (2025) @velasco_rethinking_2025 explored the role of text complexity in language model pretraining. In theirs study, they measured how complexity affects language modeling across model sizes, if useful representations can be learned from simpler text alone, and how text complexity in pretraining influences downstream language understanding. They used a subset of _FineWeb-Edu_ @penedo_fineweb_2024, then simplified by prompting _Llama 3.1 8B_ @grattafiori_llama_2024 at the paragraph level. \
To get a rough idea of what the simplified texts look like, see the following example: 

#blockquote[
    *Original:* Your comment really helped me feel better the most. I was sitting in my office, feeling so bad that I didn’t say how inappropriate and out of line his comments were, and this helped.
]
#blockquote[
    *Simplified:* Your comment really helped me feel better. I was feeling bad because I didn’t speak up when someone made inappropriate comments.
]

Since LLM-based scoring is computationally costly, they used Flesch Reading Ease to estimate readability, and Type-Token Ratio to measure lexical diversity.

#v(1em)

Amadori et al. (2025) @amadori_involvement_2025 examined the linguistic complexity of content produced by influential users on Twitter across three globally significant and contested topics: COVID-19, COP26, and the Russia–Ukraine war. Their findings show significant differences across account type, political leaning, content reliability, and sentiment. Additionally, profiles producing more negative and offensive content tend to use more complex language. \
They used three metrics: Flesch readability score; Yule's K measure of lexical richness @yule_statistical_2014, which  quantifies how repetitive or diverse the vocabulary is, and it is largely independent of the overall length of a text; and gzip-based compression complexity, which assesses text repetitiveness by measuring its compression ratio, an approach already explored in previous studies @parada-cabaleiro_song_2024 @desiderio_recurring_2023 @dimarco_patterns_2024.


#v(1em)

Lastly, Fredrick and Craven (2025) @fredrick_lexical_2025 compared AI-generated texts (via ChatGPT) and student-written essays in terms of lexical diversity, syntactic complexity, and readability, using metrics such as Type-Token Ratio or Flesch-Kincaid. Results indicate that while ChatGPT produces texts with greater lexical diversity and syntactic complexity, the outputs are overall less readable.\
They chose a range of linguistic complexity metrics: for lexical diversity they used TTR and MTLD, for syntactic complexity MLT and DC/T, for readability Flesch–Kincaid and Gunning-Fog, and lastly they also measured lexical sophistication.

#v(1em)

The main metrics are summarized in table @tab:lexical_complexity_metrics.\ 
This project measures complexity along the lexical dimension only, using the metric of textual lexical diversity. MTLD was chosen over TTR for its robustness to text length, and over syntactic/readability measures for its lower implementation cost.



#v(1em)
#figure(
table(
columns: (auto, auto, 14em, auto),
align: (center, center, center, center),
stroke: none,
inset: 5pt,
fill: (col, row) => {
if row == 0 { rgb("#B5001B") }
else if calc.rem(row, 2) == 0 { rgb("#B5001B33") }
else { white }
    },
table.hline(stroke: 0.5pt),
align(center, text(fill:white)[*Metric*]), align(center, text(fill:white)[*What it measures*]), align(center, text(fill:white)[*Basis*]), align(center, text(fill:white)[*Output*]),
//table.hline(stroke: 0.5pt),
    [TTR], [Lexical diversity], [Ratio of unique word types to total tokens], [Raw ratio (0--1), length-sensitive],
    [MTLD], [Lexical diversity], [Mean length of word sequences maintaining a TTR above a fixed threshold (0.720)], [Words per factor, robust to text length],
    [Flesch Reading Ease], [Sentence/word-length readability], [Average sentence length + average syllables per word], [0--100, higher = easier],
    [Dale--Chall], [Vocabulary familiarity], [\% of words outside a \~3,000-word familiar-word list + average sentence length], [US grade level],
    [SMOG], [Polysyllabic density], [Count of 3+ syllable words across a fixed sentence sample], [US grade level],
    [Yule's K], [Lexical diversity], [Statistic on word-frequency distribution, weights repeated word types more heavily], [Constant K, lower = more diverse],
    [Gzip Compression], [Information-theoretic complexity], [Compressed-to-original size ratio via gzip; more compressible text = more redundant/predictable], [Compression ratio, lower = more predictable],
    [Flesch--Kincaid Grade Level], [Sentence/syllable-density readability], [0.39 x words/sentence + 11.8 x syllables/word -- 15.59], [US grade level],
    [Gunning Fog Index], [Polysyllabic-word density], [0.4 x (words/sentence + 100 x complex-words/words)], [US grade level],
    [MLT], [Syntactic complexity (elaboration)], [Total words / total T-units], [Words per T-unit],
    [DC/T], [Syntactic complexity (subordination)], [Total dependent clauses / total T-units], [Dependent clauses per T-unit],
table.hline(stroke: 0.5pt),
  ),
caption: [Comparison of common textual complexity/readability metrics]
) <tab:lexical_complexity_metrics>
#v(1em)


== Polarization <sec:sots_polarization>

- What is
- Common metrics
- State of the art: what has been done in the field, what are the gaps, what are the limitations


== Sentiment Analysis <sec:sots_sentiment_analysis>

- What is
- Common metrics
- State of the art: what has been done in the field, what are the gaps, what are the limitations




#include("../bibliography/bibliography.typ")
