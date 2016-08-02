#!/usr/bin/env bash
# ~/.git_template.local/hooks/pre-commit
# format-objc-hook
# pre-commit hook to check if any unformatted Objective-C files would be committed. Fails the check if so, and provides instructions.
#
# Copyright 2015 Square, Inc

IFS=$'\n'
export CDPATH=""
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$DIR"/lib/common-lib.sh

# 保证 .clang-format 文件存在的情况下再执行
[ -e ".clang-format" ] || exit 0

objc_files=$(objc_files_to_format "$1")
[ -z "$objc_files" ] && exit 0
random=""

function format_objc() {
  #随机数
  randstr
  #备份文件目录
  dir_backup="spacecommander/backup/${random}"$randstr

  for file in $objc_files; do
    single_success=0
    difference=$("$DIR"/format-objc-file-dry-run.sh "$file" | diff "$file" - | wc -l)
    if [ $difference -gt 0 ]; then
      #备份文件,新建备份文件夹
      if [ ! -d $dir_backup ]; then
        $(mkdir -p "spacecommander/backup/${random}"$randstr);
      fi

      exit_flag=1

       echo -e "\033[32m>> FileNeedToFormat : '$file' \033[0m\n"

        #备份文件
       file_backup="spacecommander/backup/${random}/"${file##*/}
       $(cp "$file" "$file_backup") 
        #备份日志
       datetime=`date "+%Y-%m-%d/%H:%M:%S"`

       if ! grep -q "$random" "spacecommander/code-check.log"; then
         echo -e $random"&"$datetime"&"$file","$file_backup"\c" >> "spacecommander/code-check.log"
       else
         echo -e "^"$file","$file_backup"\c" >> "spacecommander/code-check.log"
       fi

      #后台处理 文件处理 文件对比
       $(cp "$file" "$file.format") 

       if [ -e "$file.format" ]; then
         $("$DIR"/Format-objc-file.sh "$file.format")
        #vimdiff窗体展示
         vimdiff "$file" "$file.format" < /dev/tty > /dev/tty
         
         $(rm -f  "$file.format")
          #窗体关闭后再次校验代码是否进行修改
          double_difference=$("$DIR"/format-objc-file-dry-run.sh "$file" | diff "$file" - | wc -l)
          if [ $double_difference -eq 0 ]; then
            single_success=1
          fi
       fi

       # 实际还需要判断是否修改过

       # 未成功修改  
       if [ $single_success -eq 0 ]; then
          echo -e "\n\033[31m>> '$file' did not pass the code check , format it with this:\033[0m"
          echo -e "\"$DIR\"/Format-objc-file.sh '$file' && git add '$file';\n"
          let success+=1
       # 成功修改 
       elif [ $single_success -eq 1 ]; then
          $(git add "$file")
       # echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
       fi
    fi
  done

  if  grep -q "$random" "spacecommander/code-check.log"; then
      echo "" >> "spacecommander/code-check.log"
  fi
  if [ $success -ge 1 ]; then
      echo -e "\033[31m>> you can format all with this:\033[0m\n\"$DIR\"/format-objc-files.sh -s"
      echo -e "\n\033[31m>> tip-one :\033[0m  There were formatting issues with this commit, run the👆 above👆 command to fix.\n\033[31m>> tip-two :\033[0m  Commit anyway and skip this check by running git commit --no-verify"
  elif [ $success -eq 0 ] && [ $exit_flag -eq 1 ]; then
      success=0
      echo -e "\033[32m>> success and you need to commit again !!! \033[0m\n"
      #协助提交掉成功的代码
  fi


  return $success 
}
function randstr() {
  index=0
  for i in {a..z}; do arr[index]=$i; index=`expr ${index} + 1`; done
  for i in {0..9}; do arr[index]=$i; index=`expr ${index} + 1`; done
  for i in {1..20}; do random="$random${arr[$RANDOM%$index]}"; done
}
#入口
success=0
exit_flag=0

format_objc 

exit $exit_flag
