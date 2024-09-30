#!/bin/bash

git add .

time=$(date)

commit=$1

git commit -m "${time} UPGRADE: ${commit}"

git push origin hexo

hexo d -g

