#!/usr/bin/env sh
# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
npm run build

# 进入生成的文件夹
cd vuepress

git init
git add -A
git commit -m 'update'

# 如果发布到 https://<USERNAME>.github.io 需要将ZhangPingFan改成自己的id
git push -f git@github.com:ZhangPingFan/ZhangPingFan.github.io.git master
cd -