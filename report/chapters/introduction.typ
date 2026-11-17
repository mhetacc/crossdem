#import "../config/variables.typ": *
#import "../config/thesis-config.typ": *
#counter(page).update(1)

= Introduction <ch:introduction>

//- Importance of political speeches
//- Public vs institutional speeches
// 

Since antiquity, politicians have tried to shape society to better suit their ideals and goals. Shapiro and Page @page_presidents_1984 showed how nearly all of the $20^"th"$ century U.S. Presidents sought to steer public opinion, with varying degrees of success. As political power came to depend increasingly on popular consent, so grew the leaders' responsibility to convince potential followers that their policies are beneficial. Thus, *speeches* play a vital role in the functioning of society @beard_language_2000: leaders depend on the verbal power to persuade people @charteris-black_persuasion_2011.

Moreover, democratic stability depends on citizens on the losing side accepting election outcomes. Clayton et al. @clayton_elite_2021 evaluated the effects of exposure to multiple statements from (at the time) former president Donald Trump #footnote[Former president when Clayton et al. wrote their paper, current president at the time of writing this Master Thesis.] attacking the legitimacy of the 2020 US presidential election. While they found no evidence indicating that elites can erode democratic norms easily, elite rhetoric can shape people's views about core democratic values such as confidence in elections and support for peaceful transfers of power. This was especially evident among people who approved of Trump's performance in office.

#v(1em)
// internal and external speeches

Speeches can be differentiated between two types: _internal speeches_, aimed at other institutional bodies, such as parliamentary speeches, and _external speeches_, aimed at the population, such as public speeches, interviews and social network posts. Social networks are especially interesting because they afford politicians a high-volume communication channel to their potential followers, bypassing intermediaries and enabling direct feedback from their voter base: U.S. President Donald Trump tweeted $57,000$ times between May 2009 and January 2021 @madhani_farewell_2021, while Italy's Prime Minister Giorgia Meloni totalled more than eighty million social network interactions in 2025 @vinci_meloni_2025. 

// Social Networks

While traditional media still represent the primary information source for a large share of the population, online platforms are steadily growing and are already the preferred medium for young people @eurobarometer_media_2023 @maher_twice_2024. There have been attempts to predict election results by analyzing data from social media, with mixed results: in Belcastro et al.'s 2022 study @belcastro_analyzing_2022, a real-time analysis was carried out during the 2020 US presidential election campaign, correctly identifying the leading candidate before Election Day in ten out of eleven swing states.

Opposite results can be seen in Rita et al.'s work @rita_social_2023, which measures sentiment polarity on Twitter, and concludes that tweets sentiment is not a reliable election results predictor, and that it is impossible to state that social media influences voting decisions. 

Silva et al. @silva_politicians_2022, on the other hand, managed to match tweets against parliamentary speeches to measure politicians' sentiment on a specific topic. They find that parliament members who participate less in parliamentary debate tend to have larger differences with their party on Twitter, suggesting that a certain level of self-censoring is taking place in the parliamentary arena.

#v(1em)
// SN -> thus easier scraping

Turning back to the matter of speeches, external speeches often need to be scraped. Social networks can simplify this process through their exposed APIs and the availability of community-developed tools such as Python's library `ytp-dl` #footnote[Privacy-focused media downloader API for Linux VPS deployments: #link("https://pypi.org/project/ytp-dl/")]. These resources open the possibility to automate speech collection (section @sec:scraping).

// internal speeches bad

On the other hand, internal speeches are usually already available in easy to access, _processing-ready_ format #footnote[For example, the Italian Senate's website contains a database with every (recent) seating in HTML format. An example of seating n.1, March 23 2018, can be seen at the following link: #link("https://www.senato.it/show-doc?tipodoc=Sindisp&leg=18&id=1066811")], yet their technical and codified nature makes their interpretation harder for both humans and automated agents. Moreover, until 1985 the Italian stenographic documentation did not report speeches word for word, but rather translated them into a "language of the parliament" @holtus_dal_1985 @mohrhoff_dalla_1987. 


#v(1em)
// goal -> thus external speeches
This project aims to compile a corpus of political speeches and subject it to linguistic analyses, progressing from classical NLP metrics such as word frequency and textual complexity to LLM-assisted classification tasks (hate-speech detection and target identification among them). 
This is why I ultimately chose to gather a corpus of *external speeches* rather than internal ones. Large language models are trained with tokenizers, and the resulting token distribution is highly imbalanced: Chung and Kim's controlled study @chung_exploiting_2025 scaled the vocabulary of a set of language models from $24,000$ to $196,000$ tokens while holding data, computation, and optimization unchanged. They discovered that the models are disproportionately optimized on the part of language that occurs most frequently, meaning they are far better at understanding words and patterns that appear more often. This suggests that internal speeches are less understandable to AI agents. 

