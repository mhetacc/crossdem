#import "../config/variables.typ": *
#import "../config/thesis-config.typ": *
#pagebreak(to:"odd")


//#set heading(numbering:"1.")
//#set math.equation(numbering: "1.", supplement: none)



= Results <ch:results>

== Lexical Diversity <sec:res_textual_complexity>

Let’s first take a look at the #pms themselves. Figure @fig:pms_boxplot_byVariance shows the distribution of lexical diversity (MTLD) across the speeches of each #pm, with one box per #pm (#pms with fewer than twenty speeches are omitted). The boxes are ordered by spread, measured as whisker-to-whisker length, while figure @fig:pms_boxplot_byMTLD orders them by median MTLD instead.

We can visually divide the #pms into two groups: high- and low-variability (measured as the boxes' spread). The high-variability group, with seven out of twenty-one #pms (Ciampi, De Gasperi, Craxi, Fanfani, Spadolini, Dini, and Draghi) exhibit high variability in the diversity of their speeches, suggesting diverse speech styles. This is corroborated by their standard deviations (refer to table @tab:mtld_pms for the exact values), all above the average of $24.32$ (Ciampi, De Gasperi, Fanfani, and Draghi are even above thirty). Among these high-variability #pms there is a significant gap in variability: between Ciampi and Dini, for example, the interquartile range differs by $32.98%$, going from $50.3$ to $33.71$. \

The remaining #pms (pertaining to the low-variability group), while having less per-#pm variability compared to the high-variability group, are even more diverse between one another: between Forlani and De Mita the interquartile range cuts almost in half, going from $28.76$ to $15.86$ for a reduction of $44.85%$. In this last group, two #pms have a standard deviation above average: Conte, whose standard deviation of $24.32$ sits exactly on the average, and Goria with a standard deviation of $29.26$. A possible explanation could be found in their low speech count, meaning the standard deviation is simply a noisy estimate. Incidentally, Fanfani and Draghi are in a similar position with twenty and twenty-six speeches each, and already sit in the high-variability group. 


The median MTLD varies a lot between #pms: from the highest (De Gasperi, $137.54$) to the lowest (Letta, $84,34$) there is a difference of $38.68%$, suggesting the absence of a "typical lexical complexity" for a #pm.
It's worth mentioning that De Gasperi's high median diversity could be explained by the fact that their speeches are the only ones not transcribed by Whisper.

Overall, #pms in this study exhibit variation between one another, both in terms of overall lexical complexity and in the variability of said complexity, suggesting that each #pm is independent from the others. In short, no particular pattern emerges.

#figure(
  image("../images/pms_box_byVariance.png", width: 100%),
  caption: [Box plot of MTLD values for each Italian #pm, ordered by whisker-to-whisker length. The median is a dotted line. #pms with fewer than 20 speeches are omitted.],
) <fig:pms_boxplot_byVariance>

#figure(
  image("../images/pms_box_byMTLD.png", width: 100%),
  caption: [Box plot of MTLD values for each Italian #pm, ordered by median MTLD. The median is a dotted line. #pms with fewer than 20 speeches are omitted.],
) <fig:pms_boxplot_byMTLD>
#v(1em)

Figure @fig:pms_lowess_medianALL shows the evolution of the lexical diversity over each #pm's career, via LOWESS regression #footnote[LOWESS was chosen for visualising the evolution of MTLD over linear models or splines because it combines much of the simplicity of linear least squares regression with the flexibility of nonlinear regression. In short, it is flexible but interpretable.]. Once again, there does not seem to be any clear trend among #pms, a fact that is consistent with the last column of table @tab:mtld_pms, which shows the evolution of the MTLD (in percentage) during the span of the #pms' careers. Twelve #pms have positive changes, nine negative, so there is no common direction. Some show little to no change, like Andreotti (+2.18), Forlani (+1.51), and Monti (-2.89), while others change considerably, for example De Gasperi (-19.58), Cossiga (+23.64), Craxi (-23.75), and Meloni (+32.31). The MTLD evolution was calculated by fitting a linear regression to each #pm's career, and then extracting the rescaled slope, where _Slope_ is the fitted change in MTLD per percentage point of career elapsed, and _Intercept_ is the fitted MTLD at the start of the career: 

