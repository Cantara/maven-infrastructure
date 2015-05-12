### Docs: https://github.com/jenkinsci/docker/blob/master/README.md

FROM jenkins
USER root
RUN apt-get update && apt-get install -y maven2 && rm -rf /var/lib/apt/lists/*
USER jenkins 

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
