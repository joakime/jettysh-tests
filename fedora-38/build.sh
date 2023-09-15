#!/bin/env bash
if [ -d ${JETTY_HOME_SRC} ] ; then
    echo "Copying jetty.sh from ${JETTY_HOME_SRC}"
    cp ${JETTY_HOME_SRC}/src/main/resources/bin/jetty.sh jetty.sh
fi
docker build -t jetty-shtest:fedora .
