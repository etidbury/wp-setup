#!/usr/bin/env bash

git init
git add .
git commit -am 'Initial commit - test'
curl -u 'etidbury' https://api.github.com/user/repos -d "{\"name\":\"$1\"}"
git remote add origin "https://github.com/etidbury/$1.git"
git push -u origin master