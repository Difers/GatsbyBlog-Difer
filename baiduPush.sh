#!/bin/bash
path=$(dirname "$PWD")"/public/.notion"
echo $path;
 
files=$(ls $path)
head=$1
for filename in $files
do 
  filename=${filename%.*}
  filename=$(echo $filename | tr -d "-")
  echo $filename
  echo "https://${head}/${filename}" > urls.txt
done

set -e
curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=https://www.difer.life&token=NlmhlJXmwqWlcQcQ"
rm -rf urls.txt