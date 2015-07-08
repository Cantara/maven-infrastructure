# Docker file inspired by 
# https://github.com/Cantara/maven-infrastructure/blob/master/jenkins/Dockerfile
# https://registry.hub.docker.com/u/sonatype/nexus/dockerfile/

FROM cantara/zulu

MAINTAINER erik-dev@fjas.no

### Install Nexus 
ENV SONATYPE_WORK /sonatype-work
ENV NEXUS_VERSION 2.11.3-01


RUN mkdir -p /opt/sonatype/nexus \
  && curl --fail --silent --show-error --location --retry 3 \
    https://download.sonatype.com/nexus/oss/nexus-${NEXUS_VERSION}-bundle.tar.gz \
  | tar xzf - -C /tmp nexus-${NEXUS_VERSION} \
  && mv /tmp/nexus-${NEXUS_VERSION}/* /opt/sonatype/nexus/ \
  && rm -rf /tmp/nexus-${NEXUS_VERSION}


RUN useradd -r -u 1001 -m -c "nexus role account" -d ${SONATYPE_WORK} -s /bin/false nexus

VOLUME ${SONATYPE_WORK}

EXPOSE 8081
WORKDIR /opt/sonatype/nexus
USER nexus
ENV CONTEXT_PATH /
ENV MAX_HEAP 768m
ENV MIN_HEAP 256m
ENV JAVA_OPTS -server -XX:MaxPermSize=192m -Djava.net.preferIPv4Stack=true
ENV LAUNCHER_CONF ./conf/jetty.xml ./conf/jetty-requestlog.xml
CMD java \
  -Dnexus-work=${SONATYPE_WORK} -Dnexus-webapp-context-path=${CONTEXT_PATH} \
  -Xms${MIN_HEAP} -Xmx${MAX_HEAP} \
  -cp 'conf/:lib/*' \
  ${JAVA_OPTS} \
  org.sonatype.nexus.bootstrap.Launcher ${LAUNCHER_CONF}