Moreover, Birkenmaier and Lechner @birkenmaier_measuring_2026 made a similar dataset choice: they measured politicians' public personality traits using computational text analysis, and their corpus comprises data from interviews, social media posts, and parliamentary speeches. Specifically: "interview statements provide one of the most natural and authentic sources of politicians’ interactions and self-presentation to the public", making them one of the best data sources for political speeches @schoonvelde_friends_2019 @bull_psychology_2023.

#v(1em)


//- Textual complexity, polarization, and sentiment analysis
//   - Why are they important
// textual complexity
Having discussed the dataset, the following paragraphs focus on the three linguistic features analyzed in this work: textual complexity, emotiveness, and polarization. There is a widespread view that populism is on the rise, from the United States and Turkey to India and Hungary @lange_republicans_2024 @massicard_populism_2021 @tillin_political_2024 @gyori_populism_2012, a development that has generated considerable concern because, in its most radical and authoritarian form, populism threatens democracy @kaltwasser_ambivalence_2012, polarizes societies @scheiring_watched_2024, and erodes trust in experts @nisbet_tragedy_2016. 

Moreover, the progressive simplification of political discourse @kittel_simply_2025 has attracted increasing attention, as it allegedly favours populist politicians, particularly those on the far right. Many studies tried to explore these claims, with mixed results: Decadri and Boussalis @decadri_populism_2020 used text analytic techniques to inspect parliamentary speeches given by the members of nine Italian parties. Their results suggest that populist ideology, electoral strategy, and party membership influence legislators’ language complexity, and that language simplicity might be thought of as a feature of populist communication. \
On the other hand, McDonnell and Ondelli in their 2020 study @mcdonnell_language_2022 investigate the linguistic simplicity of four right-wing populists compared to their principal opponents in the United States, France, United Kingdom, and Italy. Contrary to expectations, they find that Donald Trump was only slightly simpler than Hillary Clinton, while Nigel Farage in the UK and Marine Le Pen in France were more complex than their main rivals, and Italy’s Matteo Salvini was simpler on some measures but not others, concluding that the relationship between populism and simplicity should not be taken for granted. \
Similar results were found by Rebecca C. Kittel in 2025 @kittel_simply_2025, after analyzing German parliamentary debates from January 1991 to September 2021. Their findings show that right-wing populist actors use the most complex language, while left-wing populists' language complexity is average. At the same time, the study finds that overall complexity decreased significantly in the German parliament over time, confirming at least partially the claims about "progressive simplification". \
//Overall, the matter of lexical complexity is still highly sought after by journalists and researchers alike.

// populists tend to speak very emotionally 

Other studies shifted the focus from textual complexity to the emotiveness #footnote[_Emotive_, adjective: 1. of or relating to the emotions; 2. appealing to or expressing emotion; 3. causing strong emotions often in support of or against something @emotive_definition_2026.] of speech. Wang et al. @wang_sound_2026 explore the sound of populism by integrating classic Linguistic Inquiry and Word Count with a fine-tuned RoBERTa model. Their findings reveal that populist rhetoric consistently features a direct, assertive “sound” that forges a connection with “the people” and constructs a charismatic leadership persona. Notably, right-wing populism and people-centrism exhibit a more emotionally charged discourse, resonating with themes of identity, grievance, and crisis, in contrast to the relatively restrained emotional tones of left-wing and anti-elitist expressions. \
Bliuc et al.'s work @bliuc_emotional_2026 highlights how anger consistently emerges as the most powerful emotional correlate of populist attitudes, followed by fear, resentment, and nostalgia, which agrees with Laura Alonso-Muñoz and Casero-Ripollés's 2023 study @alonso-munoz_appeal_2023. Their findings show that fear, uncertainty and resentment are the emotions most frequently used by European populist parties and leaders #footnote[Alonso-Muñoz and Casero-Ripollés for their 2023 study built a corpus of tweets from four European political parties: Podemos, 5 Star Movement, National Front, and the UKIP @alonso-munoz_appeal_2023.]. \
Caiani and Di Cocco @caiani_populism_2023, on the other hand, try to draw the connection between emotion and populism using machine learning: focusing on Italy as a case study, they systematically investigate the intensity and trends of specific emotions in political discourses of all Italian political parties over the last 20 years. Their findings confirm that populist politicians tend to leverage more emotional appeals than non-populist parties. However, there is an increase in the use of these appeals overall, especially in terms of negative emotions. Most notably, different types of emotions are mobilized by different types of populisms: right-wing populists mainly use negative emotions, while left-wing populists employ positive emotional appeals.

// polarization