$ "Change %" = frac("Slope" dot 100, "Intercept") dot 100 $

I used a linear regression instead of a LOWESS to extract one easily interpretable number. One thing to note: the LOWESS regressions for Draghi, Conte, and Fanfani look less consistent, which is expected since their datasets are scarce. 


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
text(fill:white)[*PM*], text(fill:white)[*\# Speeches*], text(fill:white)[*Mean*], text(fill:white)[*Median*], text(fill:white)[*Std. dev.*], text(fill:white)[*IQR*], text(fill:white)[*\# Outliers*], text(fill:white)[*Career change (%)*],
    [De Gasperi], [473], [141.83], [137.64], [35.88], [49.50], [2], [-19.58],
    [Fanfani], [20], [119.80], [120.31], [37.59], [50.09], [0], [-9.93],
    [Andreotti], [390], [114.81], [111.74], [23.77], [20.42], [28], [+2.18],
    [Cossiga], [209], [89.12], [87.69], [21.03], [26.41], [4], [+23.64],
    [Forlani], [71], [104.28], [105.13], [23.38], [28.76], [0], [+1.51],
    [Spadolini], [99], [118.43], [117.94], [25.58], [34.01], [1], [+3.04],
    [Craxi], [103], [101.63], [97.06], [27.29], [39.60], [0], [-23.75],
    [Goria], [40], [113.30], [111.16], [29.26], [31.68], [2], [+11.11],
    [De Mita], [207], [93.97], [93.97], [16.62], [15.86], [10], [-6.26],
    [Amato], [890], [97.90], [96.47], [16.07], [18.98], [25], [+15.83],
    [Ciampi], [70], [120.44], [117.78], [37.15], [50.30], [0], [-5.31],
    [Berlusconi], [519], [94.92], [93.87], [21.17], [23.83], [19], [+22.84],
    [Dini], [308], [110.88], [106.95], [25.97], [33.71], [8], [-19.29],
    [Prodi], [508], [95.42], [95.38], [19.81], [22.25], [16], [+4.66],
    [D'Alema], [819], [95.23], [93.39], [16.08], [15.93], [52], [+17.23],
    [Monti], [238], [116.15], [116.40], [16.42], [18.57], [11], [-2.89],
    [Letta], [500], [86.59], [84.34], [17.37], [19.87], [18], [-11.50],
    [Renzi], [143], [94.06], [90.74], [21.15], [26.05], [2], [-16.06],
    [Conte], [29], [104.02], [108.58], [24.32], [24.67], [1], [+48.66],
    [Draghi], [26], [126.53], [134.68], [33.52], [55.17], [0], [+43.91],
    [Meloni], [245], [99.89], [97.04], [21.20], [26.85], [1], [+32.31],
table.hline(stroke: 0.5pt),
  ),
caption: [Descriptive statistics of the MTLD (Measure of Textual Lexical Diversity) per #pm, ordered by first term in office. In order: #pm's name, number of speeches, mean, median, standard deviation, interquartile range (IQR), number of outliers (speeches outside the whiskers of the boxplot), and the MTLD evolution over their careers, calculated by fitting a linear regression over each #pm's career. The percentage is relative to the fitted starting MTLD. Only #pms with at least twenty speeches are included.]
) <tab:mtld_pms>
]
#v(1em)


#figure(
  image("../images/mtld_pms_LOWESS_withmedians.png", width: 100%),
  caption: [LOWESS curve of MTLD values for each Italian #pm over their career span, without overall median. The LOWESS curve was chosen to aid in the visual interpretation of the values. #pm with fewer than 20 speeches are omitted. The overall median is plotted as a black dotted line.],
) <fig:pms_lowess_medianALL>
#v(1em)






























