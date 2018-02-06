# FROM frolvlad/alpine-glibc
# FROM cantara/jvmprep
FROM version42/alpine-glibc:alpine3.5-glibc2.25r0
# FROM frolvlad/alpine-glibc:alpine-3.6
# alpine-3.5_glibc-2.25

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

ENV JAVA_HOME /usr/local/java
ENV JRE ${JAVA_HOME}/jre
ENV JAVA_OPTS=-Djava.awt.headless=true PATH=${PATH}:${JRE}/bin:${JAVA_HOME}/bin
ENV ENV=/etc/shinit.sh

COPY shinit.sh /etc/

RUN mkdir /usr/local/java
RUN mkdir /usr/local/java/jre
RUN mkdir /usr/local/java/jre/lib
RUN touch /usr/local/java/jre/lib/net.properties

WORKDIR /tmp

# If release changes, the checksum and URL need to be updated
# See http://www.azulsystems.com/products/zulu/downloads#Linux
#
# Replace duplicate files in JDK bin with links to JRE bin
RUN \
  echo ipv6 >> /etc/modules && \
  echo 'http://dl-cdn.alpinelinux.org/alpine/v3.5/main/' > /etc/apk/repositories && \
  apk add --no-cache --virtual=build-dependencies ca-certificates wget && \
  sed -i -e 's#:/bin/[^:].*$#:/sbin/nologin#' /etc/passwd && \
  chmod a=rx /etc/shinit.sh && \
  checksum="f4d50665cee287bd5580363a695c1354" && \
  url="http://cdn.azul.com/zulu/bin/zulu9.0.4.1-jdk9.0.4-linux_x64.tar.gz" && \
  referer="http://zulu.org/download/" && \
  wget --referer "${referer}" "${url}" && \
  md5=$(md5sum *.tar.gz | cut -f1 -d' ') && \
  if [ ${checksum} != ${md5} ]; then \
    echo "[FATAL] File md5 ${md5} doesn't match published checksum ${checksum}. Exiting." >&2 && \
    exit 1; \
  fi && \
  rm -f APKINDEX.* && \
  tar -xzf *.tar.gz && \
  rm -f *.tar.gz && \
  mkdir -p $(dirname ${JAVA_HOME}) && \
  mv * ${JAVA_HOME} && \
  cd ${JAVA_HOME} && \
  rm -rf *.zip demo man sample && \
  for ff in ${JAVA_HOME}/bin/*; do f=$(basename $ff); if [ -e ${JRE}/bin/$f ]; then ln -snf ${JRE}/bin/$f $ff; fi; done && \
  chmod a+w ${JRE}/lib ${JRE}/lib/net.properties && \
  apk del ca-certificates openssl wget && \
  rm -rf /tmp/* /var/cache/apk/* 

# RUN apk add libstdc++

RUN ln -s /usr/local/java/zulu9.0.4.1-jdk9.0.4-linux_x64/bin/java /usr/bin/java
RUN java -version

# RUN apk add libstdc++
WORKDIR /root
