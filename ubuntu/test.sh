#!/bin/bash
string=("hello shell split test" "khkj kjh  kh hkjh" )
for var in ${string[@]}
do
   echo -e "$var EOF"
done 
####
echo test2
string="hello shell split test"  
for var in ${string}
do
   echo -e "$var EOF"
done 
