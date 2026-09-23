#import "../config/variables.typ": *
#import "../config/thesis-config.typ": *
#set heading(numbering:"1.")
#set math.equation(numbering: "1.", supplement: none)
//#pagebreak(to:"odd")

= State of the Art <ch:state_of_the_art>

== Textual Complexity <sec:sots_textual_complexity>

Text complexity or readability refers to how difficult a text is to understand @dubay_principles_2004, influenced by linguistic factors such as word choice (e.g., "utilize" vs. "use"), sentence structure (complex vs. simple), and content type (academic vs. children’s books) @dale_formula_1948 @graesser_cohmetrix_2004. \
Common comprehension metrics are Flesch Reading Ease @flesch_new_1948, which considers the average sentence length and syllables per word, and outputs a value between zero (hard to read) and one hundred (easy to read); Dale-Chall @dale_formula_1948, which measures a raw score taking in consideration a list of 3000 words that groups of fourth-grade American students could reliably understand, considering any word not on that list to be difficult; and SMOG @mclaughlin_smog_1969, which uses intuitive features like sentence length and word complexity. 

Another way to measure the complexity is by measuring the *lexical diversity*, which is the ratio of different unique word types compared to the total number of words. In a sense, it measures the vocabulary richness of a sample. \
The most common metric is the Type-Token Ratio, obtained by simply dividing word types over tokens. A TTR of $0.5$ means that half of the words in the sample appear only once. \
A more refined metric was introduced by McCarthy in 2005: it is the measure of textual lexical diversity (MTLD) @mccarthy_assessment_2005. 
It uses a sequential algorithm to count tokens until lexical repetition forces the ratio below a fixed threshold, reducing text-length bias, and it's widely applied in computational linguistics for corpus profiling, tracking writing development, and evaluating machine translation quality.
MTLD has become a standard tool in applied linguistics and computational text analysis, and it is often used as a measure of lexical diversity, lexical complexity, or lexical sophistication  @lin_large_2025.

Let's now have a look at the recent research. \
Bestgen (2024) @bestgen_measuring_2024 published a methodological review on the subject of lexical diversity,  (type–token ratio), MTTRRS (mean type–token ratio in random samples), MATTR (moving-average type–token ratio), MSTTR (mean segmental type–token ratio), MTTRSS (mean type–token ratio in sequential samples), and MTLD (measure of textual lexical diversity). Its findings show that for a local estimation, MATTR and MTLD are recommended. While MTLD appeared to be slightly more sensitive to length than MATTR, the differences were insufficient to declare one superior to the other.

#v(1em)

Velasco and Roque (2025) @velasco_rethinking_2025 explored the role of text complexity in language model pretraining. In their study, they measured how complexity affects language modeling across model sizes, whether useful representations can be learned from simpler text alone, and how text complexity in pretraining influences downstream language understanding. They used a subset of _FineWeb-Edu_ @penedo_fineweb_2024, then simplified by prompting _Llama 3.1 8B_ @grattafiori_llama_2024 at the paragraph level. \
To get a rough idea of what the simplified texts look like, see the following example: 

#blockquote[
    *Original:* Your comment really helped me feel better the most. I was sitting in my office, feeling so bad that I didn’t say how inappropriate and out of line his comments were, and this helped.
]
#blockquote[
    *Simplified:* Your comment really helped me feel better. I was feeling bad because I didn’t speak up when someone made inappropriate comments.
]

Since LLM-based scoring is computationally costly, they used Flesch Reading Ease to estimate readability, and Type-Token Ratio to measure lexical diversity.

#v(1em)

Amadori et al. (2025) @amadori_involvement_2025 examined the linguistic complexity of content produced by influential users on Twitter across three globally significant and contested topics: COVID-19, COP26, and the Russia–Ukraine war. Their findings show significant differences across account type, political leaning, content reliability, and sentiment. Additionally, profiles producing more negative and offensive content tend to use more complex language. \
They used three metrics: Flesch readability score; Yule's K measure of lexical richness @yule_statistical_2014, which  quantifies how repetitive or diverse the vocabulary is, and it is largely independent of the overall length of a text; and gzip-based compression complexity, which assesses text repetitiveness by measuring its compression ratio, an approach already explored in previous studies @parada-cabaleiro_song_2024 @desiderio_recurring_2023 @dimarco_patterns_2024.


#v(1em)

Lastly, Fredrick and Craven (2025) @fredrick_lexical_2025 compared AI-generated texts (via ChatGPT) and student-written essays in terms of lexical diversity, syntactic complexity, and readability, using metrics such as Type-Token Ratio and Flesch-Kincaid. Results indicate that while ChatGPT produces texts with greater lexical diversity and syntactic complexity, the outputs are overall less readable.\
They chose a range of linguistic complexity metrics: for lexical diversity they used TTR and MTLD, for syntactic complexity MLT and DC/T, for readability Flesc-Kincaid and Gunning-Fog, and lastly they also measured lexical sophistication.

