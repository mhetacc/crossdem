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

5 years

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

10 years

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

all

#subpar.grid(
  rows: 2,
  gutter: 5pt,
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