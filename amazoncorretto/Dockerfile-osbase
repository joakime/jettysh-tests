#   docker build -t jetty-shtest:ubuntu .
#   docker run -it --rm jetty-shtest:ubuntu
#   docker run -it --entrypoint /bin/bash --rm jetty-shtest:ubuntu

FROM amazoncorretto:11.0.20 as base

RUN yum update -y ; \
    yum install -y curl tar gzip vim shadow-utils

ARG TEST_DIR=/var/www/test
ARG JAVA_HOME=$TEST_DIR/$JDK_VERSION
ARG JETTY_BASE=$TEST_DIR/jetty-base

USER root

RUN mkdir -p ${TEST_DIR} ;\
    adduser -d ${JETTY_BASE} jetty ;\
    chmod a+w ${JETTY_BASE}

