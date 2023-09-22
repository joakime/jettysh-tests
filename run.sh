#!/bin/env bash

OSIMG="$1"

if [ -z "$OSIMG" ] ; then
    echo "ERROR: No os-image provided"
    echo "Usage: ./run.sh <osimg>"
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

docker run \
  -it \
  --entrypoint /bin/bash \
  --rm \
  jetty-sh:$OSIMG
