#!/bin/bash
# knit.sh -- Dave Kleinschmidt, April 2013
# streamline knitting of Rnw files from the command line.

usage="Usage: $0 input-filename.Rmd [-nolatex] [-notangle]"

if [ $# -lt 1 ]; then
    echo $usage
    exit 1
fi 

rnwinput=$1
shift 

nolatex=1
notangle=1

while [ $# -gt 0 ]
do
    case "$1" in
        -nolatex) nolatex=1;;
        -notangle) notangle=1;;
        -*) echo $usage >&2
            exit 1;;
        *) break;;
    esac
    shift
done


# first knit Rnw file into
fileName=${rnwinput%.*}

echo "library(rmarkdown); render(input='$rnwinput')" | R --no-save --no-restore

if [ $notangle -ne 1 ]; then
    echo "library(knitr); knit(input='$rnwinput', tangle=T);" | R --no-save --no-restore
fi

if [ $nolatex -ne 1 ]; then
    pdflatex ${fileName}.tex && pdflatex ${fileName}.tex
fi
