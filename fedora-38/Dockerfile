#   docker build -t jetty-shtest:fedora .
#   docker run -it --rm jetty-shtest:fedora
#   docker run -it --entrypoint /bin/bash --rm jetty-shtest:fedora

FROM fedora:38 as base

RUN dnf update -y
RUN dnf install -y java-11-openjdk-headless
RUN dnf install -y curl vim

ARG TEST_DIR=/var/www/test

ARG JAVA_HOME=$TEST_DIR/$JDK_VERSION

ARG JETTY_VERSION=10.0.16
ARG JETTY_DIST=jetty-home-${JETTY_VERSION}
ARG JETTY_URL=https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-home/$JETTY_VERSION/$JETTY_DIST.tar.gz
ARG JETTY_HOME=$TEST_DIR/$JETTY_DIST
ARG JETTY_BASE=$TEST_DIR/jetty-base

WORKDIR $TEST_DIR
RUN curl "$JETTY_URL" | tar xz

COPY jetty.sh $JETTY_HOME/bin/jetty.sh

# Setup Jetty Base
RUN set -xe ;\
    mkdir ${JETTY_BASE} ;\
    cd ${JETTY_BASE} ;\
    java -jar ${JETTY_HOME}/start.jar --add-to-startd=http


