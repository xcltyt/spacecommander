#!/usr/bin/env bash

filepath=$(cd "$(dirname "$0")"; pwd)
cat $filepath"/code-check.log" | while read myline
do 
 echo -e ""
arr=(${myline//&/ })  
num=${#arr[@]}   

for (( i = 0; i < num; i++ )); do

if [ $i -eq 0 ]; then
	echo -e "\033[33mformat-time:"${arr[i]}"\033[0m"
elif [ $i -eq 1 ]; then
	echo -e "format-file:"${arr[i]}
fi
done 
 echo -e ""
done