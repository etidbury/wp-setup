#!/usr/bin/env bash
cd "wp-setup/lib"
source "_config.sh"
cd "../../"


if [ ! -f ${FTP_CONFIG_URI} ]; then
    echo "FTP Configuration file not found"
else

    source ${FTP_CONFIG_URI}

    echo "Configuring for FTP: ${FTP_URL}"

    git config git-ftp.url ${FTP_URL}
    git config git-ftp.user ${FTP_USERNAME}
    git config git-ftp.password ${FTP_PASSWORD}

    sh $1
    # Upload all files

    # Or if the files are already there
    #sh ${GIT_FTP_SH_URI} catchup

fi
