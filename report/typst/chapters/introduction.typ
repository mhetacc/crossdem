#import "../config/variables.typ": *
#import "../config/thesis-config.typ": *
#counter(page).update(1)

= Introduction <ch:introduction>

//- Importance of political speeches
//- Public vs institutional speeches

Politicians are some of the most influential people in human society: from the Greeks' demagogues to our Presidents and Prime Ministers, leaders have always tried to steer society. Shapiro and Page (1984) @page_presidents_1984 showed how nearly all $20^"th"$ century U.S. Presidents have tried to lead public opinion, with varying degrees of success. As societies became more democratic, so grew the leaders' responsibility to convince potential followers that their policies are beneficial. Thus, speeches play a vital role in the functioning of society @beard_language_2000: leaders depend on the verbal power to persuade people @charteris-black_persuasion_2011.

Birkenmaier and Lechner (2025) @birkenmaier_measuring_2026 measure politicians' public personality traits using computational text analysis, and their corpus comprises data from interviews, social media posts, and parliamentary speeches. Specifically, "interviews statements provide one of the most natural and authentic sources of politicians’ interactions and self-presentation to the public", making them one of the best data sources for political speeches @schoonvelde_friends_2019 @bull_psychology_2023.

Moreover, democratic stability depends on citizens on the losing side accepting election outcomes. Clayton et al. @clayton_elite_2021 evaluated the effects of exposure to multiple statements from (at the time) former president Donald Trump attacking the legitimacy of the 2020 US presidential election. They found no evidence indicating that elites can erode democratic norms easily or that the effects of norm violations are uniform across the entire population. However, elite rhetoric can shape normative beliefs in core democratic values such as confidence in elections and support for peaceful transfers of power. This was especially evident amongst people who approved of Trump's performance in office.

Having established the importance of speeches, we can differentiate between two types: _internal speeches_, aimed at other institutional bodies, such as parliamentary speeches, and _external speeches_, aimed at the population, such as public speeches, interviews and social network posts. This last category is especially interesting since it affords politicians a direct and high-volume communication channel to their potential followers: U.S. President Donald Trump tweeted $57,000$ times between May 2009 and January 2021 alone @madhani_farewell_2021, while Italy's Prime Minister Giorgia Meloni totalled more than eighty million social network interactions in 2025 @vinci_meloni_2025.

On the other hand, internal speeches are especially easy to access, being already aggregated in public databases, yet their technical and codified nature makes their interpretation harder for both human and automated agents. Moreover, until 1985 Italian stenographic documentation did not report speeches word for word, but rather translated them into a "language of the parliament" @holtus_dal_1985 @mohrhoff_dalla_1987. 

#v(1em)
//- External speeches
//  - easier scraping
//    - social networks
//    - internet
//  - LLMs trained on common speech

Broadly speaking, the goal of this thesis is to gather a corpus of politicians' speeches and perform linguistic analyses on it. The idea is to go from standard NLP tasks such as word frequency and text complexity, to classification tasks such as hate speech and target recognition.

This objective is why I ultimately decided to gather a corpus of *external speeches* rather than internal ones. Large language models are trained with tokenizers, and the resulting token distribution is highly imbalanced: Chung et al. @chung_exploiting_2025 did a controlled study that scaled the vocabulary of the language model from 24K to 196K while holding data, computation, and optimization unchanged. They discovered that models are disproportionately optimized on the part of language that appears most often, meaning they are way better at understanding common words and patterns. This translates to the fact that internal speeches are less understandable to AI agents. 

As previously stated, external speeches include social network communications. While television is still the first source of information for the majority of the population, online platforms are steadily growing and are already the preferred media for young people @eurobarometer_media_2023 @maher_twice_2024. There is evidence of an increase in political participation due to social media usage, as well as risks for the functioning of democracy @lorenz-spreen_systematic_2023 @amsalem_people_2023, and there have been attempts to predict election results with social media data analyses. Rita et al. measure sentiment polarity on Twitter, and conclude that tweets' sentiment is not a reliable election results predictor. Additionally, results also show that it is impossible to state that social media impacts voting decisions @rita_social_2023. 

