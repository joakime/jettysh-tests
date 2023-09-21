#!/bin/env bash
source ../init.sh
echo JETTY_VERSION=$JETTY_VERSION
cd ..
docker build \
  --file=fedora-38/Dockerfile \
  --build-arg="JETTY_VERSION=${JETTY_VERSION}" \
  --tag=jetty-shtest:fedora .