Looking now at the evolution of the lexical diversity and its relation with the democratic indices, the box plot in figure @fig:vdem_box5y_combined shows the lexical diversity (MTLD) of all speeches aggregated by 5-year periods rather than by #pms (without distinguishing between political leanings) between 1945 and 2025. Distinguishing between leanings (left, center, and right) is not as informative due to the unequal distribution of speeches, as previously shown in figure @fig:dataset. Nonetheless, from the graphs with such distinction (viewable in appendix @appx:vdem_5y_pms_leanings) we can infer that (within the time period with enough data, so after 1985) right-leaning speeches present both a higher median MTLD and a higher variability in the lexical diversity compared to left-leaning speeches, while center-leaning speeches are too few to allow a fair comparison.

Ignoring the period between 1960 and 1985 due to lack of data (only twenty-four speeches were collected for this period), the box plot shows a steady reduction in the variability of the MTLD until the 2020-2025 period, where it grows back up again. This is corroborated by the data shown in table @tab:mtld_periods: interquartile range steadily decreases from $52.61$ in the 1945-1949 period, to $20.62$ in the 2015-2019 period, then growing back up to $35.37$ in the 2020-2025 period, while whisker-to-whisker length goes from $184.56$ in the 1945-1949 period, to $78.6$ in the 2015-2019 period, and grows back up to $116.21$ in the 2020-2025 period. That being said, figure @fig:vdem_line_combined shows that between 2020 and 2022 the median MTLD suddenly drops, from $104.63$ in 2020, to $90.61$ in 2021 and $77.74$ in 2022 ($-25.7%$), and grows back up to $106.57$ in 2023. While this could suggest that the increase in variability is caused by the 2021-2022 period acting as an outlier, recomputing the 2020-2025 box while leaving out the period 2021-2022 gets us 120 speeches for an IQR of $36.44$ and a whisker-to-whisker length of $116.21$, so the observed increase in variability is still present.


In both graphs (figures @fig:vdem_box5y_combined and @fig:vdem_line_combined) democratic indices are also reported (sourced from V-Dem). They steadily grow from 1945 onward, but three out of six see a reduction of over $10%$ between 2020 and 2025 ($1.0$ is a perfect score): 
- _Participatory democracy_ goes from $0.68$ in 2020 to $0.569$ in 2025 ($-16.32%$);
- _Liberal democracy_ goes from $0.774$ in 2020 to $0.642$ in 2025 ($-17.05%$);
- _Electoral democracy_ goes from $0.857$ in 2020 to $0.745$ in 2025 ($-13.07%$).

_Scrutiny of executives_, on the other hand, sees a reduction of $5.04%$ (from $0.953$ to $0.905$), but this inflection does not happen until 2024, while _election quality_ and the _fairness of law and individual liberties_ remain unchanged.

// TODO finish this
The democratic indices and the spread, or variability, of the lexical diversity seem inversely correlated: when the spread decreases the indices increase, and vice versa when the spread increases the indices decrease. \
To check whether this correlation exists, and if so, it is not by chance, I calculated their Spearman's rank correlation coefficient $rho$ as well as their p-values. Both calculations were done by binning the spread for each year (rather than by 5-year periods as in figure @fig:vdem_box5y_combined) and comparing it with the V-Dem indices per year (already present in the V-Dem dataset). I compared only the three indices that see a reduction of over $10%$ in 2020.\ 


The increase of democratic indices concurs with a decrease in the variability of the lexical diversity, with an inversion when the variability of the lexical diversity grows back up again and the democratic indices decrease.

 To check whether there is a correlation between the two I calculated the Spearman's rank correlation coefficient $rho$, and to check whether such correlation is not by chance, I calculated the p-values. Both calculations were done by binning the spread for each year (rather than by 5-year periods) and comparing it with the V-Dem indices per year (already present in the V-Dem dataset). I compared only the three indices that see a reduction of over $10%$ in 2020.\ 
