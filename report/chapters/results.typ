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

#figure(
  image("../images/mtld_pms_LOWESS_withmedians.png", width: 100%),
  caption: [LOWESS curve of MTLD values for each Italian #pm over their career span, without overall median. The LOWESS curve was chosen to aid in the visual interpretation of the values. #pm with fewer than 20 speeches are omitted. The overall median is plotted as a black dotted line.],
) <fig:pms_lowess_medianALL>
#v(1em)


Looking at the evolution of lexical diversity and its relationship with democratic indices, the box plot in figure @fig:vdem_box5y_combined shows the lexical diversity (MTLD) of all speeches aggregated by 5-year periods between 1945 and 2025. Distinguishing between political leanings (left, center, and right) is not informative due to the unequal distribution of speeches, as previously shown in figure @fig:dataset #footnote[Nonetheless, from the graphs with such distinction (viewable in appendix @appx:vdem_5y_pms_leanings) we can infer that from 1985 onward right-leaning speeches present both a higher median MTLD and a higher variability in the lexical diversity compared to left-leaning speeches, while center-leaning speeches are too few to allow for a fair comparison.]. 

Ignoring the period between 1960 and 1985 due to the lack of data (only twenty-four speeches were collected for this period), the plot shows a steady reduction in the variability of the MTLD until the 2020-2025 period, where it grows back up again. This is reflected in the data shown in table @tab:mtld_periods: interquartile range steadily decreases from $52.61$ in the 1945-1949 period, to $20.62$ in the 2015-2019 period, then grows back up to $35.37$ in the 2020-2025 period, and whisker-to-whisker spread goes from $184.56$ in the 1945-1949 period, to $78.6$ in the 2015-2019 period, and grows back up to $116.21$ in the 2020-2025 period. That being said, figure @fig:vdem_line_combined shows that between 2020 and 2022 the median MTLD suddenly drops, from $104.63$ in 2020, to $90.61$ in 2021 and $77.74$ in 2022 ($-25.7%$), and grows back up to $106.57$ in 2023. While this could suggest that the increase in variability is caused by the 2021-2022 period acting as an outlier, recomputing the 2020-2025 box while leaving out the period 2021-2022 gets us 120 speeches for an IQR of $36.44$ and a whisker-to-whisker length of $116.21$, so the observed increase in variability is still present.


In both graphs (figures @fig:vdem_box5y_combined and @fig:vdem_line_combined) democratic indices are also reported (sourced from V-Dem). Indices' values range from $0.0$ to $1.0$. They steadily grow from 1945 onward, but three out of six see an over ten percent reduction between 2020 and 2025: 
- _Participatory democracy_ goes from $0.68$ in 2020 to $0.569$ in 2025 ($-16.32%$, $-11.1$ points);
- _Liberal democracy_ goes from $0.774$ in 2020 to $0.642$ in 2025 ($-17.05%$, $-13.2$ points);
- _Electoral democracy_ goes from $0.857$ in 2020 to $0.745$ in 2025 ($-13.07%$, $-11.2$ points).

_Scrutiny of executives_, on the other hand, sees a reduction of $5.04%$ (from $0.953$ to $0.905$, $-4.8$ points), but this inflection does not happen until 2024, while _election quality_ and the _fairness of law and individual liberties_ remain unchanged.


The democratic indices seem inversely correlated with the spread (i.e., the variability) of the lexical diversity: when the spread decreases the indices increase, and vice versa when the spread increases the indices decrease. \
To check whether this correlation exists and, if so, whether it is due to chance, I calculated the Spearman's rank correlation coefficient $rho$ as well as the _p_-values for the null hypothesis _"democratic index A and spread are unrelated"_. Both calculations were done by computing the spread for each year (rather than by 5-year periods as in figure @fig:vdem_box5y_combined), and comparing it with the V-Dem indices for each year (per-year granularity is already present in the V-Dem dataset). I considered the three indices with at least a ten percent reduction.\
Since the years cannot be treated as independent observations, to calculate the _p_-values either shuffling or shifting is necessary. I opted for a circular shift since shuffling years randomly destroys the smoothness of both time series, so the null hypothesis would be too easy to beat. Shifting keeps each series intact and only breaks the alignment. Confidence intervals for the $rho$ were obtained by bootstrapping the data 1,000 times with a confidence level of $95%$. I used block bootstrapping to preserve the autocorrelation typical of time series by resampling chunks of ten consecutive years. Results are shown in table @tab:spearman_pvalues_mtld_vdem: spread and democratic indices show a negative $rho$ of about $-0.4$, but the wide confidence intervals, which include zero for liberal and electoral democracy, paired with _p_-values over $0.2$ tell us that not only is the inverse correlation uncertain, we cannot distinguish it from chance.


