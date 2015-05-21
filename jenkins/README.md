# Jenkins 

Goal: Simplify installation and configuration of Jenkins for Java development. 

Data is stored in a Data Volume Container. Maven 3, OpenJDK 8 and a few of the most useful plugins are preinstalled. 

Jenkins Core: 1.568

See [plugins.txt|https://raw.githubusercontent.com/Cantara/maven-infrastructure/master/jenkins/plugins.txt] for the updated plugin list with versions.


## TODO 

1. Switch from OpenJDK to Zulu JDK 
2. Use latest Maven. Debian package currently used is version 3.0.5. 
3. Use script to download plugin dependencies: https://gist.github.com/micw/e80d739c6099078ce0f3 ? 

## Install and use 

* *Use jenkins to setup security and users)*
** https://wiki.jenkins-ci.org/display/JENKINS/Standard+Security+Setup
* *Create SSH keys*
** Add SSH keys, http://localhost:8080/credentials/
* Add settings.xml, http://localhost:8080/configfiles/
** Remember to reference the settings.xml file in the build configuration for the Maven project. 


## Build and run for development

{code}
sudo mkdir /data
sudo docker create -v /data/jenkins_home --name jenkins-data cantara/jenkins
sudo docker run -d -p 80:8080 --volumes-from jenkins-data --name jenkins20150512 cantara/jenkins
{code}

* To stop and remove all containers: docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) 

* To log in to take a look: docker exec -it <container-id> bash

## Decisions 

* Public git repo here: https://github.com/Cantara/maven-infrastructure 
* Dockerhub image built from source:  cantara/jenkins
* Decided to use Data Volume Container 
* Copied from https://github.com/jenkinsci/docker, instead of using _FROM jenkins_ because the published image used openjdk7. 
* Install Maven using apt and update Jenkins config to reference it, _hudson.tasks.Maven.xml_. 
* Update Jenkins config to reference JDK installation, _config.xml_. 
* Install plugins usually used in Maven/Java projects. 


## Plugins 

* https://wiki.jenkins-ci.org/display/JENKINS/SCM+API+Plugin
* https://wiki.jenkins-ci.org/display/JENKINS/Git+Client+Plugin
* https://wiki.jenkins-ci.org/display/JENKINS/GitHub+Plugin
* https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin
* https://wiki.jenkins-ci.org/display/JENKINS/Maven+Project+Plugin
* https://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin
* https://wiki.jenkins-ci.org/display/JENKINS/Config+File+Provider+Plugin#ConfigFileProviderPlugin-MavenServerCredentials%28since2.7%29
* https://wiki.jenkins-ci.org/display/JENKINS/Build+Monitor+Plugin
* https://wiki.jenkins-ci.org/display/JENKINS/Slack+Plugin
* https://wiki.jenkins-ci.org/display/JENKINS/Static+Code+Analysis+Plug-ins
* https://wiki.jenkins-ci.org/display/JENKINS/OWASP+Dependency-Check+Plugin

## Read more 

* http://www.catosplace.net/blog/2015/02/11/running-jenkins-in-docker-containers/
* https://registry.hub.docker.com/_/jenkins/
* https://github.com/jenkinsci/docker/blob/master/README.md
* https://raw.githubusercontent.com/jenkinsci/docker/8f909abee98247ad482efb6d21833e2054e3e9de/Dockerfile
* http://www.catosplace.net/blog/2015/02/11/running-jenkins-in-docker-containers/
* http://container-solutions.com/2015/03/running-docker-in-jenkins-in-docker/
* http://container-solutions.com/2014/12/understanding-volumes-docker/
* http://container42.com/2014/11/18/data-only-container-madness/
* https://github.com/paoloantinori/dockerfiles/blob/master/centos/jenkins/Dockerfile