Opposite results can be seen in Belcastro et al.'s @belcastro_analyzing_2022 2022 study: a real-time analysis was carried out during the 2020 US presidential election campaign, correctly identifying the leading candidate before Election Day in 10 out of 11 swing states.

Silva et al. @silva_politicians_2022 managed to match tweets against parliamentary speeches to measure politicians' sentiment on a specific topic. They find that parliament members who participate less in parliamentary debate tend to have larger differences with their party on Twitter, suggesting that a certain level of self-censoring is taking place in the parliamentary arena.

#v(1em)

While internal speeches are usually available in easy to access, _processing-ready_ format #footnote[For example, the Italian Senate's website contains a database with every (recent) seating in HTML format. An example of seating n.1, March 23 2018, can be seen at the following link: #link("https://www.senato.it/show-doc?tipodoc=Sindisp&leg=18&id=1066811")], external ones often need to be scraped. In this regard, social networks simplify the process thanks their exposed APIs and to the availability of community tools, such as Python's library `ytp-dl` #footnote[Privacy-focused media downloader API for Linux VPS deployments: #link("https://pypi.org/project/ytp-dl/")]. This open the possibility to automate their collection for research purposes, as I did for this project (section @sec:scraping).

#v(1em)


//- Textual complexity, polarization, and sentiment analysis
//   - Why are they important

Up until now we talked about why and where to collect external speeches, but not what to do with them. Let's thus get into more details on *which analyses will be performed* on the corpus and why. 

// textual complexity

There’s a widespread view that populism is on the rise, from the United States and Turkey to India and Hungary @lange_republicans_2024 @massicard_populism_2021 @tillin_political_2024 @gyori_populism_2012, a development that has generated considerable concern because, in its most radical and authoritarian form, populism threatens democracy @kaltwasser_ambivalence_2012, polarizes societies @scheiring_watched_2024, and erodes trust in experts @nisbet_tragedy_2016. 

Moreover, the progressive simplification of political discourse @kittel_simply_2025 has attracted increasing attention, as it allegedly favors populist politicians, particularly those on the far right. Many studies tried to explore these claims, with mixed results: Decadri and Boussalis (2019) @decadri_populism_2020 used text analytic techniques to inspect parliamentary speeches given by the members of nine Italian parties. Their results suggests that populist ideology, electoral strategy, and party membership influence legislators’ language complexity, and that language simplicity might be thought of as a feature of populist communication. \
On the other hand, McDonnell and Ondelli in their 2020 study @mcdonnell_language_2022 investigate the linguistic simplicity of four right-wing populists compared to their principal opponents in the United States, France, United Kingdom, and Italy. Contrary to expectations, they find that Donald Trump was only slightly simpler than Hillary Clinton, while Nigel Farage in the UK and Marine Le Pen in France were more complex than their main rivals, and Italy’s Matteo Salvini was simpler on some measures but not others, concluding that the relationship between populism and simplicity should not be taken for granted. \
Similar results were found by Rebecca C. Kittel in 2025 @kittel_simply_2025 after analyzing German parliamentary debates from January 1991 to September 2021. Their findings show that right-wing populist actors use the most complex language, while left-wing populists' language complexity is average. At the same time, the study finds that overall complexity decreased significantly in the German parliament over time, confirming at least partially the claims about "progressive simplification". \
Overall, the matter of lexical complexity is still highly sought after by journalists and researchers alike.

// populists tend to speak very emotionally 

