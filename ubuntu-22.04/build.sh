#!/bin/env bash
source ../init.sh
echo JETTY_VERSION=$JETTY_VERSION
cd ..
docker build \
  --file=ubuntu-22.04/Dockerfile \
  --build-arg="JETTY_VERSION=${JETTY_VERSION}" \
  --tag=jetty-shtest:ubuntu .
