#import "../config/variables.typ": *
#import "../config/thesis-config.typ": *
#pagebreak(to:"odd")


= Conclusions & Future Works <ch:future>

On the matter of lexical diversity (measured as the Measure of Textual Lexical Diversity), there are no visible patterns in its variability among #pms, nor in the way the diversity changes during their careers, suggesting that #pms share no common style. On the other hand, its evolution over the years (1945 to 2025) shows a steady reduction in its variability along with a steady increase of the democratic indices, until the period 2020-2025 where the variability grows back up and three democratic indices decline. Over the period 1985-2025, the Spearman's $rho$ confidence intervals paired with the _p_-values tell us that the correlation between the variability of the lexical diversity and the democratic indices is not certain, and that we cannot distinguish it from chance.

To identify polarization, I compared leaning-exclusive vocabularies with the vocabulary shared amongst all leanings, and I embedded all speeches of all #pms in the vector space with a simple doc2vec algorithm that averages Tf-IdF-weighted metrics and FastText word embeddings. After the year 2000, leaning-exclusive vocabularies surpass in size the shared vocabulary common to all leanings, which paired with the per-#pm and per-leaning clustering in the vector space suggests that symptoms of polarization may be present in the Italian political landscape.  

Lastly, to measure hostility I used the large language model Gemma 4 (run locally via Ollama) to classify all speeches for their degrees of hate speech, aggressiveness, and negativity, as well as whether they target political adversaries or a minority group. Italian #pms almost never use hate speech in their speeches, while their rhetoric is slightly aggressive (scored $0.15$ out of $1$) and negative (scored $0.4$ out of $1$). There is no relationship between hostility scores and democratic indices, as shown by the Spearman's $rho$ and the _p_-values. #pms do not target any minority group, but they target political adversaries in seven speeches out of ten, and the center is overall less negative and less targeting than both the right and the left. Moreover, while the right is considerably more aggressive than the left, the left tends to be slightly more negative. 

#v(1em)

To improve upon this work there are some steps that could be taken: increase the dataset by scraping new sources other than Radio Radicale, for example YouTube or the social networks of the politicians themselves, and increase the scope of the politicians by including the leaders of the opposition and other notable figures, as well as a more refined check of the timestamps; use better models for transcribing the text of the speeches; use a dedicated library and more refined algorithms for the doc2vec algorithm (at the time of writing, gensim library is not compatible with the current version of Python); use bigger LLMs for the sentiment analysis; and include other countries in the analysis, such as France or the USA.
