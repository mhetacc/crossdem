# Goal

![](imgs/goalthesis.jpg)

Cross-compare:
- **Politicians' rhetoric**
  - complexity analysis
  - lexical analysis
  - hate speech detection
  - sentiment analysis 
  - etc
- **Democracy levels**
  - V-Dem dataset
  - Free speech
  - Separation of powers 
  - etc

Simplicity in visualization is a must: easy to read graphs are more usable -> reach bigger audience [soruce?]

Taking opposing colours can incite polarization, even though the effects are limited [source?]

# Politicians' Rhetoric  

2 Types:
- **To institutions (inside)**
  - Parliamentary speeches
  - Senate speeches
  - etc
- **To the people (outside)**
  - Official messages to the nation
  - Public speeches
  - Interviews
  - Social networks messages (video or textual)
    - eg Tweets
    - eg Videos on facebook (eg il diario di giorgia)

Social networks are at this point the main communication vehicle for politicians in the global north [source?], therefore it is of greater interest to gauge the political temperature via *outside communications*. Moreover, stenographic documents preceding a certain period are not 1:1 transcriptions of the actual speeches, but rather "speak the language of the parliament" [Cortelazzo,1985]  [Mohrhoff,1987]

Two other **advantages** of **outside communications**: 
1. A lot of documents
2. Easy automatization: take the social networks of politicians and track it

## Social Media and Public Opinions

### 2023, most used by europeans
For 71% of respondents, TV was one of their most used media to access news in the past days. TV is followed by online press and/or news platforms (42%). Radio and social media platforms (both 37%) are on shared third position followed by the written press (21%). Important to note that social media grew by 11 points since the previous year. Younger respondents are much more likely to use social media platform (59% of 15-24 year-olds vs 24% of 55+ year-olds) [eurobarometer,2023].

### 2024, most used by brits
49% reported using television to follow election news this summer. That compared against 26% who used social media, 24% who said they used news apps, 24% who used radio, 19% newspaper websites, 17% news sites not associated with newspapers and 16% word of mouth [maher,2024].

### Social Media as a Public Space for Politics: Cross-National Comparison of News Consumption and Participatory Behaviors in the United States and the United Kingdom
[saldana,2015]

#### Summary

Evidence of social media role in promoting citizens’ political engagement (US and UK)

#### Content

news consumption is positively related to political participation in both countries. In other words, the more people consume news and political information, the more they participate in politics. 

### Designing and validating the Social Media Political Participation Scale: An instrument to measure political participation on social media
[waeterloos,2021]

#### Summary

Evaluate political participation through social media

#### Content

Instrument SMPPS: Social Media Political Participation Scale measure who is politically engaged and why, as well as how digital technologies are embedded in diverse forms of political action. -> that captures the complexity of political partici- pation through social media platforms

#### Citations

In this regard, Bennett and Segerberg [3] introduced the concept of connective action. According to the authors, *taking public action has increasingly become an act of personal expression*. Hereby, a new logic of participation has emerged where ‘sharing’ is the starting point of political participation, enabled by various personal communication technologies such as social media [Bennet,2012] [bennet&seger,2012]

### Social media discourse and voting decisions influence: sentiment analysis in tweets during an electoral period
[rita,2022]

#### Summary

Tweets sentiment analysis is not a reliable election result predictor.

#### Content

this study searches for a conclusion of the actual persuasion capacity of social media in the electors when they need to decide whom to vote for as their next government -> to achieve it, it compares the sentiment that Social Media users demonstrated during an electoral period with the actual results of those election

Data were collected using R. The treatment and analysis were done with R and RapidMiner. Results show that tweets’ sentiment is not a reliable election results predictor. Additionally, results also show that it is impossible to state that social media impacts voting decisions. At least not from the polarity of the sentiment of opinions on social media

#### Citations

### Analyzing voter behavior on social media during the 2020 US presidential election campaign
[belcastro,2022]

#### Summary

Use social media data to poll public opinion on 2020 US presidential elections.

#### Content

2020 US presidential elections: determine in the weeks preceding the Election Day which candidate or party public opinion is most in favor of by jointly applying topic discovery, opinion mining, and emotion analysis techniques on social media data