Other studies shifted the focus from textual complexity to the emotionality of speech. Wang et al. (2026) @wang_sound_2026 explore the sound of populism by integrating classic Linguistic Inquiry and Word Count with a fine-tuned RoBERTa model. Their findings reveal that populist rhetoric consistently features a direct, assertive “sound” that forges a connection with “the people” and constructs a charismatic leadership persona. Notably, right-wing populism and people-centrism exhibit a more emotionally charged discourse, resonating with themes of identity, grievance, and crisis, in contrast to the relatively restrained emotional tones of left-wing and anti-elitist expressions. \
Biluc et al. work (2026) @bliuc_emotional_2026 highlights how anger consistently emerges as the most powerful emotional correlate of populist attitudes, followed by fear, resentment, and nostalgia, which agrees with Laura Alonso-Muñoz and Casero-Ripollés 2023 study @alonso-munoz_appeal_2023: they build a corpus of tweets from four European political parties (Podemos, 5 Star Movement, National Front, and UKIP), and their findings show that fear, uncertainty or resentment are the emotions most frequently used by populist parties and leaders. \
Caiani and Di Cocco (2023) @caiani_populism_2023 on the other hand, try to draw the connection between emotion and populism using machine learning: focusing on Italy as a case study, they systematically investigates the intensity and trends of specific emotions in political discourses of all Italian political parties over the last 20 years. Their findings confirm that populists populists tend to leverage more emotional appeals than non-populist parties, however there is an increase in the use of these appeals overall, especially in terms of negative emotions. Most notably, different types of emotions are mobilized by different types of populisms: right-wing populists mainly use negative emotions, while left-wing's employ positive emotional appeals.

// polarization

Turning now to the effects populism has on society, polarization may be the one most consistently observed @roberts_populism_2022 @velden_populism_2025. A lot of research has been done on the risks posed by a polarized society, such as Benson's (2023) @benson_democracy_2024 which argues that polarization’s epistemic harms are best located in its tendency to reduce the diversity of perspectives utilized in a democratic system and in how this weakens the system’s ability to identify and address problems of public concern. \
Rostbøll (2024) @rostboll_polarization_2025 argues that 'it is widely agreed that the increased polarization many countries experience is bad for democracy', and recommends a systemic approach to assessing the democratic implication of polarization, which analyzes both the effects of polarization at different sites and on democracy as a composite whole. \ 
Schelder (2023) @schedler_rethinking_2023 frames political polarization as form of public conflict that aims to destroy the basic democratic trust. Citizen living in such a society fear for the subversion of democracy instead of their economic well-being, physical safety, or ways of life. They then argue that the institutional implications of such fears are dramatic, spelling the end of democratic consolidation.
Other literature argues that affective polarization contributes to democratic erosion by increasing partisan loyalty and decreasing the importance citizens give to democratic procedures. More specifically, the strength of partisanship has also been found to be associated with ‘partisan double standard’ @graham_democracy_2020 or ‘democratic hypocrisy’ @simonovits_democratic_2022, that is, the willingness to overlook democratic violations by one's own party.

#v(1em)

// summary and thesis structure

To surmise, the three verticals connected with populism are: textual complexity, polarization, and emotivity. In this Master Thesis, the focus will be on the textual analysis itself from a computationally-oriented approach, rather then its connection with populism for a more comparative-politics-oriented approach. \

Section @sec:building_corpus outlines how the corpus, made out of Italian Prime Ministers' public speeches, was built, and section @sec:corpus_annotation describe in detail how the corpus was annotated to address the topic of "emotivity": every speech is classified by its degree of aggressiveness, hate speech or negativity, as well as wether it targets a specific group or not.


:
1. Textual complexity;
2. Polarization;
3. Emotivity.

*---------------------------* 

and erodes the basic principle that democracy requires its citizens to be informed to work as intended. It is thus important to measure the degree of this _"vulgarization"_ across years and political spectrums. 

== Project's Goal



== Research Questions <sec:research_questions>


Research Questions:
+ *Textual Complexity:*
   + Does it have a correlation with democracy levels?
   + Does it change over time?
   + Does it change among different political leanings?
+ *Polarization:*
   + Does symptoms of polarization change over the years?
   + Do they have a correlation with democracy levels?
   + Are Prime Ministers' rhetorics more similar or more dissimilar?
   + Can we visualize and calculate polarization among different political leanings?
+ *Sentiment:*
   + Does it have a correlation with democracy levels?
   + What PM is more toxic?
   + What political leaning is more toxic?
   + What period is more toxic? Is it getting better or worse?
   + Target: 
      + Which political side, if any, is more often targeting?
      + Which PMs, if any, is more often targeting? 

== Roadmap <sec:roadmap>

Needed? 

+ First step: build the corpus
+ Second step: etc
