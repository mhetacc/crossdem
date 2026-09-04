#import "./config/variables.typ": *
#import "./config/thesis-config.typ": *
#import "@preview/subpar:0.2.2"

#show: config.with(
  myAuthor: myName,
  myTitle: myTitle,
  myLang: myLang
)


// Frontmatter

#include "templates.typ"

#include "./preface/firstpage.typ"
#include "./preface/copyright.typ"
#include "./preface/dedication.typ"
#include "./preface/summary.typ"
// #include "./preface/acknowledgements.typ"
#include "./preface/table-of-contents.typ"
#include "./preface/list.typ"


// Mainmatter
#pagebreak(to: "odd")
#set page(numbering: "1")
//---------------------- header -----------------------
#let in-chapters = state("in-chapters", false)

#let is-chapter-start(loc) = {
  let chapters = query(heading.where(level: 1))
  chapters.any(c => c.location().page() == loc.page())
}

#let current-chapter-title(loc) = {
  let chapters = query(heading.where(level: 1))
  let prior = chapters.filter(c => c.location().page() <= loc.page())
  if prior.len() > 0 { prior.last().body } else { [] }
}

#let current-subchapter-title(loc) = {
  let subs = query(heading.where(level: 2))
  let prior = subs.filter(s => s.location().page() <= loc.page())
  if prior.len() > 0 { prior.last().body } else { [] }
}

#set page(header: context {
  if in-chapters.get() and not is-chapter-start(here()) {
    grid(
      columns: (auto, 1fr, auto),
      align: horizon,
      image("images/unipd-logo.svg", height: 2.5em),
      [],
      [#current-chapter-title(here()) • #current-subchapter-title(here())]
    )
    v(-0.3em)
    line(length: 100%, stroke: 0.8pt + rgb("#B5001B"))
    v(-1em) // pulls the body content up, closer to the line
  }
})
//--------------------------------------------------

#in-chapters.update(true)
#include "./chapters/introduction.typ"
#include "./chapters/state_of_the_art.typ"
#include "./chapters/corpus.typ"
#include "./chapters/results.typ"
#include "./chapters/future_works.typ"
#include "./chapters/conclusions.typ"
#in-chapters.update(false)

// Appendices
#state("appendix-mode", false).update(true)
#include "./appendix/appendix-A.typ"
// Bibliography
#include("./bibliography/bibliography.typ")


