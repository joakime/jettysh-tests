#!/bin/env bash

BASEDIR=$(dirname $(realpath $0))

if [ -d "$BASEDIR/jetty-home-archives" ]
then
  export JETTY_HOME_ARCHIVES="$BASEDIR/jetty-home-archives"
else
    while [ ! -d "$BASEDIR/jetty-home-archives" ]
    do
        BASEDIR=$(dirname $BASEDIR)
        if [ -d "$BASEDIR/jetty-home-archives" ]
        then
            export JETTY_HOME_ARCHIVES="$BASEDIR/jetty-home-archives"
        fi

        if [ "$BASEDIR" == "/" ]
        then
            echo "ERROR: Unable to find JETTY_HOME_ARCHIVES directory"
            exit 1
        fi
    done
fi

# export JETTY_VERSION=10.0.17-SNAPSHOT
export JETTY_VERSION=10.0.17-20230921.215746-22
export JETTY_HOME_NAME=${JETTY_VERSION}
export JETTY_URL=https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-home/$JETTY_VERSION/jetty-home-${JETTY_VERSION}.tar.gz
export JETTY_HOME_TARBALL=${JETTY_HOME_ARCHIVES}/jetty-home-${JETTY_VERSION}.tar.gz
# JETTY_HOME_SRC=/home/joakim/code/jetty/jetty.project-10.0.x/jetty-home

if expr "$JETTY_VERSION" : ".*-SNAPSHOT$" > /dev/null
then
    cp -v "$HOME/.m2/repository/org/eclipse/jetty/jetty-home/${JETTY_VERSION}/jetty-home-${JETTY_VERSION}.tar.gz" \
          "$JETTY_HOME_TARBALL"
else
    if [ ! -f "${JETTY_HOME_TARBALL}" ]
    then
        echo "Tarball does not exist: $JETTY_HOME_TARBALL"
        cd $JETTY_HOME_ARCHIVES
        HTTP_CODE=$(curl --silent --output "$JETTY_HOME_TARBALL" --write-out "%{http_code}" ${JETTY_URL})
        if [[ ${HTTP_CODE} -ne 200 ]]
        then
            echo "ERROR: Failed to GET $JETTY_URL"
            echo "       Response code: $HTTP_CODE"
            rm -f ${JETTY_HOME_TARBALL} 2> /dev/null
            exit 1
        fi

        # Verify that it downloaded?
        if [ ! -r "${JETTY_HOME_TARBALL}" ]
        then
          echo "ERROR: Unable to GET jetty-home-${JETTY_VERSION}.tar.gz"
          exit 1
        else
          echo "Downloaded new jetty-home-${JETTY_VERSION}.tar.gz"
        fi
    fi
fi

JETTYSHFILENAME=$(tar -ztf "$JETTY_HOME_TARBALL" | grep jetty.sh)
JETTY_HOME_NAME=$(dirname $(dirname $JETTYSHFILENAME))

if [ -d "${JETTY_HOME_SRC}" ] ; then
    # Copy jetty.sh from SRC
    echo "Copying jetty.sh from ${JETTY_HOME_SRC}"
    cp -v ${JETTY_HOME_SRC}/src/main/resources/bin/jetty.sh "$JETTY_HOME_ARCHIVES/jetty.sh"
else
    # Extract from TARBALL
    echo "Extracting ${JETTY_HOME_NAME}/bin/jetty.sh from $JETTY_HOME_TARBALL .."
    tar -zxf "${JETTY_HOME_TARBALL}" "${JETTY_HOME_NAME}/bin/jetty.sh"
    cp "${JETTY_HOME_NAME}/bin/jetty.sh" "$JETTY_HOME_ARCHIVES/jetty.sh"
    if expr "${JETTY_HOME_NAME}" : "^jetty-home-[1-9]*.*" > /dev/null
    then
      rm -rf ${JETTY_HOME_NAME}
    fi
fi
touch "${JETTY_HOME_ARCHIVES}/jetty.sh"

echo "Jetty Version: $JETTY_VERSION"
echo "Jetty Archive: $JETTY_HOME_TARBALL"
echo "Jetty Home   : $JETTY_HOME_NAME"
