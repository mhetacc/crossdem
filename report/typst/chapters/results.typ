#import "../config/variables.typ": *
#import "../config/thesis-config.typ": *
#pagebreak(to:"odd")

= Results <ch:results>

== Textual Complexity <sec:res_textual_complexity>

=== Measure of Textual Lexical Diversity <sec:mtld>

Measure of Textual Lexical Diversity (MTLD) is a metric used to assess the diversity of vocabulary in a text. It calculates the average length of sequences of words that maintain a certain level of lexical diversity, providing insights into the richness and variety of language used in the text. yada yada

=== Prime Minister's MTLDs <sec:mtld_pms> 

==== Boxplot of MTLD Values for Each Italian Prime Minster <sec:mtld_pms_boxplot>

#subpar.grid(
  rows: 2,
  gutter: 5pt,
  figure(
    image("../images/mtld_pms_boxplot.png", width: 100%),
    caption: [Boxplot of MTLD values for each Italian Prime Minster, without overall median.]
  ), <fig:pms_boxplot>,
  figure(
    image("../images/mtld_pms_boxplot_medianALL.png", width: 100%),
    caption: [Boxplot of MTLD values for each Italian Prime Minster, with overall median.]
  ), <fig:pms_boxplot_medianALL>,
  v(0.2em),
  caption: [@fig:pms_boxplot and @fig:pms_boxplot_medianALL show MTLD values for each Italian Prime Minster, ordered by their first time in office. This allows for not only a direct comparison between Prime Ministers, but also a comparison of the evolution of MTLD values over time. Prime Minister with fewer than 100 speeches are omitted.],
  label: <fig:dataset>,
)

==== Evolution Over Time of MTLD Values for Each Italian Prime Minster <sec:mtld_pms_evolution>

- what is LOWESS

#subpar.grid(
  rows: 2,
  gutter: 5pt,
  figure(
    image("../images/mtld_pms_LOWESS.png", width: 100%),
    caption: [LOWESS curve of MTLD values for each Italian Prime Minster, without overall medians.]
  ), <fig:pms_lowess>,
  figure(
    image("../images/mtld_pms_LOWESS_withmedians.png", width: 100%),
    caption: [LOWESS curve of MTLD values for each Italian Prime Minster, with overall medians.]
  ), <fig:pms_lowess_medianALL>,
  v(0.2em),
  caption: [@fig:pms_lowess and @fig:pms_lowess_medianALL show MTLD values for each Italian Prime Minster over their careers span. The LOWESS curve allows was chosen to aid in the interpretation of the values, and the overall medians allow for a comparison between Prime Ministers. Prime Minister with fewer than 100 speeches are omitted.],
  label: <fig:dataset>,
)

=== VDEM 

==== 5 years

#subpar.grid(
  rows: 2,
  gutter: 5pt,
  figure(
    image("../images/mtld_vdem_box5y_combined.png", width: 100%),
    caption: [MTLD values in a Boxplot by 5-year periods, with VDEM indices. Each grey box combines all speeches for all political leanings in that 5-year period.]
  ), <fig:vdem_box5y_combined>,
  figure(
    image("../images/mtld_vdem_box5years_all.png", width: 100%),
    caption: [MTLD values in a Boxplot by 5-year periods, with VDEM indices. As above, each grey box combines all speeches for all political leanings in that 5-year period, while the colored boxes represent respectively center-leaning (in green), left-leaning (in red), and right-leaning (in blue) MTLD values in that 5-year preiod.]
  ), <fig:vdem_box5years_all>,
  v(0.2em),
  caption: [MTLD values in a Boxplot by 5-year periods. There seem to be a reduction in MTLD variance starting from 1989 all the way to 2019, whith an abrupt inversion in the 2020-2025 period. If this is a correlation with the inflection of some VDEM indices, it is not clear.],
  label: <fig:vdem_box5y>,
)

==== 10 years

#subpar.grid(
  rows: 2,
  gutter: 5pt,
  figure(
    image("../images/mtld_vdem_box10y_combined.png", width: 100%),
    caption: [MTLD values in a Boxplot by 10-year periods, with VDEM indices. Each grey box combines all speeches for all political leanings in that 10-year period.]
  ), <fig:vdem_box10y_combined>,
  figure(
    image("../images/mtld_vdem_box10years_all.png", width: 100%),
    caption: [MTLD values in a Boxplot by 10-year periods, with VDEM indices. As above, each grey box combines all speeches for all political leanings in that 10-year period, while the colored boxes represent respectively center-leaning (in green), left-leaning (in red), and right-leaning (in blue) MTLD values in that 10-year preiod.]
  ), <fig:vdem_box10years_all>,
  v(0.2em),
  caption: [MTLD values in a Boxplot by 10-year periods. There seem to be a reduction in MTLD variance starting from 1989 all the way to 2025. If this is a correlation with the inflection of some VDEM indices, it is not clear.],
  label: <fig:vdem_box10y>,
)

==== All

