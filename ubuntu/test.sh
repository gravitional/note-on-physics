#!/bin/bash

echo $IFS 
string="hello,shell,split,test"  
 
#对IFS变量 进行替换处理
OLD_IFS="$IFS"
IFS=","
array=($string)
IFS="$OLD_IFS"
 
for var in ${array[@]}
do
   echo -e "$var\n"
done
