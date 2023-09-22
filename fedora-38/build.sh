#!/bin/env bash
source ../init.sh
cd ..
docker build \
  --file=fedora-38/Dockerfile-osbase \
  --tag=jetty-shtest:fedora-intermediate .
docker build \
  --no-cache \
  --file=fedora-38/Dockerfile-jetty \
  --build-arg="JETTY_VERSION=${JETTY_VERSION}" \
  --build-arg="JETTY_HOME_NAME=${JETTY_HOME_NAME}" \
  --tag=jetty-shtest:fedora .