Since the years cannot be treated as independent observation, to calculate the p-values either shuffling or shifting is necessary. I opted for shifting since shuffling years randomly destroys the smoothness of both series, so the null hypothesis would be too easy to beat. Shifting keeps each series intact and only breaks the alignment. Confidence intervals for the $rho$ were obtained by bootstrapping the data 1,000 times. Since observations are not independent, I resampled chunks of consecutive years, each chunk ten years in size. Results are shown in table @tab:spearman_pvalues_mtld_vdem: spread and democratic indices show a negative $rho$ of about $-0.4$, suggesting the inverse correlation hinted by the graph, but the wide confidence intervals paired with p-values over $0.35$ tell us that not only the correlation is uncertain, it's also indistinguishable from chance.


#figure(
  image("../images/mtld_vdem_box5y_combined.png", width: 100%),
  caption: [MTLD values in a boxplot by 5-year periods, with V-Dem indices. Each grey box combines all speeches for all political leanings in that 5-year period. MTLD variability appears to decrease from 1989 to 2019, with an abrupt inversion in the 2020-2025 period. Whether this correlates with the inflection of some V-Dem indices is not clear. Note that this graph and figure @fig:vdem_line_combined use different Y-axis scales.],
) <fig:vdem_box5y_combined>

#figure(
  image("../images/mtld_vdem_line_combined.png", width: 100%),
  caption: [MTLD values plotted for each year, aggregating all speeches from all political leanings. Each dot is scaled by the number of speeches available for that year. The MTLD line chart is plotted against V-Dem indices. Note the different Y-axis scale compared to figure @fig:vdem_box5y_combined.],
) <fig:vdem_line_combined>

#v(1em)
#[
#show figure: set block(breakable: true)
#figure(
table(
columns: (auto, auto, auto, auto, auto, auto),
align: center + horizon,
stroke: none,
inset: 5pt,
fill: (col, row) => {
if row == 0 { rgb("#B5001B") }
else if calc.rem(row, 2) == 0 { rgb("#B5001B33") }
else { white }
    },
table.hline(stroke: 0.5pt),
text(fill:white)[*Period*], text(fill:white)[*\# Speeches*], text(fill:white)[*Median MTLD*], text(fill:white)[*IQR*], text(fill:white)[*Whisker-to-whisker*], text(fill:white)[*\# Outliers*],
    [1945-1949], [217], [139.24], [52.61], [184.56], [1],
    [1950-1954], [186], [125.82], [41.72], [155.95], [5],
    [1960-1964], [1], [115.04], [0.00], [0.00], [0],
    [1975-1979], [3], [85.14], [18.32], [36.65], [0],
    [1980-1984], [20], [108.15], [27.04], [73.58], [2],
    [1985-1989], [292], [104.24], [34.53], [131.82], [12],
    [1990-1994], [499], [97.20], [28.87], [111.17], [16],
    [1995-1999], [1137], [95.91], [25.86], [100.37], [54],
    [2000-2004], [1440], [94.33], [24.08], [94.23], [40],
    [2005-2009], [1207], [97.78], [23.79], [93.89], [41],
    [2010-2014], [398], [97.75], [21.88], [85.88], [16],
    [2015-2019], [263], [96.56], [20.62], [78.60], [6],
    [2020-2025], [140], [101.42], [35.37], [116.21], [0],
table.hline(stroke: 0.5pt),
  ),
caption: [MTLD (Measure of Textual Lexical Diversity) per five-year period, with the speeches of all prime ministers pooled. In order: period, number of speeches, median MTLD, interquartile range (IQR), distance between the lower and upper whisker of the boxplot, and number of outliers (speeches outside the whiskers). Periods with no speeches are not shown.]
) <tab:mtld_periods>
]
#v(1em)


