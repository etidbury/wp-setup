#!/usr/bin/env bash

git status


read -p "Confirm syncing changes ('y' to confirm): "  yesNo

if [ ${yesNo} == "y" ]; then
    read -p "Commit message: "  commitMessage

    if [ !"${commitMessage}" ]; then

        git commit -am commitMessage

        git pull
        git push -u origin master

        echo "Syncing with FTP Server..."

        sh ./lib/git-ftp-helper.sh push


    else
        echo "Commit message not specified - Cancelling..."
    fi
fi


####
exit 1