#figure(
  image("../images/mtld_vdem_box5y_combined.png", width: 100%),
  caption: [MTLD values in a boxplot by 5-year periods, with V-Dem indices. Each grey box combines all speeches for all political leanings in that 5-year period. MTLD variability appears to decrease from 1989 to 2019, with an abrupt inversion in the 2020-2025 period. Whether this correlates with the inflection of some V-Dem indices is not clear. Note that this graph and figure @fig:vdem_line_combined use different Y-axis scales.],
) <fig:vdem_box5y_combined>

#figure(
  image("../images/mtld_vdem_line_combined.png", width: 100%),
  caption: [MTLD values plotted for each year, aggregating all speeches from all political leanings. Each dot is scaled by the number of speeches available for that year. The MTLD line chart is plotted against V-Dem indices. Note the different Y-axis scale compared to figure @fig:vdem_box5y_combined.],
) <fig:vdem_line_combined>


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
  [Participatory democracy], [-0.485], [\[-0.640, -0.019\]], [0.341],
  [Liberal democracy],       [-0.489], [\[-0.672, 0.107\]],  [0.244],
  [Electoral democracy],     [-0.463], [\[-0.717, 0.075\]],  [0.317],
table.hline(stroke: 0.5pt),
  ),
caption: [Correlation between MTLD and the V-Dem democracy indices between 1985 and 2025. In order: V-Dem index, correlation coefficient $rho$, confidence interval of $rho$, and $p$-value. The $p$-values are obtained with a circular-shift permutation test, which preserves the autocorrelation of the two time series, and the confidence intervals are block-bootstrapped with $95%$ confidence level.]
) <tab:spearman_pvalues_mtld_vdem>
]


=== Conclusions <sec:mtld_conclusions>

There are no visible patterns in the variability of the MTLD among #pms, nor in the way the diversity changes during their careers, suggesting that #pms share no common style. 

On the other hand, the evolution of the MTLD over the years (1945 to 2025) shows a steady reduction of the variability of the lexical diversity along with a steady increase of the democratic indices, until the period 2020-2025 where the variability grows back up and three democratic indices decline. Over the period 1985-2025, the Spearman's $rho$ confidence intervals paired with the _p_-values tell us that the correlation between spread and democratic indices is not certain, and that we cannot distinguish it from chance.

















== Polarization <sec:res_polarization>

As a first esplorative metric for polarization I decided to compare the vocabularies of the three main political leanings, namely left (which comprises left and center-left), right (which comprises right and center-right), and center, measuring the size of the vocabularies exclusive to each leaning and comparing them to the size of the vocabulary shared among all leanings, for example:

#[
  #import "@preview/algo:0.3.6": algo, i, d, comment, code

  #algo()[
    #comment[Original vocabularies]
    let left_vocabulary = [A, B, C]\
    let right_vocabulary = [A, $beta$, $gamma$]\
    let center_vocabulary = [A, _X_, _Y_]\
    then: #i
      #comment[Shared and exclusive vocabularies]\
      let shared_vocabulary = [A]\
      let left_exclusive = [B, C]\
      let right_exclusive = [$beta$, $gamma$]\
      let center_exclusive = [_X_, _Y_]\
  ]
]

I pooled for each 5-year period the both the 1000-most-used words by each leaning, as well as the 10,000-most-used words by each leaning, and I plotted them in two separate graphs, seen in figure @fig:stack_top_k. The words are lemmatized and the stop words are removed. I choose to limit the scope to the top-1000 and top-10,000 words to reduce the noise from the long tail of the vocabulary, which contains rare or mistranscribed words. The top-10,000 words already show dirty outputs, as seen in the following examples (period 1995-1999, first twenty most used words, right-exclusive vocabulary):

