FROM alpine:latest
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN \
  apk update && \
  apk upgrade && \
  apk add wget curl && \
  rm -rf /var/cache/apk/*

RUN wget https://cdn.azul.com/public_keys/alpine-signing@azul.com-5d5dc44c.rsa.pub
RUN cp alpine-signing@azul.com-5d5dc44c.rsa.pub /etc/apk/keys/
RUN echo "https://repos.azul.com/zulu/alpine" >> /etc/apk/repositories
RUN apk update && \
 apk add zulu13-jdk

# ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

RUN java -version

WORKDIR /root
