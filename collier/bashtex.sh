#etc/bin/bash

#latexmk -C
 
tex_file=ls | grep -P ".+\.tex";

latexmk $tex_file | grep --color -n -P -A 8 "x:\d+:"

