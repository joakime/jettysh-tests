#   docker build -t jetty-shtest:ubuntu .
#   docker run -it --rm jetty-shtest:ubuntu
#   docker run -it --entrypoint /bin/bash --rm jetty-shtest:ubuntu

FROM ubuntu:22.04 as base

RUN apt update ; \
    apt -y upgrade ; \
    apt install -y openjdk-17-jdk-headless ; \
    apt install -y curl vim

ARG TEST_DIR=/var/www/test
ARG JAVA_HOME=$TEST_DIR/$JDK_VERSION
ARG JETTY_BASE=$TEST_DIR/jetty-base

USER root

RUN mkdir -p ${TEST_DIR} ;\
    mkdir -p ${JETTY_BASE} ;\
    useradd --home-dir=${JETTY_BASE} --shell=/bin/bash jetty ;\
    chown jetty:jetty ${JETTY_BASE} ;\
    chmod a+w ${JETTY_BASE}