#blockquote[
  *Top-1000:* senatore imposta silvio magistrato magistratura Andreotti chiesa regime avversario piazza dichiarare aprile benessere moro Maastricht sovietico stampa minoranza lettera polizia...
]

#blockquote[
  *Top-10,000:* erario ferdinare pier rocco gladio albertino umanesimo sardo cerimoniale Muslim Forza innanzi liquota christian intergenerazionale teologia fanfano furto patriotismo piazzante...
]



Periods between 1945 and 1954 can be ignored since they contain only center-leaning speeches (all authored by De Gasperi), and periods between 1955 an 1984 can be ignored as well due to data scarcity. \
I thus focused on periods between 1985 and 2025: in the top-1k graph (sub figure @fig:stack_top1k) it is interesting to notice that, during the period 1995-2015, the center-exclusive vocabularies contain more words than both left- and right-exclusive vocabularies, even though the center-leaning speeches in this period are almost non-existent. This phenomenon is not present in the top 10k graph (sub figure @fig:stack_top10k), where it is instead found in the period 1985-1994, which incidentally has more center-leaning speeches.   

Leaving distributions aside, the top 1k graph shows a growth of the exclusive vocabularies along with a decline of the shared vocabulary from 1985 all the way to 1999, with an overtake of the exclusive vocabularies in 2000. By "exclusive vocabularies growth" I mean to say that the sum of the sizes of the three exclusive vocabularies increases.\
While the period 2020-2025 sees a sudden growth of the shared vocabulary, the exclusive vocabularies' sizes remain larger. The top 1k graph tells us that political leanings adopted a vocabulary increasingly more exclusive to their side, which can then be interpreted as a sign of polarization. The top 10k graph reinforces this stance since in each and every period the exclusive vocabularies tower over the shared vocabulary. It is interesting to notice that the evolution of the shared vocabulary (i.e. the slope of the evolution curve) is very similar between the two graphs, even if theirs scales differ by one order of magnitude. 







The presence of polarization between #pms and political leanings is corroborated by the t-SNE graphs in figure @fig:tsne_doc2vec, which plot all speeches embedded with a simple doc2vec algorithm that builds document vectors as Tf-IdF-weighted averages of pre-trained word embeddings, with the formula:

$
"Document Vector" = frac(sum w_i v_i, sum w_i)
$<math:doc2vec>

where $v_i$ is the FastText embedding for word $i$, and $w_i$ the Tf-IdF score for that word. When the speeches (i.e. the points in the t-SNE plot) are highlighted by the #pm who authored them (sub figure @fig:doc2vec_pms), we can clearly see that most #pms' speeches cluster together, with little overlap. This reinforces the idea that most #pms have a personal style, agreeing with previous findings in section @sec:res_textual_complexity. 

By highlight the speeches by political leaning (sub figure @fig:doc2vec_leanings), we see once again evident clustering, suggesting that symptoms of polarization are indeed present as previously observed. It is important to notice that some leaning-specific clusters are directly correlated to a #pm, for example the green center-leaning cluster mostly overlaps with De Gasperi's cluster.

Highlighting the speeches by 5-year periods (sub figure @fig:doc2vec_years) on the other hand, shows little clustering and a lot of overlap, preventing us from drawing any conclusions. Periods 1945-1950 and 1951-1955 are the only ones clearly clustered together, which is easily explained by the fact that they contain only speeches authored by De Gasperi.

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
  caption: [All speeches are pooled in 5-year time periods. Then, for each period, the top-N most frequently used words are extracted for each political leaning (1000 words for sub figure @fig:stack_top1k, and 10,000 words for sub figure  @fig:stack_top10k). Then, for each period, the words are divided into four sets: words exclusive to left-leaning speeches, words exclusive to right-leaning speeches, words exclusive to center-leaning speeches, and words shared among all leanings.],
  label: <fig:stack_top_k>,
)
#v(1em)

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
  caption: [Doc2Vec embeddings of all speeches, projected in two dimensions with t-SNE. Each speech is represented as a point in the vector space, and the points are highlighted by #pm (sub figure @fig:doc2vec_pms), political leaning (sub figure @fig:doc2vec_leanings), and 5-year period (sub figure @fig:doc2vec_years).],
  label: <fig:tsne_doc2vec>,
)


