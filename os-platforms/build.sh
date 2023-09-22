#!/bin/env bash

DOCKERFILES=$(find . -type f -name Dockerfile)

for DOCKERFILE in $DOCKERFILES
do
    DIRNAME=$(dirname $DOCKERFILE)
    BASENAME=$(basename $DIRNAME)
    OSIMAGE=$BASENAME
    docker build --file=$OSIMAGE/Dockerfile --tag=jetty-sh:os-$OSIMAGE $OSIMAGE/
done