Specifically, a real-time analysis was carried out during the 2020 US presidential election campaign using data gathered from Twitter, *correctly determining* Joe Biden’s lead over Donald Trump before the Election Day.

The obtained results confirm the great effectiveness of our approach, which outperformed the average of the latest opinion polls by *correctly identifying* the leading candidate before the Election Day *in 10 out of 11 swing states*. 

*One major drawback of this approach lies in different possible platform biases*, such as usage biases due to the distribution of users of a social media platform in terms of gender, age, culture and social status, as well as technical biases related to platform policies about data availability and restrictions imposed in some areas of the world

#### Citations

### A systematic review of worldwide causal and correlational evidence on digital media and democracy
[loren-spreen,2023]

#### Summary

Correlation between social media usage and 

#### Content

#### Citations

### Title
[]

#### Summary

#### Content

#### Citations

### Title
[]

#### Summary

#### Content

#### Citations

# Exam Scope Limiting

One country: Italy


# Text Corpus

Step 1: find text corpus:

- Italian politicians' public speeches
- Limited time scope

## What Corpus

1. Public speeches
   - official 
     - press conference
     - speeches to the nations
     - radio
     - tv
     - etc
   - unofficial
     - social network?
2. Parliament speeches
   - Italy: Camera dei Deputati
   - US: United States House of Representatives
   - FR: Assemblée nationale 
3. Presidential speeches
   - [Discorsi dei Presienti della Repubblica](https://archivio.quirinale.it/aspr/discorsi/search/result)

*At the 2005 UN World Summit, the speakers of parliament who came to United Nations Headquarters from every corner of the globe stated unequivocally that, within a democracy, parliament is the central institution through which the will of the people is expressed, laws are passed, and government is held to account* [...] *The fact that most parliaments have established their presence on the Web makes the legislative process and parliamentary proceedings more transparent and subject to public scrutiny.* [https://www.researchgate.net/profile/Cornelia-Ilie/publication/303459695_Parliamentary_Discourse/links/59d9dbdc458515a5bc2b1b17/Parliamentary-Discourse.pdf]

### Social Networks
*International survey data suggest online media audience members are largely passive consumers, while content creation is dominated by a small number of social users who post comments and write new content* [Tracking the future of news Reuters Institute digital news report 2013]

## Time Scope

## Geographical Scope

Only politicians of national relevance -> no majors or regional representative and similar.

## Corpus sources

### Accademia della crusca - Banca dati discorsi parlamentari
https://leader.accademiadellacrusca.org/

Filtered stenographic documents from 1948 to 2011

Focus on leadership, on some highly representative leaders.

Oss: until circa 1985 stenograph people changed things i.e., did not transcript word for word [Michele A. Cortelazzo, Dal parlato al (tra)scritto: i resoconti stenografici dei discorsi parlamentari, in Günter Holtus – Edgar Radtke (Hrsg.), Gesprochenes Italienisch in Geschichte und Gegenwart, Tübingen, Narr, 1985, pp. 86-118.]  [Aurelia Mohrhoff, Dalla lingua del Parlamento alla lingua del parlamentare, «Serie delle verifiche di professionalità dei consiglieri parlamentari», 1987, 1, p. 157.].

#### Elenco leader influenti

https://www.paroladileader.com/p/blog-page_24.html


### Documenti Stenografici Camera

Ordine del giorno + trascrizioni camera dei deputati

*Until May 1996 (excluded):* Only pdfs. Text is digitalized with OCR (optical character recognition).
After its all in HTML format.

#### Legislature 1048 - 2018

https://legislatureprecedenti.camera.it/

#### Legislatura 2022 - Attuale

https://www.camera.it/leg19/207?annomese=2022,10

#### Legislature Storiche 1848 - 1943

Lavori Parlamentari: https://storia.camera.it/lavori#nav 

Regno di Sardegna: legislature I -> VII
Regno d'Italia: legislature VIII -> XXX

### Documenti Stenografici Senato 

https://www.senato.it/legislature/1/lavori/assemblea/resoconti-elenco-cronologico?year=1953