=== Conclusions <sec:polarization_conclusions>

Leaning-exclusive vocabularies tower over a shared vocabulary common to all leaning, which paired with per-#pm and per-leaning speeches' clustering in the vector space suggests that symptoms of polarization may be present in the Italian political landscape. 










== Sentiment Analysis <sec:res_sentiment_analysis>

To check whether there can be any correlation between the hostility of political speeches and the quality of democracy I plotted the combined yearly average scores for hate speech, negativity, and aggressiveness against V-Dem indices (figure @fig:sentiment_vdem). Once again, I did not distinguish between leanings due to imbalanced sample sizes. The graph that plots hostility per leaning can be found in appendix @appx:sentiments_vdem_polleanings.\
Figure @fig:sentiment_vdem shows that hate speech is almost non-existent, while aggressiveness pretty low with an average of $tilde 0.15$ out of $1$. Negativity, on the other hand, is always present with a score of about $0.4$ (scores range from zero to one). The hostility scores are consistent over the years, with no particular trend, and there does not seem to be any correlation with the democratic indices. This is confirmed by the values in table @tab:hostility_vdem: Spearman's confidence values are too close to zero, with the confidence intervals crossing into negative, and the _p_-values are all above $0.45$ (way above the usual $0.05$ threshold). _P_-values, $rho$, and confidence intervals were calculated as in section @sec:res_sentiment_analysis for consistency.


Hostility values can be compared directly with a bubble chart, as shown in figure @fig:hostility_bubble. I plotted aggressiveness and negativity, ignoring hate speech since its scores are negligible for all #pms.\
Sub figure @fig:bubble_pms plots #pms over their hostility axes (#pms with less than 100 speeches are omitted for readability #footnote[Recomputing the graph with the legend on the side do not makes matters worse.]). It is interesting to notice how far apart Berlusconi and Monti are: Monti succeeded Berlusconi as head of government after the crisis of 2011, and his speech style is almost opposite to Berlusconi's. Monti's scores are $0.35$ for negativity and $0.01$ for aggressiveness, while Berlusconi scores $0.45$ for negativity ($+22%$, $+10$ points), and $0.39$ for aggressiveness ($+97%$, $+10$ points). Berlusconi shares similar discrepancies with Prodi (which was in office before the last and after the second last Berlusconi government), and Amato (which was in office before the second last Berlusconi government), whose aggressiveness scores are $0.05$ and $0.04$ respectively.\
That being said, all Italian #pms are quite similar in their negativity scores, which range between $0.21$ and $0.46$. For aggressiveness, Berlusconi, Meloni, and Cossiga are the only ones with a score above $0.2$, while the rest scores around $0.1$. Overall, for both values the relative scores are not so high, all being below $0.5$ out of $1$.

Grouping the scores by political leaning (sub figure @fig:bubble_leanings) shows that the right is more aggressive than the left ($0.2$ against $0.07$, for an increase of $65%$ or $+13$ points), while the left is slightly more negative than the right ($0.42$ against $0.39$, for an increase of $7%$ or $3$ points). The center is lower than both, with a negativity score of $0.32$ and an aggressiveness score of $0.11$.

Lastly, I aggregated the score by 5-year periods (sub figures @fig:bubble_years_zoomout and @fig:bubble_years_zoomin). Ignoring the outliers (like periods 1976-1980 and 1961-1965 with five and one speech respectively), most periods cluster around a negativity score of $0.4$ and an aggressiveness score of $0.1$. Two pairs of periods differ from the mean values and are worth a closer look: periods 1945-1949 and 1950-1954, while both containing exclusively De Gasperi's speeches, differ in their negativity score by $12$ points ($33.3%$), which could be attributed to the hopeful outlook of the post-war period. Both periods deviate from the mean negative score by $4$ and $16$ points respectively, while being slightly higher in the aggressiveness score. The second pair is comprised by periods 2016-2019 and 2020-2025: while it would be tempting to attribute the reduction in hostility from the first period to the second to Giorgia Meloni's rose to power (some research claims that populist and far right politicians relax their positions once in office @campo_stylistic_2026), the dataset contains mostly left-leaning speeches for the period 2016-2019, thus not authored by Giorgia Meloni. Nonetheless, it is interesting to notice that period 2020-2025





