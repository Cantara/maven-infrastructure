#Forked from https://raw.githubusercontent.com/jenkinsci/docker/8f909abee98247ad482efb6d21833e2054e3e9de/Dockerfile
FROM jenkins
USER root
#RUN apt-cache update && apt-get install -y maven2
RUN apt-get update && apt-get install -y maven2 && rm -rf /var/lib/apt/lists/*
USER jenkins 

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
