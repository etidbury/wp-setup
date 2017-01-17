#!/usr/bin/env bash

currentDirectoryName=${PWD##*/}

read -p "Enter theme directory name (${currentDirectoryName}): "  themeDirectoryName

PLUGINS_DIR="wp-content/themes/"

if [ ${themeDirectoryName} -ge 0 ]; then
    THEME_DIR=wp-content/themes/${themeDirectoryName}
else
    THEME_DIR=wp-content/themes/${currentDirectoryName}
fi

echo "Created theme: '${THEME_DIR}'\n"

WP_ROOT=./ # <-- wordpress root directory

count=0
total=12

function progress(){

  count=$(( $count + 1 ))

  printf "%i/%i - $1\n" $count $total

}

progress "Installing Word Press..."

if [ ! -d ./_install/wordpress ]; then
    progress "Word Press downloading..."
    rm -rf ./_install/wordpress
    cd _install
    curl -O https://wordpress.org/latest.zip
    unzip latest.zip
    cd ../

else
    progress "Word Press already downloaded - Skipping..."
fi

mv ./_install/wordpress/* .


progress "Creating directories..."


mkdir ${THEME_DIR}

###sh ./fix-wordpress-permissions.sh .

mkdir ${THEME_DIR}/js
mkdir ${THEME_DIR}/css
mkdir ${THEME_DIR}/img
mkdir ${THEME_DIR}/fonts
mkdir ${THEME_DIR}/sass


progress "Embedding Grunt Configuration..."


cp ./_install/config.rb ${THEME_DIR}

progress "Installing Bootstrap..."


if [ ! -d ./_install/bootstrap ]; then
    progress "Bootstrap downloading..."
    rm -rf ./_install/bootstrap
    git clone https://github.com/twbs/bootstrap.git ./_install/bootstrap
else
    progress "Bootstrap already downloaded - Skipping..."
fi


cp -a ./_install/init/sass/* ${THEME_DIR}/sass

mkdir ${THEME_DIR}/sass/lib/bootstrap

cp -a ./_install/bootstrap/scss/* ${THEME_DIR}/sass/lib/bootstrap

cp ./_install/bootstrap/dist/js/bootstrap.min.js ${THEME_DIR}/js/



progress "Embedding Fonts..."



cp -a ./_install/init/fonts/* ${THEME_DIR}/fonts



progress "Embedding Javascript..."




cp -a ./_install/init/js/* ${THEME_DIR}/js



progress "Embedding Root Files..."



cp -a ./_install/init/_root/* ${THEME_DIR}




progress "Embedding WP Plugins..."





cp -a ./_install/init/_plugins/* ${PLUGINS_DIR}




progress "Removing unwanted files..."

#rm -rf ./_install
#rm -rf install.sh
#rm -rf install.sh


progress "Updating permissions..."


find ${WP_ROOT} -type d -exec chmod 755 {} \;
find ${WP_ROOT} -type f -exec chmod 644 {} \;


progress "Initiate Github Repository\n"


sh "./_install/git-remote-init.sh" ${THEME_DIR}


progress "Opening phpMyAdmin...\n"

/usr/bin/open -a "/Applications/Google Chrome.app" 'http://localhost/phpmyadmin/server_databases.php?server=1'


exit 1

