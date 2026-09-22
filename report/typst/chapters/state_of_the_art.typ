#import "../config/variables.typ": *
#import "../config/thesis-config.typ": *
//#pagebreak(to:"odd")

= State of the Art <ch:state-of-the-art>

== Textual Complexity <sec:sots_textual_complexity>

Text complexity or readability refers to how difficult a text is to understand @dubay_principles_2004, influenced by linguistic factors such as word choice (e.g., "utilize" vs. "use"), sentence structure (complex vs. simple), and content type (academic vs. children’s books) @dale_formula_1948 @graesser_cohmetrix_2004. \
Common comprehension metrics follow. Flesch Reading Ease (FRE) @flesch_new_1948 considers the average sentence length and syllables per word, and outputs a value between zero (hard to read) and one hundred (easy to read). \
Dale-Chall @dale_formula_1948 measures a raw score taking in consideration a list of 3000 words that groups of fourth-grade American students could reliably understand, considering any word not on that list to be difficult. \
Lastly, SMOG @mclaughlin_smog_1969, use intuitive features like sentence length and word complexity. These measures overlook deeper dimensions such as coherence and style, motivating machine learning and deep learning approaches 

Another way to measure the complexity of text is by measuring its *lexical diversity*, which is the ratio of different unique word types to the total number of words. In a sense, it measures the vocabulary richness of a sample. \
The most common metric is Type-Token Ratio, obtained by simply dividing word types over tokens. A TTR of $0.5$ means that half of the words in the sample appear only once. \
A more refined metric, which I use in this project, was introduced McCarthy in 2005: it is the measure of textual lexical diversity (MTLD) @mccarthy_assessment_2005. 
It uses a sequential algorithm to count tokens until lexical repetition forces the ratio below a fixed threshold, reducing text-length bias, and its widely applied in computational linguistics for corpus profiling, tracking writing development, and evaluating machine translation quality.
Because it operationalizes how long a text can sustain lexical novelty before repetition lowers TTR below that threshold, MTLD has become a standard tool in applied linguistics and computational text analysis, and it is often used as a measure of lexical diversity, lexical complexity, or lexical sophistication  @lin_large_2025.

The metrics discussed above are summarized in table @tab:lexical_complexity_metrics.

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
table.hline(stroke: 0.5pt),
  ),
caption: [Comparison of common textual complexity/readability metrics]
) <tab:lexical_complexity_metrics>
#v(1em)

Let's now have a look at the recent research. \
Velasco and Roque (2025) @velasco_rethinking_2025 explored how does complexity affect language modeling across model sizes, if useful representations be learned from simpler text alone, and how does pretraining text complexity influence downstream language understanding. They used a subset of _FineWeb-Edu_ @penedo_fineweb_2024, then simplified by prompting _Llama 3.1 8B_ @grattafiori_llama_2024 at the paragraph level. \
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
They used three metrics: Yule’s K measure of lexical richness, gzip-based compression complexity and Flesch readability score. \
More in detail, Yule’s K-complexity *CIT TODO* quantifies how repetitive or diverse the vocabulary is, and it is largely independent of the overall length of a text, while G-Zip can be used to assess text repetitiveness by measuring its compression ratio, an approach already used in previous studies @parada-cabaleiro_song_2024 @desiderio_recurring_2023 @dimarco_patterns_2024.








== Polarization <sec:sots_polarization>

- What is
- Common metrics
- State of the art: what has been done in the field, what are the gaps, what are the limitations


== Sentiment Analysis <sec:sots_sentiment_analysis>

- What is
- Common metrics
- State of the art: what has been done in the field, what are the gaps, what are the limitations




#include("../bibliography/bibliography.typ")
