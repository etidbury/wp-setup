#!/usr/bin/env bash
cd "wp-setup/lib"
source "_config.sh"
cd "../../"

if [ ! -f ${FTP_CONFIG_URI} ]; then #if not file exists
    echo "Configuration file not found..."
    rm -rf ${FTP_CONFIG_URI}
    #git clone https://github.com/twbs/bootstrap.git ${FTP_CONFIG_URI}
    read -p "Enter FTP URL (e.g. ftp://host.example.com:2121/mypath): " ftp_url
    read -p "Enter FTP Username: " ftp_username
    read -p "Enter FTP Password: " ftp_password

    echo "FTP_URL=${ftp_url}\nFTP_USERNAME=${ftp_username}\nFTP_PASSWORD=${ftp_password}\n" > ${FTP_CONFIG_URI}

else
    echo "Configuration file already found."
fi
