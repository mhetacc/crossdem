#import "@preview/subpar:0.2.2"

= The Corpus <sec:corpus>

== Similar Corpora <sec:similar_corpora>

== My Corpus <sec:my_corpus>

- Structure
- Content

#align()[
    #figure(image("../images/italian_prime_ministers.jpg", width: 90%), 
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
