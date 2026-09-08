#import "../config/variables.typ": *
#import "../config/thesis-config.typ": *
#counter(page).update(1)

= Introduction <ch:introduction>

- Importance of political speeches
- Public vs institutional speeches

Politicians are some of the most influential people in human society: from the Greeks' demagogues to our Presidents and Prime Ministers, leaders have always tried to steer society. Shapiro and Page (1984) @page_presidents_1984 showed how nearly all $20^"th"$ century U.S. Presidents have tried to lead public opinion, with varying degrees of success. As societies became more democratic, so grew the leaders' responsibility to convince potential followers that their policies are beneficial. Thus, speeches play a vital role in the functioning of society @beard_language_2000: leaders depend on the verbal power to persuade people @charteris-black_persuasion_2011.

Moreover, democratic stability depends on citizens on the losing side accepting election outcomes. Clayton et al. @clayton_elite_2021 evaluated the effects of exposure to multiple statements from (at the time) former president Donald Trump attacking the legitimacy of the 2020 US presidential election. They found no evidence indicating that elites can erode democratic norms easily or that the effects of norm violations are uniform across the entire population. However, elite rhetoric can shape normative beliefs in core democratic values such as confidence in elections and support for peaceful transfers of power. This was especially evident amongst people who approved of Trump's performance in office.

Having established the importance of speeches, we can differentiate between two types: _internal speeches_, aimed at other institutional bodies, such as parliamentary speeches, and _external speeches_, aimed at the population, such as public speeches, interviews and social network posts. This last category is especially interesting since it affords politicians a direct and high-volume communication channel to their potential followers: U.S. President Donald Trump tweeted $57,000$ times between May 2009 and January 2021 alone @madhani_farewell_2021, while Italy's Prime Minister Giorgia Meloni totalled more than eighty million social network interactions in 2025 @vinci_meloni_2025.

On the other hand, internal speeches are especially easy to access, being already aggregated in public databases, yet their technical and codified nature makes their interpretation harder for both human and automated agents. Moreover, until 1985 Italian stenographic documentation did not report speeches word for word, but rather translated them into a "language of the parliament" @holtus_dal_1985 @mohrhoff_dalla_1987. 


- External speeches
  - easier scraping
    - social networks
    - internet
  - LLMs trained on common speech
- Textual complexity, polarization, and sentiment analysis
   - Why are they important


== Research Questions <sec:research_questions>


Research Questions:
+ *Textual Richness:*
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
      + Which PMs, if any, si more often targeting? 

== Roadmap <sec:roadmap>

Needed? 

+ First step: build the corpus
+ Second step: etc
