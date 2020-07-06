#!/bin/bash

#latexmk -C
 
tex_file=$(ls | grep -o -P ".+(?=\.tex)");

latexmk -silent $tex_file".tex"; 

grep -i -n --color -P -B 0 -A 8 "\[\d+\]" ./temp/$tex_file".log"
