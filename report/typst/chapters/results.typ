#import "../config/variables.typ": *
#import "../config/thesis-config.typ": *
//#pagebreak(to:"odd")


#set heading(numbering:"1.")
#set math.equation(numbering: "1.", supplement: none)



= Results <ch:results>

This chapter will present the results from the analysis on the dataset. 

== Textual Complexity <sec:res_textual_complexity>

=== #pms' MTLDs <sec:mtld_pms> 

Let's first take a look at the #pms themselves. Figure @fig:mtld_boxplot_pms shows two box plots where each box is a #pm with at least twenty speeches, ordered by variability (whisker-to-whisker length) and median lexical diversity (median MTLD) respectively. We can visually divide the #pms into two groups: high- and low-variance. The first group, with seven out of twenty-one #pms (Ciampi, De Gasperi, Craxi, Fanfani, Spadolini, Dini, and Draghi) exhibits high variability in the complexity of their speeches, suggesting diverse speech styles. This is corroborated by their standard deviations (refer to table @tab:mtld_pms for the exact values), all above the average of $24.32$ (Ciampi, De Gasperi, Fanfani, and Draghi are even above thirty). All the other #pms, pertaining to the low-variance group, seem more consistent in the complexity of their speeches, and their standard deviations are all under the average. That being said, between Forlani and De Mita the interquartile range almost cuts in half, going from $28.76$ to $15.86$ for a reduction of $44.85%$, telling us that even in the low-variance group there are strong differences in variance between #pms. In this last group, two exceptions emerge: Conte, whose standard deviation of $24.32$ sits exactly on the average, and Goria with a standard deviation of $29.26$. A possible explanation could be found in their low speech count, meaning the standard deviation is simply a noisy estimate. Incidentally, Fanfani and Draghi are in a similar position with twenty and twenty-six speeches each, and already sit in the high-variance group. De Gasperi's complexity stands above the rest even with a rich corpus of over 400 speeches. This could be explained either by a stylistic difference or by the fact that their speeches are the only ones not transcribed by Whisper



Overall, #pms in this study exhibit variation between one another, suggesting that there is not a "complexity typical of a #pm", and that each one has their own style and richness of vocabulary. 


