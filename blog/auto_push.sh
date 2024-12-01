#!/bin/bash

git_commit_push(){
    
    git add .

    local time=$(date)

    local commit=$1

    git commit -m "${time} UPGRADE: ${commit}"

    git push origin hexo

    echo "git commit and push finished."
}

hexo_develop_to_git(){

    hexo d -g || npx hexo d -g

    echo "hexo develop to github.io finished."
}

while getopts ":g:d:h" optname
do
    case "$optname" in
      "g")
        echo "get option -g,value is $OPTARG"
        git_commit_push $OPTARG
        ;;
      "d")
        echo "get option -d"
        hexo_develop_to_git
        ;;
      "h")
        echo "get option -h"
        echo "-g: auto git commit and push. it'll use argument as commit content."
        echo "-d: auto hexo develop to github.io finished."
        ;;
      ":")
        echo "No argument value for option $OPTARG"
        ;;
      "?")
        echo "Unknown option $OPTARG"
        ;;
      *)
        echo "Unknown error while processing options"
        ;;
    esac
    #echo "option index is $OPTIND"
done


