#   docker build -t jetty-shtest:fedora .
#   docker run -it --rm jetty-shtest:fedora
#   docker run -it --entrypoint /bin/bash --rm jetty-shtest:fedora

FROM fedora:38 as base

RUN dnf update -y
RUN dnf install -y java-11-openjdk-headless
RUN dnf install -y curl vim

ARG TEST_DIR=/var/www/test
ARG JAVA_HOME=$TEST_DIR/$JDK_VERSION
ARG JETTY_BASE=$TEST_DIR/jetty-base

USER root

RUN mkdir -p ${TEST_DIR} ;\
    mkdir -p ${JETTY_BASE} ;\
    useradd --home-dir=${JETTY_BASE} --shell=/bin/bash jetty ;\
    chown jetty:jetty ${JETTY_BASE} ;\
    chmod a+w ${JETTY_BASE}


