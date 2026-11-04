#import "../config/variables.typ": *
#import "../config/thesis-config.typ": *
#pagebreak(to:"odd")


= Conclusions & Future Works <ch:future>

Lex:
There are no visible patterns in the variability of the MTLD among #pms, nor in the way the diversity changes during their careers, suggesting that #pms share no common style. 

On the other hand, the evolution of the MTLD over the years (1945 to 2025) shows a steady reduction of the variability of the lexical diversity along with a steady increase of the democratic indices, until the period 2020-2025 where the variability grows back up and three democratic indices decline. Over the period 1985-2025, the Spearman's $rho$ confidence intervals paired with the _p_-values tell us that the correlation between spread and democratic indices is not certain, and that we cannot distinguish it from chance.


Pol:
After the year 2000, leaning-exclusive vocabularies surpass in size the shared vocabulary common to all leaning, which paired with per-#pm and per-leaning speeches' clustering in the vector space suggests that symptoms of polarization may be present in the Italian political landscape.  


Sent:
Italian #pms almost never use hate speech in their speeches, while their rhetoric is slightly aggressive (scored $0.2$ out of $1$) and negative (scored $0.4$ out of $1$). There is no relationship between hostility scores and democratic values, as shown by the Spearman's $rho$ abd the _p_-values. #pms do not target any minority group, but they target political adversaries in seven speeches out of ten, and the center is overall less negative and less targeting than both the right and the left. Lastly, while the right is considerably more aggressive than the left, the left tends to be slightly more negative. 



- Analyses results
  - so can we explain VDEM drops and stuff?
- How to improve the work
  - more scraping (increase dataset)
  - better transcription (even tho they are pretty good)
  - bigger LLMs for the sentiment analysis 
  - better doc2vec? gensim still not compatible with current Python version
- How to expand the work
  - include leader of opposition
  - include trend setter of the time
  - include other countries (eg France or USA)

  