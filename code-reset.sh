#!/usr/bin/env bash

filepath=$(cd "$(dirname "$0")"; pwd)
cat $filepath"/code-check.log" | while read myline
do 
 echo -e ""
arr=(${myline//&/ })  
num=${#arr[@]}   

for (( i = 0; i < num; i++ )); do

if [ $i -eq 0 ]; then
	echo -e "\033[33mformat-id:"${arr[i]}"\033[0m"
else
	echo -e ${arr[i]}
fi
done 
 echo -e ""
done