#subpar.grid(
  rows: 2,
  gutter: 1pt,
  figure(
    image("../images/mtld_vdem_line_combined.png", width: 100%),
    caption: [MTLD values plotted for each year, aggregating all speeches from all political leanings. Each dot of the graph (for each year) is scaled based on the amount of speeches available for that specific year. The MTLD line chart is plotted against VDEM indices.]
  ), <fig:vdem_line_combined>,
  figure(
    image("../images/mtld_vdem_line_all_leanings.png", width: 100%),
    caption: [MTLD values plotted for each year, aggregating speeches from three political leanings, respectively colored as green (center), red (left), and blue (right). Each dot of the graph (for each year) is scaled based on the amount of speeches available for that specific year. The MTLD line chart is plotted against VDEM indices.]
  ), <fig:vdem_line_all_leanings>,
  v(0.2em),
  caption: [MTLD values aggregated for each year, plotted against VDEM indices. There does not seem to be a correlation between a decrease in complexity and a decrease in democratic indices. Instead, the graph seems to suggest the opposite.],
  label: <fig:vdem_line>
)

=== Conclusions <sec:mtld_conclusions>

There does not seem to be a clear correlation between MTLD values and democratic indices, with the exception for the variance which ...

== Polarization <sec:res_polarization>

=== Prime Minister's Lexical Similarity <sec:lexical_similarity_pms>

#subpar.grid(
  columns: 2,
  gutter: 1pt,
  figure(
    image("../images/heatmap_words.png", width: 100%),
    caption: [Words similarity.]
  ), <fig:heatmap_words>,
  figure(
    image("../images/heatmap_jaccard.png", width: 100%),
    caption: [Jaccard similarity.]
  ), <fig:heatmap_jaccard>,
  v(0.2em),
  caption: [Heatmaps showing lexical similarity between Prime Ministers' speeches. @fig:heatmap_words was made by pooling the 1000 most used words by each Prime Minister, then calculating how many words are shared between each of them. @fig:heatmap_jaccard, on the other hand, is made by calculating the Jaccard index between each pair of Prime Ministers, by pooling _all_ words from all speeches used by each Prime Minister.],
  label: <fig:heatmaps_pms>,
)

=== Political Leanings Lexicons Over Time <sec:lexicons_over_time>

#subpar.grid(
  columns: 2,
  gutter: 1pt,
  figure(
    image("../images/polarization_stackbars_top1k.png", width: 100%),
    caption: [Top $1,000$ pooling.]
  ), <fig:stack_top1k>,
  figure(
    image("../images/polarization_stackbars_top10k.png", width: 100%),
    caption: [Top $10,000$ pooling]
  ), <fig:stack_top10k>,
  v(0.2em),
  caption: [All speeches are pooled in 5-year time frames. Then, for each 5-year time frame, the top-N most frequently used words are extracted for each political leaning #footnote[A speech is considered "right-leaning" if it pertains a right-leaning Prime Minister.] (one thousands words for graph at @fig:stack_top1k, and ten thousands words for graph at  @fig:stack_top10k). This results in three distinct sets#footnote[When speeches for each leaning are present. Otherwise only two, one, or no set at all can be extracted from that 5-year time frame.] of words for left, right, and center leaning speeches respectively. \

  The graph shows, for each 5-year time frame, words in common among all leanings (in grey), and words unique for each leaning (in red, blue, and green respectively). For the years with most data (from 1985 to 2015), @fig:stack_top1k shows a progressive increase in unique vocabularies compared to a decrease in shared ones, which can be interpreted as symptoms of increasing polarization.],
  label: <fig:polarization_stackbars>,
)

=== t-SNE <sec:tsne>

==== Word2Vec: Word Embeddings

  #figure(
    image("../images/tsne_word2vec.png", width: 100%),
    caption: [Top-1000 words #footnote[Top-1000 words means pooling the one thousand most used words of a specific Prime Minister. Stopwords are removed and the lexicon is lemmatized.] from each Prime Minster. The embedding vectors are pretrained Italian word vectors (CBOW, 300 dimensions) taken from _fastText_. Words shared by all Prime Ministers are displayed as black rhombuses. The graph show a lot of clustering, suggesting a certain similarity among Prime Ministers. That being said, the graph is also too hard to read to gain any conclusive evidence.]
  ), <fig:tsne_word2vec>

==== Doc2Vec: Speeches Embeddings

#subpar.grid(
  columns: 2,
  gutter: 1pt,
  figure(
    image("../images/tsne_doc2vec_pms.png", width: 100%),
    caption: [Doc2Vec: Prime Ministers]
  ), <fig:doc2vec_pms>,
  figure(
    image("../images/tsne_doc2vec_leanings.png", width: 100%),
    caption: [Doc2Vec: political leaning]
  ), <fig:doc2vec_leanings>,
  grid.cell(colspan: 2, align: center)[
    #figure(
      image("../images/tsne_doc2vec_years.png", width: 50%),
      caption: [Doc2Vec: year periods]
    ) <fig:doc2vec_years>
  ],
  caption: [Using `TfidfVectorizer` from `sklearn` library, I computed the embeddings for the whole speeches #footnote[Each speech counts as a document.]. They can then be projected in two dimensions. @fig:doc2vec_pms shows evident clustering, suggesting that most prime ministers have a lexical style and wording that are unique to them. @fig:doc2vec_leanings stresses this even more, showing how different political leanings occupy different regions in the vector space.
  
  On the other hand, @fig:doc2vec_years shows two main clustering regions: on the top, speeches from 1945 to 1955 gather, while speeches from 1991 to 2025 are more uniformly scattered across the whole vector space. This suggests that early speeches were significantly different compared to modern ones, while speeches from the nineties onward are quite similar.],
  label: <fig:doc2vec>,
)