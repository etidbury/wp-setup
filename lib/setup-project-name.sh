#!/usr/bin/env bash
cd "wp-setup/lib"
source "_config.sh"
cd "../../"


###retrieve project folder name

themeURI=''

read -p "Enter theme directory name (${_currentDirectoryName}): "  themeDirectoryName

if [ ${themeDirectoryName} -ge 0 ]; then

    echo "Please rename directory to ${themeDirectoryName} and re-run setup"
    exit 1
else
    themeURI=${THEMES_DIR_URI}${_currentDirectoryName}
fi