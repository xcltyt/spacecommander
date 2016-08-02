
filepath=$(cd "$(dirname "$0")"; pwd)
cat $filepath"/code-check.log" | while read myline
do 
 echo "LINE:"$myline
done