*TODO: BUBBLE REPLACE GRAP
HS*


#figure(
  image("../images/sentiments_vdem_combined.png", width: 100%),
  caption: [Sentiment values plotted for each year, aggregating all speeches from all political leanings. Each dot size of the graph (for each year) is scaled based on the amount of speeches available for that specific year.The sentiment scores chart is plotted against V-Dem indices.],
) <fig:sentiment_vdem>

#v(1em)
#[
#show figure: set block(breakable: true)
#figure(
table(
columns: (auto, auto, auto, auto, auto),
align: center + horizon,
stroke: none,
inset: 5pt,
fill: (col, row) => {
if row == 0 { rgb("#B5001B") }
else if col == 0 { white }
else if calc.rem(row, 2) == 0 { rgb("#B5001B33") }
else { white }
    },
table.hline(stroke: 0.5pt),
text(fill:white)[*Dimension*], text(fill:white)[*V-Dem Index*], text(fill:white)[*Spearman's $rho$*], text(fill:white)[*Confidence Interval*], text(fill:white)[*$p$-Value*],
    table.cell(rowspan: 3)[Negativity], [Electoral democracy], [0.120], [\[-0.356, 0.507\]], [0.844],
    [Participatory democracy], [0.041], [\[-0.386, 0.448\]], [0.911],
    [Liberal democracy], [0.157], [\[-0.365, 0.548\]], [0.822],
    table.hline(stroke: 0.25pt),
    table.cell(rowspan: 3)[Aggressiveness], [Electoral democracy], [0.294], [\[0.140, 0.640\]], [0.556],
    [Participatory democracy], [0.257], [\[0.036, 0.597\]], [0.622],
    [Liberal democracy], [0.330], [\[0.134, 0.658\]], [0.467],
table.hline(stroke: 0.5pt),
  ),
caption: [Correlation between the negativity and aggressiveness dimensions and the V-Dem democracy indices. In order: dimension, V-Dem index, correlation coefficient $rho$, confidence interval of $rho$, and $p$-value. The $p$-values are obtained with a circular-shift permutation test, which preserves the autocorrelation of the two time series.]
) <tab:hostility_vdem>
]
#v(1em)


#subpar.grid(
  columns: 2,
  rows: 2,
  gutter: 5pt,
  figure(
    image("../images/sentiments_2d_pms.png", width: 100%),
    caption: [Sentiment: #pms ($|"speeches"|gt.eq 100$).]
  ), <fig:bubble_pms>,
  figure(
    image("../images/sentiments_2d_leanings.png", width: 100%),
    caption: [Sentiment: leanings.]
  ), <fig:bubble_leanings>,
  figure(
    image("../images/sentiments_2d_years_zoomout.png", width: 100%),
    caption: [Sentiment: years zoomed out.]
  ), <fig:bubble_years_zoomout>,
  figure(
    image("../images/sentiments_2d_years_zoomin.png", width: 100%),
    caption: [Sentiment: years zoomed in.]
  ), <fig:bubble_years_zoomin>,
  v(0.2em),
  caption: [Sentiment analysis results for _negativity_ and _aggressiveness_. Values go from zero to one, and the classification task considers three possibile values for each speech: _low_ ($0$), _mid_ ($0.5$), and _high_ ($1$). 

  Size of bubbles depends on the amount of speeches. @fig:bubble_pms project results for single #pms: Berlusconi stands out as the most aggressive by far. @fig:bubble_leanings project results aggregated by leanings. The right appears to be more aggressive, while the left more negative. The center seems to be more positive than both. The last two figures show the sentiment scores aggregated by years (with 5-year pool range). While @fig:bubble_years_zoomout shows an outlier for the period $1976-1980$, @fig:bubble_years_zoomin shows that overall the sentiment scores are quite close to each other, without great variability especially for periods with a lot of speeches.],
  label: <fig:hostility_bubble>,
)
#v(1em)


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
#v(1em)

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