Turning now to the effects populism has on society, polarization may be the one most consistently observed @roberts_populism_2022 @velden_populism_2025. A lot of research has been done on the risks posed by a polarized society, such as Benson's @benson_democracy_2024, which argues that polarization’s epistemic harms are best located in its tendency to reduce the diversity of perspectives utilized in a democratic system and in how this weakens the system’s ability to identify and address problems of public concern. \
Rostbøll @rostboll_polarization_2025 argues that "it is widely agreed that the increased polarization many countries experience is bad for democracy", and recommends a systemic approach to assess the democratic implication of polarization, which analyzes both the effects of polarization at different sites and on democracy as a composite whole. \ 
Schedler @schedler_rethinking_2023 frames political polarization as a form of public conflict that aims to destroy the basic democratic trust. Citizens living in a polarized society fear for the subversion of democracy instead of their economic well-being, physical safety, or ways of life. They then argue that the institutional implications of such fears are dramatic, spelling the end of democratic consolidation. \
Other literature argues that affective polarization contributes to democratic erosion by increasing partisan loyalty and decreasing the importance citizens give to democratic procedures. More specifically, the strength of partisanship has also been found to be associated with "partisan double standard" @graham_democracy_2020 or "democratic hypocrisy" @simonovits_democratic_2022, that is, the willingness to overlook democratic violations by one's own party.

#v(1em)

// summary and thesis structure

This Master Thesis will explore the three verticals just discussed (textual complexity, polarization, and emotiveness) from a computational point of view. \
The dataset consists of over five thousand annotated speeches delivered by Italian Prime Ministers between 1945 and 2025.
Section @sec:building_corpus outlines how the corpus was built, and section @sec:corpus_annotation describes in detail how it was annotated to address the topic of "emotiveness": every speech is classified by its degree of aggressiveness, hate speech or negativity, as well as whether it targets a specific group or not. Possible target groups are: political adversaries, gender minorities, ethnic minorities, and religious minorities. \
Section @sec:res_textual_complexity showcases all the analyses performed on the matter of textual complexity, section @sec:res_polarization does so on the matter of polarization, while section @sec:res_sentiment_analysis explores the matter of emotiveness. \
Lastly, in section @ch:future the results are discussed as well as possible future work.


== Research Questions <sec:research_questions>

Before delving into the research questions, it is important to specify the term _hostility_. \
In the pursuit of measuring emotiveness, I measured three qualities of speech (hate speech, aggressiveness, and negativity), and I classified whether a speech is targeting a group or not (political adversaries, gender minorities, ethnic minorities, and religious minorities). \
I define the term _hostility_ as the compound metric that incorporates all three aforementioned qualities #footnote[To clarify: if a speech has high negativity and high aggressiveness, it is a speech with medium to high hostility.].

+ RQ 1: How does the textual complexity evolve and does it bear any correlation with the quality of democracy?;
+ RQ 2: Can we identify and measure polarization?;
+ RQ 3: How hostile are the speeches delivered by Italian #pms and does hostility evolve over time?;

Each research question comes with its own share of sub-questions. \
*Textual complexity:* does it have a correlation with the quality of democracy? Does it evolve over time? How? Does it change among different political leanings? Does lexical complexity evolution exhibit some common patterns among different Prime Ministers?. \
*Polarization:* can we identify symptoms of polarization? Do the symptoms evolve over the years? Do the evolution patterns change depending on the political leaning? Do the symptoms have a correlation with the quality of democracy?. \
*Hostility:* can we identify hate speech? Can we identify negativity? Can we identify aggressiveness? Do emotionally charged speeches evolve over the years? What emotions are used the most? By which leaning? In which periods? Does hostility have a correlation with the quality of democracy? What Prime Minister is more hostile? What political leaning is more hostile? What period is more hostile? Is hostility evolving? How? Which group is more often targeted? Which political leaning, if any, targets groups more often? Which Prime Minister, if any, targets groups more often? Which time periods, if any, have more speeches that target a group?. \


/*

_*Posso eliminare da qua in poi volendo.*_\
The following list summarizes the research questions and their sub-questions:

#pagebreak()

+ *Textual Complexity:*
   - Does it have a correlation with the quality of democracy?
   - Does it evolve over time? How?
   - Does it change among different political leanings?
   - Does lexical complexity evolution exhibit some common patterns among different Prime Ministers? 
+ *Polarization:*
   - Can we identify symptoms of polarization?
      - Per Prime Minister;
      - Per political leaning;
      - Per year period;
   - Do the symptoms evolve over the years? Do the evolution patterns change depending on the political leaning?
   - Do the symptoms have a correlation with the quality of democracy?
+ *Emotiveness:*
   - Can we identify hate speech?
   - Can we identify negativity?
   - Can we identify aggressiveness?
   - Do emotionally charged speeches evolve over the years?
   - What emotions are used the most? By which leaning? In which periods?
   - Does hostility have a correlation with the quality of democracy?
   - What Prime Minister is more hostile?
   - What political leaning is more hostile?
   - What period is more hostile? Is hostility evolving? How?
   - Target: 
      - Which group is more often targeted?
      - Which political leaning, if any, targets groups more often?
      - Which Prime Minister, if any, targets groups more often? 
      - Which time periods, if any, have more speeches that target a group?

