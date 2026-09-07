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

==== Doc2Vec: Speech Embeddings

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
  caption: [Using `TfidfVectorizer` from `sklearn` library, I computed one embedding for each speech #footnote[Each speech counts as a document.]. The embeddings can then be projected in two dimensions. @fig:doc2vec_pms shows the projected speech vectors grouped by Prime Minsters. We can see clustering, suggesting that most prime ministers have a lexical style and wording that are unique to them. @fig:doc2vec_leanings groups the vectors by political leaning, showing that different leanings occupy different and distinct regions in the vector space. Both graphs strongly hints to a polarized political landscape.
  
  On the other hand, @fig:doc2vec_years shows two main clustering regions: on the top, speeches from 1945 to 1955 gather, while speeches from 1991 to 2025 are more uniformly scattered across the whole vector space. This suggests that earlier speeches were significantly different compared to modern ones, while speeches from the nineties onward are quite similar.],
  label: <fig:doc2vec>,
)

*TODO: compare with VDEM polarization indices (if exists).*

=== Conclusions <sec:polarization_conclusions>

We see quite a bit of polarization, but ...

== Sentiment Analysis

=== Democratic Indices Against Sentiment Scoring

#subpar.grid(
  rows: 2,
  gutter: 1pt,
  figure(
    image("../images/sentiments_vdem_combined.png", width: 100%),
    caption: [Sentiment values plotted for each year, aggregating all speeches from all political leanings. Each dot of the graph (for each year) is scaled based on the amount of speeches available for that specific year. The confidence intervals are shown. The sentiment scores chart is plotted against VDEM indices.]
  ), <fig:sentiments_vdem_combined>,
  figure(
    image("../images/sentiments_vdem_polleanings.png", width: 100%),
    caption: [Sentiment values plotted for each year, aggregating speeches from three political leanings, respectively colored as green (center), red (left), and blue (right). Each dot of the graph (for each year) is scaled based on the amount of speeches available for that specific year. The The sentiment scores line chart is plotted against VDEM indices.]
  ), <fig:sentiments_vdem_polleanings>,
  v(0.2em),
  caption: [Sentiment analysis results for _hate speech_, _aggressiveness_, and _negativity_ plotted against VDEM indices. Its hart to tell wether there is any correlation between them.],
  label: <fig:sentiment_vdem>
)

=== Toxicity (TODO: change name)

First thing first: hate speech is so low for everyone that we can ignore it


#subpar.grid(
  columns: 2,
  rows: 2,
  gutter: 5pt,
  figure(
    image("../images/sentiments_2d_pms.png", width: 100%),
    caption: [Sentiment: Prime Ministers ($|"speeches"|gt.eq 100$).]
  ), <fig:sentiments_2d_pms>,
  figure(
    image("../images/sentiments_2d_leanings.png", width: 100%),
    caption: [Sentiment: leanings.]
  ), <fig:sentiments_2d_leanings>,
  figure(
    image("../images/sentiments_2d_years_zoomout.png", width: 100%),
    caption: [Sentiment: years zoomed out.]
  ), <fig:sentiments_2d_years_zoomout>,
  figure(
    image("../images/sentiments_2d_years_zoomin.png", width: 100%),
    caption: [Sentiment: years zoomed in.]
  ), <fig:sentiments_2d_years_zoomin>,
  v(0.2em),
  caption: [Sentiment analysis results for _negativity_ and _aggressiveness_. Values go from zero to one, and the classification task considers three possibile values for each speech: _low_ ($0$), _mid_ ($0.5$), and _high_ ($1$). 
  
  Size of bubbles depends on the amount of speeches. @fig:sentiments_2d_pms project results for single Prime Ministers: Berlusconi stands out as the most aggressive by far. @fig:sentiments_2d_leanings project results aggregated by leanings. The right appears to be more aggressive, while the left more negative. The center seems to be more positive than both. The last two figures show the sentiment scores aggregated by years (with 5-year pool range). While @fig:sentiments_2d_years_zoomout shows an outlier for the period $1976-1980$, @fig:sentiments_2d_years_zoomin shows that overall the sentiment scores are quite close to each other, without great variance especially for periods with a lot of speeches.],
  label: <fig:sentiment_2axis>,
)

=== Targets 

Five possible targets: 
- None;
- Political adversaries;
- Gender minorities;
- Religious minorities;
- Ethnic minorities.

The targets are classified independently to the sentiment scores. For example, a speech could have _low_ aggressiveness and still be targeting political adversaries. 

#subpar.grid(
  columns: 2,
  gutter: 5pt,
  figure(
    image("../images/target_leaderboard_polAdv.png", width: 100%),
    caption: [Target: political adversaries. Grouped by: PMs.]
  ), <fig:target_leaderboard_polAdv_pms>,
  figure(
    image("../images/target_leaderboard_polAdv_years.png", width: 100%),
    caption: [Target: political adversaries. Grouped by: years.]
  ), <fig:target_leaderboard_polAdv_years>,
  grid.cell(colspan: 2, align: center)[
    #figure(
      image("../images/target_leaderboard_polAdv_leanings.png", width: 50%),
      caption: [Target: political adversaries. Grouped by: leanings.]
    ) <fig:target_leaderboard_polAdv_leanings>
  ],
  caption: [All graphs show the percentage of speeches that target political adversaries. @fig:target_leaderboard_polAdv_pms shows which Prime Minister speaks more often about the opposition (prime ministers with less than 100 speeches are omitted). @fig:target_leaderboard_polAdv_years shows in which 5-year periods there are more speeches targeting political adversaries (ordered by year). Lastly, @fig:target_leaderboard_polAdv_leanings shows which of the three political fields is more likely to speak about the opposing front. The results show how, across the board, more than one speech out of two targets the opposition. This is true regardless of time period or affiliation.],
  label: <fig:target_leaderboard_polAdv>,
)

#v(2em)
Thankfully, Italian Prime Minister apparently do not target minorities often.

#subpar.grid(
  columns: 3,
  gutter: 1pt,
  figure(
    image("../images/target_leaderboard_ethn_years.png", width: 100%),
    caption: [Target: ethnic minorities.]
  ), <fig:target_leaderboard_ethn_years>,
  figure(
    image("../images/target_leaderboard_gnd_years.png", width: 100%),
    caption: [Target: gender minorities.]
  ), <fig:target_leaderboard_gnd_years>,
  figure(
    image("../images/target_leaderboard_rel_years.png", width: 100%),
    caption: [Target: religious minorities.]
  ), <fig:target_leaderboard_rel_years>,
  v(0.2em),
  caption: [Overall, an extremely low percentage of speeches target minority groups. Therefore, I will ignore this analysis. (TODO explain better.. within error yada yada).],
  label: <fig:target_leaderboard_lowvalues>
)

=== Conclusions <sec:sentiment_conclusion>

Italian prime minister seem to be overall a bit aggressive and negative, and they speak more often then not about the opposition. Almost no traces of hate speech and attacks against minority groups are found in the data.

This does not seem to change over time, failing to explain the VDEM indices drop in 2021.