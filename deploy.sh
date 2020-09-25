# !/usr/bin/env sh
# 确保脚本抛出遇到的错误
set -e
yarn build # 生成静态文件
cd public # 进入生成的文件夹
find . -type f -name '*.map' | xargs rm
echo come
# deploy to github
# echo 'difer.life' > CNAME
echo Start_in_GitHub

if [ -z "$GITHUB_TOKEN" ]; then
  msg='deploy'
  githubUrl=git@github.com:Difers/Difer.git
else
  msg='来自github action的自动部署'
  githubUrl=https://Difers:${GITHUB_TOKEN}@github.com/Difers/Difer.git
  git config --global user.name "Difers"
  git config --global user.email "c7070655110@gmail.com"
fi
git init
git add -A
git commit -m "${msg}"
git push $githubUrl master:master # 推送到github

echo Start_in_Coding
# deploy to coding
# echo 'difer.life' > CNAME  # 自定义域名
if [ -z "$CODING_TOKEN" ]; then  # -z 字符串 长度为0则为true；$CODING_TOKEN来自于github仓库`Settings/Secrets`设置的私密环境变量
  codingUrl=git@e.coding.net:difer/Difer.git
else
  codingUrl=https://JRlEjyEyIh:${CODING_TOKEN}@e.coding.net/difer/Difer.git
fi
# git add -A
# git commit -m "${msg}"
git push -f $codingUrl master # 推送到coding