#subpar.grid(
  rows: 2,
  gutter: 5pt,
  figure(
    image("../images/pms_box_byVariance.png", width: 100%),
    caption: [Box plot of MTLD values for each Italian #pm, ordered by whisker-to-whisker length.]
  ), <fig:pms_boxplot_byVariance>,
  figure(
    image("../images/pms_box_byMTLD.png", width: 100%),
    caption: [Box plot of MTLD values for each Italian #pm, ordered by median MTLD.]
  ), <fig:pms_boxplot_byMTLD>,
  v(0.2em),
  caption: [@fig:pms_boxplot_byVariance and @fig:pms_boxplot_byMTLD show MTLD values for each Italian #pm. The mean is a dotted line. #pms with fewer than 20 speeches are omitted.],
  label: <fig:mtld_boxplot_pms>,
)

Table @tab:mtld_pms also shows the slope for each #pm. This represents whether, during their careers, the complexity of their speeches increased, decreased, or remained the same. Most #pms show no significant trend, with six exceptions: Draghi (+0.462), Conte (+0.384), De Gasperi (−0.330), Meloni (+0.263), Craxi (−0.265), and Dini (−0.236). The trends can also be visualized in figure @fig:mtld_lowess_pms, where a LOWESS regression #footnote[LOWESS was chosen over linear models or splines because it combines much of the simplicity of linear least squares regression with the flexibility of nonlinear regression. In short, it is flexible but interpretable.] has been plotted for each #pm's career. As expected, De Gasperi has the highest median, followed by a small group (Draghi, Fanfani, Ciampi, Spadolini, Monti) that also sits above the rest, while the other #pms cluster around the overall median. The regressions for Draghi, Conte, and Fanfani look less consistent, which is expected since they do not have a lot of data points.

#v(1em)
#[
#show figure: set block(breakable: true)
#figure(
table(
columns: (auto, auto, auto, auto, auto, auto, auto, auto),
align: center + horizon,
stroke: none,
inset: 5pt,
fill: (col, row) => {
if row == 0 { rgb("#B5001B") }
else if calc.rem(row, 2) == 0 { rgb("#B5001B33") }
else { white }
    },
table.hline(stroke: 0.5pt),
text(fill:white)[*PM*], text(fill:white)[*\# Speeches*], text(fill:white)[*Mean*], text(fill:white)[*Median*], text(fill:white)[*Std. dev.*], text(fill:white)[*IQR*], text(fill:white)[*\# Outliers*], text(fill:white)[*Trend slope*],
    [De Gasperi], [473], [141.83], [137.64], [35.88], [49.50], [2], [-0.330],
    [Fanfani], [20], [119.80], [120.31], [37.59], [50.09], [0], [-0.130],
    [Andreotti], [390], [114.81], [111.74], [23.77], [20.42], [28], [0.025],
    [Cossiga], [209], [89.12], [87.69], [21.03], [26.41], [4], [0.180],
    [Forlani], [71], [104.28], [105.13], [23.38], [28.76], [0], [0.016],
    [Spadolini], [99], [118.43], [117.94], [25.58], [34.01], [1], [0.035],
    [Craxi], [103], [101.63], [97.06], [27.29], [39.60], [0], [-0.265],
    [Goria], [40], [113.30], [111.16], [29.26], [31.68], [2], [0.120],
    [De Mita], [207], [93.97], [93.97], [16.62], [15.86], [10], [-0.060],
    [Amato], [890], [97.90], [96.47], [16.07], [18.98], [25], [0.144],
    [Ciampi], [70], [120.44], [117.78], [37.15], [50.30], [0], [-0.066],
    [Berlusconi], [519], [94.92], [93.87], [21.17], [23.83], [19], [0.194],
    [Dini], [308], [110.88], [106.95], [25.97], [33.71], [8], [-0.236],
    [Prodi], [508], [95.42], [95.38], [19.81], [22.25], [16], [0.044],
    [D'Alema], [819], [95.23], [93.39], [16.08], [15.93], [52], [0.153],
    [Monti], [238], [116.15], [116.40], [16.42], [18.57], [11], [-0.034],
    [Letta], [500], [86.59], [84.34], [17.37], [19.87], [18], [-0.104],
    [Renzi], [143], [94.06], [90.74], [21.15], [26.05], [2], [-0.166],
    [Conte], [29], [104.02], [108.58], [24.32], [24.67], [1], [0.384],
    [Draghi], [26], [126.53], [134.68], [33.52], [55.17], [0], [0.462],
    [Meloni], [245], [99.89], [97.04], [21.20], [26.85], [1], [0.263],
table.hline(stroke: 0.5pt),
  ),
caption: [Descriptive statistics of the MTLD (Measure of Textual Lexical Diversity) per #pm, ordered by first term in office. In order: #pm's name, number of speeches, mean, median, standard deviation, interquartile range (IQR), number of outliers (speeches outside the whiskers of the boxplot), and slope of the MTLD trend over the whole career (i.e., $0.5$ means that the fitted MTLD increases by 50 points from the first registered speech to the last). #pms with too few usable speeches are not included.]
) <tab:mtld_pms>
]
#v(1em)


#subpar.grid(
  rows: 2,
  gutter: 5pt,
  figure(
    image("../images/mtld_pms_LOWESS.png", width: 100%),
    caption: [LOWESS curve of MTLD values for each Italian #pm, without overall median.]
  ), <fig:pms_lowess>,
  figure(
    image("../images/mtld_pms_LOWESS_withmedians.png", width: 100%),
    caption: [LOWESS curve of MTLD values for each Italian #pm, with overall median.]
  ), <fig:pms_lowess_medianALL>,
  v(0.2em),
  caption: [@fig:pms_lowess and @fig:pms_lowess_medianALL show MTLD values for each Italian #pm over their career span. The LOWESS curve was chosen to aid in the interpretation of the values. #pm with fewer than 20 speeches are omitted.],
  label: <fig:mtld_lowess_pms>,
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
  gutter: 3pt,
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

=== #pm's Lexical Similarity <sec:lexical_similarity_pms>

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
  caption: [Heatmaps showing lexical similarity between #pms' speeches. @fig:heatmap_words was made by pooling the 1000 most used words by each #pm, then calculating how many words are shared between each of them. @fig:heatmap_jaccard, on the other hand, is made by calculating the Jaccard index between each pair of #pms, by pooling _all_ words from all speeches used by each #pm.],
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
  caption: [All speeches are pooled in 5-year time frames. Then, for each 5-year time frame, the top-N most frequently used words are extracted for each political leaning #footnote[A speech is considered "right-leaning" if it pertains a right-leaning #pm.] (one thousands words for graph at @fig:stack_top1k, and ten thousands words for graph at  @fig:stack_top10k). This results in three distinct sets#footnote[When speeches for each leaning are present. Otherwise only two, one, or no set at all can be extracted from that 5-year time frame.] of words for left, right, and center leaning speeches respectively. \

  The graph shows, for each 5-year time frame, words in common among all leanings (in grey), and words unique for each leaning (in red, blue, and green respectively). For the years with most data (from 1985 to 2015), @fig:stack_top1k shows a progressive increase in unique vocabularies compared to a decrease in shared ones, which can be interpreted as symptoms of increasing polarization.],
  label: <fig:polarization_stackbars>,
)

=== t-SNE <sec:tsne>

==== Word2Vec: Word Embeddings

  #figure(
    image("../images/tsne_word2vec.png", width: 100%),
    caption: [Top-1000 words #footnote[Top-1000 words means pooling the one thousand most used words of a specific #pm. Stopwords are removed and the lexicon is lemmatized.] from each #pm. The embedding vectors are pretrained Italian word vectors (CBOW, 300 dimensions) taken from _fastText_. Words shared by all #pms are displayed as black rhombuses. The graph show a lot of clustering, suggesting a certain similarity among #pms. That being said, the graph is also too hard to read to gain any conclusive evidence.]
  ), <fig:tsne_word2vec>

==== Doc2Vec: Speech Embeddings

#subpar.grid(
  columns: 2,
  gutter: 3pt,
  figure(
    image("../images/tsne_doc2vec_pms.png", width: 100%),
    caption: [Doc2Vec: #pms]
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
  caption: [Using `TfidfVectorizer` from `sklearn` library, I computed one embedding for each speech #footnote[Each speech counts as a document.]. The embeddings can then be projected in two dimensions. @fig:doc2vec_pms shows the projected speech vectors grouped by #pms. We can see clustering, suggesting that most #pms have a lexical style and wording that are unique to them. @fig:doc2vec_leanings groups the vectors by political leaning, showing that different leanings occupy different and distinct regions in the vector space. Both graphs strongly hints to a polarized political landscape.
  
  On the other hand, @fig:doc2vec_years shows two main clustering regions: on the top, speeches from 1945 to 1955 gather, while speeches from 1991 to 2025 are more uniformly scattered across the whole vector space. This suggests that earlier speeches were significantly different compared to modern ones, while speeches from the nineties onward are quite similar.],
  label: <fig:doc2vec>,
)

*TODO: compare with VDEM polarization indices (if exists).*

=== Conclusions <sec:polarization_conclusions>

We see quite a bit of polarization, but ...

== Sentiment Analysis <sec:res_sentiment_analysis>

=== Democratic Indices Against Sentiment Scoring <sec:vdem_vs_sentiment>

#subpar.grid(
  rows: 2,
  gutter: 3pt,
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

=== Toxicity (TODO: change name) <sec:toxicity>

First thing first: hate speech is so low for everyone that we can ignore it


#subpar.grid(
  columns: 2,
  rows: 2,
  gutter: 5pt,
  figure(
    image("../images/sentiments_2d_pms.png", width: 100%),
    caption: [Sentiment: #pms ($|"speeches"|gt.eq 100$).]
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
  
  Size of bubbles depends on the amount of speeches. @fig:sentiments_2d_pms project results for single #pms: Berlusconi stands out as the most aggressive by far. @fig:sentiments_2d_leanings project results aggregated by leanings. The right appears to be more aggressive, while the left more negative. The center seems to be more positive than both. The last two figures show the sentiment scores aggregated by years (with 5-year pool range). While @fig:sentiments_2d_years_zoomout shows an outlier for the period $1976-1980$, @fig:sentiments_2d_years_zoomin shows that overall the sentiment scores are quite close to each other, without great variance especially for periods with a lot of speeches.],
  label: <fig:sentiment_2axis>,
)

=== Targets <sec:targets>

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
  caption: [All graphs show the percentage of speeches that target political adversaries. @fig:target_leaderboard_polAdv_pms shows which #pm speaks more often about the opposition (#pms with less than 100 speeches are omitted). @fig:target_leaderboard_polAdv_years shows in which 5-year periods there are more speeches targeting political adversaries (ordered by year). Lastly, @fig:target_leaderboard_polAdv_leanings shows which of the three political fields is more likely to speak about the opposing front. The results show how, across the board, more than one speech out of two targets the opposition. This is true regardless of time period or affiliation.],
  label: <fig:target_leaderboard_polAdv>,
)

#v(2em)
Thankfully, Italian #pm apparently do not target minorities often.

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

Italian #pm seem to be overall a bit aggressive and negative, and they speak more often then not about the opposition. Almost no traces of hate speech and attacks against minority groups are found in the data.

This does not seem to change over time, failing to explain the VDEM indices drop in 2021.


#include "../bibliography/bibliography.typ"


#include "conclusions.typ"
#include "future_works.typ"
#include "../appendix/appendix-A.typ"