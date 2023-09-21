#   docker build -t jetty-shtest:ubuntu .
#   docker run -it --rm jetty-shtest:ubuntu
#   docker run -it --entrypoint /bin/bash --rm jetty-shtest:ubuntu

FROM amazoncorretto:11.0.20 as base

RUN yum update -y ; \
    yum install -y curl tar gzip vim shadow-utils

ARG TEST_DIR=/var/www/test

ARG JAVA_HOME=$TEST_DIR/$JDK_VERSION

ARG JETTY_VERSION=10.0.16
ARG JETTY_HOME=$TEST_DIR/jetty-home-$JETTY_VERSION
ARG JETTY_BASE=$TEST_DIR/jetty-base

USER root

COPY jetty-home-archives/jetty-home-${JETTY_VERSION}.tar.gz ${TEST_DIR}/jetty-home-${JETTY_VERSION}.tar.gz
COPY jetty-home-archives/jetty.sh $JETTY_HOME/bin/jetty.sh

RUN mkdir -p ${TEST_DIR} ;\
    cd ${TEST_DIR} ;\
    tar -zxf jetty-home-${JETTY_VERSION}.tar.gz

# Setup jetty.sh defaults
RUN echo "JETTY_HOME=${JETTY_HOME}" > /etc/default/jetty ;\
    echo "JETTY_BASE=${JETTY_BASE}" >> /etc/default/jetty 

RUN adduser -d ${JETTY_BASE} jetty ;\
    chmod a+w ${JETTY_BASE}

USER jetty

# Setup Jetty Base
RUN set -xe ;\
    id ;\
    cd ${JETTY_BASE} ;\
    java -jar ${JETTY_HOME}/start.jar --add-to-startd=http ;\
    chmod u+w ${JETTY_BASE}/resources/* ;\
    echo "org.eclipse.jetty.util.PidFile.LEVEL=DEBUG" >> ${JETTY_BASE}/resources/jetty-logging.properties

WORKDIR ${JETTY_BASE}

