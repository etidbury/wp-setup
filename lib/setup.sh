#!/usr/bin/env bash
cd "wp-setup/lib"
source "_config.sh"
cd "../../"

#Prompt user for project name (default: [Project Folder Name])
source "${SETUP_LIB_URI}setup-project-name.sh"

#Prompt user for FTP Credentials
source "${SETUP_LIB_URI}setup-ftp-config.sh"


#import FTP Credential variables
source "${FTP_CONFIG_URI}"



tasksCompleted=0
TASK_TOTAL=12

function progress(){

  tasksCompleted=$(( ${tasksCompleted} + 1 ))

  printf "%i/%i - $1\n" ${tasksCompleted} ${TASK_TOTAL}

}

progress "Installing Word Press..."


if [ ! -d ${WP_URI} ]; then
    progress "Word Press downloading..."
    rm -rf ${WP_URI}
    curl -O https://wordpress.org/latest.zip
    unzip latest.zip -d "${TMP_DIR_URI}" #use TMP_DIR_URI to avoid 'wordpress/wordpress/...'
    rm -rf latest.zip
else
    progress "Word Press already downloaded - Skipping..."
fi

cp -a ${WP_URI}. ${PROJECT_ROOT_URI}








progress "Installing Bootstrap..."

if [ ! -d ${BOOTSTRAP_URI} ]; then
    progress "Bootstrap downloading..."
    rm -rf ${BOOTSTRAP_URI}
    git clone https://github.com/twbs/bootstrap.git ${BOOTSTRAP_URI}
else
    progress "Bootstrap already downloaded - Skipping..."
fi

##Embed Bootstrap into initial source files
mkdir ${INIT_SRC_THEME_DIR_URI}sass/lib/bootstrap
cp -a ${BOOTSTRAP_URI}scss/* ${INIT_SRC_THEME_DIR_URI}/sass/lib/bootstrap
cp ${BOOTSTRAP_URI}dist/js/bootstrap.min.js ${INIT_SRC_THEME_DIR_URI}js/






progress "Copying initial source files - Root files..."

cp -a ${INIT_SRC_ROOT_DIR_URI} ${PROJECT_ROOT_URI}

progress "Copying initial source files - Theme files..."

cp -a ${INIT_SRC_THEME_DIR_URI} ${themeURI}

progress "Copying initial source files - Plugin files..."

cp -a ${INIT_SRC_PLUGINS_DIR_URI} ${PLUGINS_DIR_URI}

progress "Removing unwanted files..."

rm -rf ./readme.html # delete WP readme

progress "Updating permissions..."

find ${PROJECT_ROOT_URI} -type d -exec chmod 755 {} \;
find ${PROJECT_ROOT_URI} -type f -exec chmod 644 {} \;

progress "Initiate Github Repository...\n"


sh ${SETUP_LIB_URI}git-remote-helper.sh ${_currentDirectoryName}





progress "Opening phpMyAdmin...\n"

/usr/bin/open -a "/Applications/Google Chrome.app" 'http://localhost/phpmyadmin/server_databases.php?server=1'


exit 1


