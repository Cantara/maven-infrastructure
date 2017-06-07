# FROM alpine:3.6
FROM cantara/jvmprep

MAINTAINER totto@totto.org
# Based upon work by josh@grahamis.com
# If release changes, the checksum and URL need to be updated
# See http://www.azulsystems.com/products/zulu/downloads#Linux
#
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/maven-infrastructure/docker-baseimages/alpine-zulu-jdk9/Dockerfile" \
      org.label-schema.license="Apache License - Version 2.0" \
      org.label-schema.name="Maven Docker Infrastructure - Zulu JDK9 Baseimage" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-type="Github" \
      org.label-schema.vcs-url="https://github.com/Cantara/maven-infrastructure"
# Replace duplicate files in JDK bin with links to JRE bin
# If release changes, the checksum and URL need to be updated
# See http://www.azulsystems.com/products/zulu/downloads#Linux
#
# Replace duplicate files in JDK bin with links to JRE bin

USER root

# Install packages
RUN \
  echo ipv6 >> /etc/modules && \
  apk update && \
  apk upgrade && \
  apk add --update ca-certificates curl



# Secure the container so that no base users (e.g. root, operator) have a login.
# Provide a script that runs every container invocation (specifically to update Java net.properties).
# Get ready to accept a JVM installation.

ENV JAVA_HOME /usr/local/java
ENV JRE ${JAVA_HOME}/jre
ENV JAVA_OPTS=-Djava.awt.headless=true PATH=${PATH}:${JRE}/bin:${JAVA_HOME}/bin
ENV ENV=/etc/shinit.sh

COPY shinit.sh /etc/

RUN \
  chmod a=rx /etc/shinit.sh && \
  mkdir java
WORKDIR /tmp/java


RUN \
  checksum="22c045a-cccf560-550abf30e8cc0" && \
  url="http://cdn.azul.com/zulu-pre/bin/zulu9.0.0.12-ea-jdk9.0.0-linux_x64.tar.gz" && \
  referer="http://www.azulsystems.com/zuludoc" && \
  etag=$(curl -sI --referer "${referer}" "${url}" | awk -F"\"|:" '/^ETag: / {print $3}') && \
  if [ "X${checksum}" == "X${etag}" ]; then \
    curl -O -L --referer "${referer}" "${url}"; \
  else \
    echo "[FATAL] Java ZIP ETag ${etag} doesn't match checksum ${checksum}. Exiting." >&2 && \
    exit 1; \
  fi && \
  tar -xzf   *.gz && \
  rm *.gz && \
  mkdir  ${JAVA_HOME} && \
  mv zu*/* ${JAVA_HOME} && \
  cd .. && \
  rm -rf ${OLDPWD} && \
  cd ${JAVA_HOME} && \
  rm -rf *.zip demo man sample && \
  for ff in ${JAVA_HOME}/bin/*; do f=$(basename $ff); if [ -e ${JRE}/bin/$f ]; then ln -snf ${JRE}/bin/$f $ff; fi; done && \
  chmod a+w ${JAVA_HOME}/conf ${JAVA_HOME}/conf/net.properties && \
  rm -rf /var/cache/apk/*

WORKDIR /root

# ENTRYPOINT ["/usr/bin/dumb-init", "--"]


