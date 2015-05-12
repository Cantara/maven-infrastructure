### Docs: https://github.com/jenkinsci/docker/blob/master/README.md

FROM jenkins
USER root

RUN echo "alias ll='ls -l --color=auto'" >> /etc/bash.bashrc
RUN echo "alias la='ls -la --color=auto'" >> /etc/bash.bashrc

RUN apt-get update && apt-get install -y maven2 && rm -rf /var/lib/apt/lists/*

# https://raw.githubusercontent.com/paoloantinori/dockerfiles/master/centos/jenkins/Dockerfile
# preconfigure maven location
### not working properly 
#RUN printf "<?xml version='1.0' encoding='UTF-8'?> <hudson.tasks.Maven_-DescriptorImpl> <installations> <hudson.tasks.Maven_-MavenInstallation> <name>maven</name> <home>/usr/share/maven2</home> <properties/> </hudson.tasks.Maven_-MavenInstallation> </installations> </hudson.tasks.Maven_-DescriptorImpl>" >>  $JENKINS_HOME/hudson.tasks.Maven.xml ; chown jenkins:jenkins $JENKINS_HOME/hudson.tasks.Maven.xml 

USER jenkins 

COPY hudson.tasks.Maven.xml /usr/share/jenkins/ref/hudson.tasks.Maven.xml

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

