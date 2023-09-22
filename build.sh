#!/bin/env bash

OSIMG="$1"

if [ -z "$OSIMG" ] ; then
    echo "ERROR: No os-image provided"
    echo "Usage: ./build.sh <osimg>"
    exit 1
fi

if [ ! -d "os-platforms/$OSIMG" ] ; then
    echo "ERROR: Unable to find os-image: $OSIMG"
    echo "Available os-images:"
    IMGS=$(find os-platforms -type f -name "Dockerfile")
    for IMG in $IMGS
    do
        IMG=$(basename $(dirname $IMG))
        echo "    $IMG"
    done
    exit 1
fi

source ./init.sh
docker build \
  --no-cache \
  --file=Dockerfile-jetty \
  --build-arg="OSIMG=$OSIMG" \
  --build-arg="JETTY_VERSION=${JETTY_VERSION}" \
  --build-arg="JETTY_HOME_NAME=${JETTY_HOME_NAME}" \
  --tag=jetty-sh:$OSIMG .
