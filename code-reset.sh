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
elif [ $i -eq 1 ]; then
	echo -e "time:"${arr[i]}
# elif [ $i -eq 2 ]; then
	# modcontent=${arr[i]}
	# modarr=(${modcontent//^/ })  
	# size=${#modarr[@]}   
	# for (( j = 0; j < size; j++ )); do
	# echo -e ${modarr[j]}
	# done
fi
done 
 echo -e ""
done