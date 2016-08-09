#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DIR_BACKUP=$( cd ~/Documents && pwd )

filePath=$1
backup_filePath=$DIR_BACKUP"/codeCheckerCache/"$filePath

if [ -f $filePath ]; then
	if [  -f $backup_filePath  ]; then
         $(cp  "$backup_filePath" "$filePath") 
		 echo -e "\033[32m>> reset '$filePath' success \033[0m\n"
	fi
fi
