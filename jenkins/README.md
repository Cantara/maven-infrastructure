# Jenkins continuous integration server

Goal: Simplify installation and configuration of Jenkins for Java development. 

See https://github.com/jenkinsci/docker for tips, most of it is applicable to this fork as well. 

* Data is stored in a Data Volume Container. Latest Maven 3, Zulu JDK 8 and a few of the most useful plugins are preinstalled. 
* Jenkins Core: 1.609.3 (latest LTS), see http://jenkins-ci.org/changelog#stable 
* List of plugins: https://raw.githubusercontent.com/Cantara/maven-infrastructure/master/jenkins/plugins.txt
* Webproxy (incl. TLS termination) is considered out of scope. Recommend using a separate docker container which links to this container. 
  * https://docs.docker.com/userguide/dockerlinks/ 

## Install and use 

### Install or upgrade Docker 

https://docs.docker.com/installation/ubuntulinux/

```
wget -qO- https://get.docker.com/ | sh
```


###  Install data volume container and jenkins
```
sudo docker pull cantara/jenkins
sudo docker create -v /var/jenkins_home --name jenkins-data cantara/jenkins
sudo docker run -d -p 8080:8080 --volumes-from jenkins-data --name jenkins20150715 cantara/jenkins
```

### Initial Jenkins config, point your browser to http://localhost:8080/
1. Use jenkins to setup security and users
  * https://wiki.jenkins-ci.org/display/JENKINS/Standard+Security+Setup
2. Update plugins, http://localhost:8080/pluginManager/
3. Set up CI user with access to git/github repositories 
  * Create SSH keys: https://developer.github.com/guides/managing-deploy-keys/#machine-users
  * Add SSH private key to Jenkins, http://localhost:8080/credentials/
4. Setup settings.xml to give Jenkins access to non-public Maven repos
  * Add settings.xml, http://localhost:8080/configfiles/
  * Remember to reference the settings.xml file in the build configuration for the Maven project. 

## Backup 

See https://docs.docker.com/userguide/dockervolumes/#backup-restore-or-migrate-data-volumes



## Development 

### TODO 

1. Transitive plugin dependencies are not installed automatically and plugins are not updated to latest version. Perhaps this script https://gist.github.com/micw/e80d739c6099078ce0f3 can fix one or both problems? 


### Build and run for development

```
sudo docker build -t cantara/jenkins .
sudo docker create -v /var/jenkins_home --name jenkins-data cantara/jenkins
sudo docker run -d -p 8080:8080 --volumes-from jenkins-data --name jenkins20150515 cantara/jenkins
```

* To stop and remove all containers: 
```
docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) 
```

* To log in to take a look: 
```
docker ps -a
docker exec -it containerIdHere bash
```

### Decisions 

* Public git repo here: https://github.com/Cantara/maven-infrastructure 
* Dockerhub image built from source:  cantara/jenkins
* Decided to use Data Volume Container 
* Copied from https://github.com/jenkinsci/docker, instead of using _FROM jenkins_ because the published image used openjdk7. 
* Copied from https://github.com/docker-library/java/blob/b4a3c296023e590e410f645ab83d3c11a30cf535/openjdk-8-jdk/Dockerfile and switch to Zulu from OpenJDK
* Install Maven using apt and update Jenkins config to reference it, _hudson.tasks.Maven.xml_. 
* Update Jenkins config to reference JDK installation, _config.xml_. 
* Install plugins usually used in Maven/Java projects. 


### Plugins 

Maintain a list of plugins here to find plugin key, version and description of what it does. 

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
* https://wiki.jenkins-ci.org/display/JENKINS/Release+Plugin

### Read more 

* http://www.catosplace.net/blog/2015/02/11/running-jenkins-in-docker-containers/
* https://registry.hub.docker.com/_/jenkins/
* https://github.com/jenkinsci/docker/blob/master/README.md
* https://raw.githubusercontent.com/jenkinsci/docker/8f909abee98247ad482efb6d21833e2054e3e9de/Dockerfile
* http://www.catosplace.net/blog/2015/02/11/running-jenkins-in-docker-containers/
* http://container-solutions.com/2015/03/running-docker-in-jenkins-in-docker/
* http://container-solutions.com/2014/12/understanding-volumes-docker/
* http://container42.com/2014/11/18/data-only-container-madness/
* https://github.com/paoloantinori/dockerfiles/blob/master/centos/jenkins/Dockerfile
