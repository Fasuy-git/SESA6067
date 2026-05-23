// Define module variables here

#let module_code = [SESA 6067]
#let module_name = [Spacecraft Orbital Mechanics]
#let semester_and_year = [Semester 2 (Jan 26 - Mar 26)]
#let author = [Yusaf Sultan]
#let lecturers = [Alexander Wittig]

//Import all libraries from template file
#import "template.typ": *

// LaTex-ify the Typst
#set page(margin: 1in)
#set text(font: "New Computer Modern")

// Need to show word count for total word func
#show: word-count

// Large centered title
#v(9cm)

#align()[
  #text(28pt)[*#module_code*] \

  #text(15pt)[#module_name - Coursework]
]

#v(1fr)

#line(length: 100%)


#align(left)[
  Author: #author \
  Lecturer: #lecturers\
  Word Count: #total-words  \
  #v(2cm)
]

#pagebreak()  // start new page after title page

#set page(
  header: [
    #module_code: #module_name - Coursework
    #h(1fr)
    #v(-0.3cm)
    #line(length: 100%)
  ],
  footer: context [
    #align(center)[
      #box(height: 14pt)[#v(0.35cm) #line(length: 43%)]
      #h(0.569cm)
      #counter(page).display("1")
      #h(0.569cm)
      #box(height: 14pt)[#v(0.35cm) #line(length: 43%)]
    ]
  ],
)

// LaTex-ify the Typst
#set text(hyphenate: true)
#set par(
  spacing: 0.65em,
)

#show heading: set block(below: 1.2em)
#set par(spacing: 1.5em)
#set figure(gap: 1.5em)

// Contents Page
#align(left)[

  #outline()

]

#show figure: set block(breakable: true)
#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)", supplement: [Eq.])
#set heading(numbering: "1.")
#set math.mat(delim: "[")
#set math.vec(delim: "[")

#include "coursework.typ"
