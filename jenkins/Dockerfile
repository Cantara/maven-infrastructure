# Copied from https://github.com/jenkinsci/docker
#TODO use zulu jdk8 
#FROM java:8u45-jdk

FROM buildpack-deps:sid-scm

RUN apt-get update && apt-get install -y wget unzip zip maven && rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8

# see https://bugs.debian.org/775775
# and https://github.com/docker-library/java/issues/19#issuecomment-70546872
ENV CA_CERTIFICATES_JAVA_VERSION 20140324

## OpenJDK 
#RUN apt-get update && apt-get install -y openjdk-8-jdk="$JAVA_DEBIAN_VERSION" ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION" && rm -rf /var/lib/apt/lists/*

# Pull Zulu OpenJDK binaries from official repository:
# Remember to update config.xml when changing jdk version
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
RUN echo "deb http://repos.azulsystems.com/debian stable  main" >> /etc/apt/sources.list.d/zulu.list
RUN apt-get -qq update && apt-get -y install zulu-8=8.7.0.5 ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION" && rm -rf /var/lib/apt/lists/*


# see CA_CERTIFICATES_JAVA_VERSION notes above
RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure

ENV JENKINS_HOME /var/jenkins_home

# Jenkins is ran with user `jenkins`, uid = 1000
# If you bind mount a volume from host/vloume from a data container, 
# ensure you use same uid
RUN useradd -d "$JENKINS_HOME" -u 1000 -m -s /bin/bash jenkins

# Jenkins home directoy is a volume, so configuration and build history 
# can be persisted and survive image upgrades
VOLUME /var/jenkins_home

# `/usr/share/jenkins/ref/` contains all reference configuration we want 
# to set on a fresh new installation. Use it to bundle additional plugins 
# or config file with your custom jenkins Docker image.
RUN mkdir -p /usr/share/jenkins/ref/init.groovy.d


COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy

ENV JENKINS_VERSION 1.596.3
#ENV JENKINS_SHA 96ee85602a41d68c164fb54d4796be5d1d9cc5d0
ENV JENKINS_SHA bbfe03f35aad4e76ab744543587a04de0c7fe766

# could use ADD but this one does not check Last-Modified header 
# see https://github.com/docker/docker/issues/8331
RUN curl -L http://mirrors.jenkins-ci.org/war-stable/$JENKINS_VERSION/jenkins.war -o /usr/share/jenkins/jenkins.war \
  && echo "$JENKINS_SHA /usr/share/jenkins/jenkins.war" | sha1sum -c -

ENV JENKINS_UC https://updates.jenkins-ci.org
RUN chown -R jenkins "$JENKINS_HOME" /usr/share/jenkins/ref

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
#EXPOSE 50000

ENV COPY_REFERENCE_FILE_LOG /var/log/copy_reference_file.log
RUN touch $COPY_REFERENCE_FILE_LOG && chown jenkins.jenkins $COPY_REFERENCE_FILE_LOG

USER jenkins

COPY jenkins.sh /usr/local/bin/jenkins.sh
ENTRYPOINT ["/usr/local/bin/jenkins.sh"]

# from a derived Dockerfile, can use `RUN plugin.sh active.txt` to setup /usr/share/jenkins/ref/plugins from a support bundle
COPY plugins.sh /usr/local/bin/plugins.sh


#FROM jenkins
USER root

RUN echo "alias ll='ls -l --color=auto'" >> /etc/bash.bashrc
RUN echo "alias la='ls -la --color=auto'" >> /etc/bash.bashrc

#RUN apt-get update && apt-get install -y maven2 && rm -rf /var/lib/apt/lists/*

# https://raw.githubusercontent.com/paoloantinori/dockerfiles/master/centos/jenkins/Dockerfile
# preconfigure maven location
### not working properly 
#RUN printf "<?xml version='1.0' encoding='UTF-8'?> <hudson.tasks.Maven_-DescriptorImpl> <installations> <hudson.tasks.Maven_-MavenInstallation> <name>maven</name> <home>/usr/share/maven2</home> <properties/> </hudson.tasks.Maven_-MavenInstallation> </installations> </hudson.tasks.Maven_-DescriptorImpl>" >>  $JENKINS_HOME/hudson.tasks.Maven.xml ; chown jenkins:jenkins $JENKINS_HOME/hudson.tasks.Maven.xml 

USER jenkins 

COPY hudson.tasks.Maven.xml /usr/share/jenkins/ref/hudson.tasks.Maven.xml
COPY config.xml /usr/share/jenkins/ref/config.xml

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