#v(1em)

For the purposes of this project, I decided to limit the scope to one lexical complexity metric. MTLD was chosen due to its wide adoption in literature and its robustness to text length: collected speeches (section @ch:corpus) vary in length between one another, going from a couple of lines to more than twenty thousand words. 


== Polarization <sec:sots_polarization>

- What is
Political polarization is the divergence of political attitudes away from the center, towards ideological extremes @fiorina_political_2008 @baldassarri_partisans_2008 @dimaggio_have_1996. Scholars distinguish between ideological polarization (differences in ideological positions) and affective polarization (a dislike and distrust of political out-groups) @iyengar_origins_2019, and between elite polarization (polarization of the political elites, such as elected official), and mass polarization (the polarization of the general public) @carmines_who_2012 @layman_party_2006 @hetherington_review_2009. 

*Affective polarization* refers to the phenomenon where individuals' feelings and emotions towards members of their own in-group become more positive, while their feelings towards members of the opposing out-groups become more negative.  This can lead to increased hostility, unwillingness to compromise or work together with people with different political views, may lead to aggressive attitudes and behaviors toward members of other ideological groups @hetherington_why_2015, and in extreme cases can even lead to societal disintegration and ideological sorting @orianharel_conflict_2020 @nettasinghe_how_2025.

*Elite polarization* refers to polarization between the governing parties and the opposition @baldassarri_partisans_2008. Polarized political parties are internally cohesive, unified, and ideologically distinct, and they are typically found in a parliamentary system of democratic governance @mann_its_2016. While in bipartisan systems the direction of polarization is intuitive, studies show that in multipartite systems it is not the number of parties itself, but the way a party interacts with another that influences the magnitude and nature of affective polarization @hahm_divided_2022.\
On the other hand, *mass polarization* occurs when an electorate's attitudes towards political issues, policies, celebrated figures, or other citizens are neatly divided along party lines @claassen_policy_2009. At the extreme, each camp questions the moral legitimacy of the other, viewing the opposing camp and its policies as an existential threat to their way of life or the nation as a whole @geiger_partisanship_2016 @garcia-guadilla_polarization_2019. 



- Common metrics

While there are no straightforward and established metrics to measure polarization, it has been estimated via a variety of methods. \
McMurtrie et al. proposed in 2024 the Affective Polarization Scale @mcmurtrie_development_2024. They subjected participants to a series of statements. Each participant was asked to rate each statement on a 7-point scale, from _strongly disagree_ to _strongly disagree_. 
Questions were in the form of:

#let blank = box(width: 2em, line(length: 100%, stroke: 0.5pt))
#blockquote[
    I would be upset if my friend married a #blank
]

The researchers filled in the blanks with the out-group respective to the single participant (meaning, for a Democrat-leaning participant, the blank could be filled with _"Conservative"_). The resulting score is then averaged across all statements.

#v(1em)

A different approach were taken by Gentzkow et al. (2019) @gentzkow_measuring_2019.  Their mathematical model revolves around the formula for partisanship  of speech for given characteristics $x$:

$ pi_t (bold(x)) = 1/2 bold(q)^R_t (bold(x)) dot bold(rho)_t (bold(x)) + 1/2 bold(q)^D_t (bold(x)) dot (1 - bold(rho)_t (bold(x)) ), $<math:gentzkow>

They measured differences in speech patterns between Republicans and Democrats, finding a dramatic increase in polarized speech patterns starting from 1994.

#v(1em)

Nettasinghe et al. (2025) @nettasinghe_ingroup_2025 used a regression-based approach. They estimated two parameters (in-group love #sym.alpha, and out-group hate #sym.beta) by measuring how likely it is for an individual to switch their stance on a opinionated topic (e.g., pro or anti lockdown during COVID). They took paris of consecutive observations of a user's stance and fitted a logistic regression one the outcome "did the stance change?". They used as predictors how supportive of said change their in-group and out-group were, and the coefficients resulting from the fitting become #sym.alpha and #sym.beta. \
To build the corpus, they used a fine-tuned Llama model to classify the stances of millions of tweets.



== Sentiment Analysis <sec:sots_sentiment_analysis>

- What is
- Common metrics
- State of the art: what has been done in the field, what are the gaps, what are the limitations

// remove after finish working on it 
// just to save ram 

#include "../bibliography/bibliography.typ"

#include "corpus.typ"
#include "conclusions.typ"
#include "results.typ"
#include "future_works.typ"