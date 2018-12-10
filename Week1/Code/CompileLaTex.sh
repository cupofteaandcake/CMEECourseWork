#!/usr/bin/env bash

# Author: Talia Al-Mushadani (ta1915@imperial.ac.uk)
# Script: CompileLaTeX.sh
# Desc: compiles latex & .bib file into .pdf
# Arguments: .tex file & .bib file
# Date: Oct 2018

pdflatex $1.tex
bibtex $1
pdflatex $1.tex
pdflatex $1.tex
evince $1.pdf &

## Cleanup
rm *~
rm *.aux
rm *.dvi
rm *.log
rm *.nav
rm *.out
rm *.snm
rm *.toc