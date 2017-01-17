#!/usr/bin/env bash

currentDirectoryName=${PWD##*/}

read -p "Enter theme directory name (${currentDirectoryName}): "  themeDirectoryName

if [ ${themeDirectoryName} -ge 0 ]; then
    THEME_DIR=wp-content/themes/${themeDirectoryName}
else
    THEME_DIR=wp-content/themes/${currentDirectoryName}
fi

echo "Selected theme: '${THEME_DIR}'\n"


cd "${THEME_DIR}"


compass watch .


/usr/bin/open -a "/Applications/Google Chrome.app" "http://localhost/${currentDirectoryName}"


