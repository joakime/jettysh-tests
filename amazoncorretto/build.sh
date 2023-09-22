#!/bin/env bash
source ../init.sh
cd ..
docker build \
  --file=amazoncorretto/Dockerfile-osbase \
  --tag=jetty-shtest:amazon-intermediate .
docker build \
  --no-cache \
  --file=amazoncorretto/Dockerfile-jetty \
  --build-arg="JETTY_VERSION=${JETTY_VERSION}" \
  --build-arg="JETTY_HOME_NAME=${JETTY_HOME_NAME}" \
  --tag=jetty-shtest:amazon .

