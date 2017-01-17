if [ ! ${SETUP_ROOT_URI} ]; then

    SETUP_ROOT_URI="wp-setup/"

    cd ../../
    _currentDirectoryName=${PWD##*/}
    cd ${SETUP_ROOT_URI}lib

    SETUP_LIB_URI=${SETUP_ROOT_URI}"lib/"
    PROJECT_ROOT_URI="./"

    THEMES_DIR_URI=${PROJECT_ROOT_URI}"wp-content/themes/"
    PLUGINS_DIR_URI=${PROJECT_ROOT_URI}"wp-content/plugins/"

    FTP_CONFIG_URI=${SETUP_LIB_URI}"ftp-config.sh"

    INIT_SRC_THEME_DIR_URI=${SETUP_ROOT_URI}"init-src/_theme/"
    INIT_SRC_PLUGINS_DIR_URI=${SETUP_ROOT_URI}"init-src/_plugins/"
    INIT_SRC_ROOT_DIR_URI=${SETUP_ROOT_URI}"init-src/_root/"

    TMP_DIR_URI=${SETUP_ROOT_URI}"tmp/"

    WP_DIR="wordpress/"
    BOOTSTRAP_DIR="bootstrap/"

    WP_URI=${TMP_DIR_URI}${WP_DIR}
    BOOTSTRAP_URI=${TMP_DIR_URI}${BOOTSTRAP_DIR}

fi

