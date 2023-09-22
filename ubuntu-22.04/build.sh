#!/bin/env bash
source ../init.sh
cd ..
docker build \
  --file=ubuntu-22.04/Dockerfile-osbase \
  --tag=jetty-shtest:ubuntu-intermediate .
docker build \
  --no-cache \
  --file=ubuntu-22.04/Dockerfile-jetty \
  --build-arg="JETTY_VERSION=${JETTY_VERSION}" \
  --build-arg="JETTY_HOME_NAME=${JETTY_HOME_NAME}" \
  --tag=jetty-shtest:ubuntu .
