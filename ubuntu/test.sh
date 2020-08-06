#!/bin/bash
echo test2
string="hello shell split test"  
for var in "${string}"
do
   echo -e "$var EOF"
done 
