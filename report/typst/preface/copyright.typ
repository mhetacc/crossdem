#import "../config/variables.typ" : myName, myTitle, myTitle2, myDegree, myAA, myUni

#set par(first-line-indent: 0em)
#align(left + bottom, [
    #text(myName), #text(style: "italic", myTitle) #text(style: "italic", myTitle2) \
    #text(myDegree) ,  #text(myUni),  #sym.copyright #text(myAA)
 \ \
    _This document was prepared using Typst, based on #link("https://github.com/davidespada99/Master-Thesis")[Davide Spada]'s template. In addition, LLMs (Claude Sonnet 5, Gemini 3.6 Flash, and Copilot Free) were used to check both syntax and semantics. All source code (Python and Typst), as well as the whole dataset, are available in the repository: \
    #align(right, link("https://github.com/mhetacc/crossdem"))_
])