#v(1em)
#[
#show figure: set block(breakable: true)
#figure(
table(
columns: (auto, auto, auto, auto),
align: center + horizon,
stroke: none,
inset: 5pt,
fill: (col, row) => {
if row == 0 { rgb("#B5001B") }
else if calc.rem(row, 2) == 0 { rgb("#B5001B33") }
else { white }
    },
table.hline(stroke: 0.5pt),
text(fill:white)[*V-Dem Index*], text(fill:white)[*Spearman's $rho$*], text(fill:white)[*Confidence Interval ($rho$)*], text(fill:white)[*$p$-value*],
  [Participatory democracy], [-0.442], [\[-0.651, -0.048\]], [0.500],
  [Liberal democracy],       [-0.451], [\[-0.680, 0.087\]],  [0.357],
  [Electoral democracy],     [-0.424], [\[-0.717, 0.071\]],  [0.429],
table.hline(stroke: 0.5pt),
  ),
caption: [Correlation between MTLD and the V-Dem democracy indices between 1980 and 2025. In order: V-Dem index, correlation coefficient $rho$, confidence interval of $rho$, and $p$-value. The $p$-values are obtained with a circular-shift permutation test, which preserves the autocorrelation of the two time series.]
) <tab:spearman_pvalues_mtld_vdem>
]
#v(1em)

=== Conclusions <sec:mtld_conclusions>

There are no visible patterns in the variability of the MTLD among #pms, nor in the way the diversity changes during their careers, suggesting that each #pm share no common style. 

On the other hand, the evolution of the MTLD over the years (1945 to 2025) shows a steady reduction of lexical diversity's variability along with a steady increase of the democratic indices, until the period 2020-2025 where the variability grows back up and the democratic indices worsen. I do not have the data to say whether the variability of the lexical diversity and the democratic indices are connected by correlation or causality.


















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

*TODO: compare with V-Dem polarization indices (if exists).*

=== Conclusions <sec:polarization_conclusions>

We see quite a bit of polarization, but ...

== Sentiment Analysis <sec:res_sentiment_analysis>

=== Democratic Indices Against Sentiment Scoring <sec:vdem_vs_sentiment>

#subpar.grid(
  rows: 2,
  gutter: 3pt,
  figure(
    image("../images/sentiments_vdem_combined.png", width: 100%),
    caption: [Sentiment values plotted for each year, aggregating all speeches from all political leanings. Each dot of the graph (for each year) is scaled based on the amount of speeches available for that specific year. The confidence intervals are shown. The sentiment scores chart is plotted against V-Dem indices.]
  ), <fig:sentiments_vdem_combined>,
  figure(
    image("../images/sentiments_vdem_polleanings.png", width: 100%),
    caption: [Sentiment values plotted for each year, aggregating speeches from three political leanings, respectively colored as green (center), red (left), and blue (right). Each dot of the graph (for each year) is scaled based on the amount of speeches available for that specific year. The The sentiment scores line chart is plotted against V-Dem indices.]
  ), <fig:sentiments_vdem_polleanings>,
  v(0.2em),
  caption: [Sentiment analysis results for _hate speech_, _aggressiveness_, and _negativity_ plotted against V-Dem indices. Its hart to tell wether there is any correlation between them.],
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
  
  Size of bubbles depends on the amount of speeches. @fig:sentiments_2d_pms project results for single #pms: Berlusconi stands out as the most aggressive by far. @fig:sentiments_2d_leanings project results aggregated by leanings. The right appears to be more aggressive, while the left more negative. The center seems to be more positive than both. The last two figures show the sentiment scores aggregated by years (with 5-year pool range). While @fig:sentiments_2d_years_zoomout shows an outlier for the period $1976-1980$, @fig:sentiments_2d_years_zoomin shows that overall the sentiment scores are quite close to each other, without great variability especially for periods with a lot of speeches.],
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

This does not seem to change over time, failing to explain the V-Dem indices drop in 2021.

/*
#include "../bibliography/bibliography.typ"


#include "conclusions.typ"
#include "future_works.typ"
#include "../appendix/appendix-A.typ"