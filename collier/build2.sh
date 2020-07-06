#!/bin/bash

tex_file=$(ls | grep -o -P ".+(?=\.tex)");

latexmk -xelatex  -silent -pv -bibtex -cd -recorder -file-line-error -halt-on-error -interaction=nonstopmode -synctex=1 -view=pdf ${tex_file};

# -shell-escape

grep -i -n --color -P -B 0 -A 8 "\[\d+\]" ./temp/$tex_file".log"

