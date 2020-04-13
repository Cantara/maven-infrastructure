FROM alpine:latest
# cantara/jvmprep

MAINTAINER totto@totto.org
# Based upon work by josh@grahamis.com
# If release changes, the checksum and URL need to be updated
# See http://www.azulsystems.com/products/zulu/downloads#Linux
#
#  https://cdn.azul.com/zulu/bin/zulu8.31.0.1-jdk8.0.181-linux_x64.tar.gz
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/maven-infrastructure/docker-baseimages/alpine-zulu-jdk9/Dockerfile" \
      org.label-schema.license="Apache License - Version 2.0" \
      org.label-schema.name="Maven Docker Infrastructure - Zulu JDK8 Baseimage" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-type="Github" \
      org.label-schema.vcs-url="https://github.com/Cantara/maven-infrastructure"
# Replace duplicate files in JDK bin with links to JRE bin
# If release changes, the checksum and URL need to be updated
# See http://www.azulsystems.com/products/zulu/downloads#Linux
#
# Replace duplicate files in JDK bin with links to JRE bin

RUN \
  apk update && \
  apk upgrade && \
  apk add wget curl && \
  rm -rf /var/cache/apk/*

RUN wget https://cdn.azul.com/public_keys/alpine-signing@azul.com-5d5dc44c.rsa.pub
RUN cp alpine-signing@azul.com-5d5dc44c.rsa.pub /etc/apk/keys/
RUN echo "https://repos.azul.com/zulu/alpine" >> /etc/apk/repositories
RUN apk update && \
 apk add zulu8-jdk

# ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

RUN java -version

WORKDIR /root

