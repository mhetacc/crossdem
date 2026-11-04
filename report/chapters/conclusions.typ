#import "../config/variables.typ": *
#import "../config/thesis-config.typ": *
#pagebreak(to:"odd")


= Conclusions and Future Works <ch:future>

On the matter of lexical diversity (measured by the Measure of Textual Lexical Diversity), there are no visible patterns in its variability among #pms, nor in the way the diversity changes during their careers, suggesting that #pms share no common style. On the other hand, its evolution over the years (1945 to 2025) shows a steady reduction in its variability along with a steady increase of the democratic indices, until the period 2020-2025 where the variability grows back up and three democratic indices decline. Over the period 1985-2025, the Spearman's $rho$ confidence intervals paired with the $p$-value tell us that the correlation between the variability of the lexical diversity and the democratic indices is not certain, and that we cannot distinguish it from chance.

To identify polarization, I compared leaning-exclusive vocabularies with the vocabulary shared among all leanings, and I embedded all speeches of all #pms in the vector space with a simple Doc2Vec algorithm that averages FastText word embeddings weighted by TF-IDF. After the year 2000, leaning-exclusive vocabularies surpass the shared vocabulary in size, which paired with the per-#pm and per-leaning clustering in the vector space suggests that symptoms of polarization may be present in the Italian political landscape.  

Lastly, to measure hostility I used the large language model Gemma 4 (run locally via Ollama) to classify all speeches for their degrees of hate speech, aggressiveness, and negativity, as well as whether they target political adversaries or a minority group. Italian #pms almost never use hate speech, while their rhetoric is slightly aggressive (scored $0.15$ out of $1$) and negative (scored $0.4$ out of $1$). There is no relationship between hostility scores and democratic indices, as shown by the Spearman's $rho$ and the $p$-value. #pms do not target any minority group, but they target political adversaries in seven speeches out of ten, and the center is overall less negative and less targeting than both the right and the left. Moreover, while the right is considerably more aggressive than the left, the left tends to be slightly more negative. 

#v(1em)

To improve upon this work there are some steps that could be taken: increase the dataset by scraping new sources other than Radio Radicale, for example YouTube or the social networks of the politicians themselves, and increase the scope of the politicians by including the leaders of the opposition and other notable figures, as well as a more refined check of the timestamps; use better models for transcribing the text of the speeches; use a dedicated library and more refined algorithms for the Doc2Vec algorithm (at the time of writing, _gensim_ library is not compatible with the current version of Python); use bigger LLMs for the sentiment analysis step to assign hostility scores; and include other countries in the analysis, such as France or the USA.
