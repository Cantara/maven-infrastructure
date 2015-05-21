# Maven Infrastructure using Docker


## Jenkins 




h4. TODO 

# Merge content into [Jenkins Installation Guide - Docker] and move both to README.md 
# Decide one webproxy per service or one separate container with webproxy for build infrastructure. 

* Download plugin dependencies: https://gist.github.com/micw/e80d739c6099078ce0f3

* To log in to take a look: docker exec -it <container-id> bash


jenkins@d3d22c795c75:~$ cat /var/jenkins_home/hudson.tasks.Maven.xml
<?xml version='1.0' encoding='UTF-8'?>
<hudson.tasks.Maven_-DescriptorImpl>
  <installations>
    <hudson.tasks.Maven_-MavenInstallation>
      <name>maven</name>
      <home>/usr/share/maven</home>
      <properties/>
    </hudson.tasks.Maven_-MavenInstallation>
  </installations>


h4. Decisions 

* Public git repo here: https://github.com/Cantara/maven-infrastructure 

* Decided to use Data Volume Container 
* Copied from https://github.com/jenkinsci/docker, instead of using _FROM jenkins_ because the published image used openjdk7. 
* Install Maven using apt and update Jenkins config to reference it, _hudson.tasks.Maven.xml_. 
* Update Jenkins config to reference JDK installation, _config.xml_. 
* Install plugins usually used in Maven/Java projects. 



h4. Jenkins with a Data Volume Container

{code}
sudo mkdir /data
sudo docker build -t sherriff/jenkins .
sudo docker create -v /data/jenkins_home --name jenkins-data sherriff/jenkins
sudo docker run -d -p 8080:8080 --volumes-from jenkins-data --name jenkins20150512 sherriff/jenkins
{code}


https://wiki.jenkins-ci.org/display/JENKINS/Standard+Security+Setup


h6. Plugins 

Core: 1.568 

A recent Git runtime is required (1.7.9 minimum, 1.8.x recommended)

* https://wiki.jenkins-ci.org/display/JENKINS/SCM+API+Plugin
* https://wiki.jenkins-ci.org/display/JENKINS/Git+Client+Plugin
* https://wiki.jenkins-ci.org/display/JENKINS/GitHub+Plugin
* https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin
* https://wiki.jenkins-ci.org/display/JENKINS/Maven+Project+Plugin
* https://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin
* https://wiki.jenkins-ci.org/display/JENKINS/Config+File+Provider+Plugin#ConfigFileProviderPlugin-MavenServerCredentials%28since2.7%29

[plugins.txt|https://raw.githubusercontent.com/Cantara/maven-infrastructure/master/jenkins/plugins.txt] 



h4. Read more 

* http://www.catosplace.net/blog/2015/02/11/running-jenkins-in-docker-containers/
* https://registry.hub.docker.com/_/jenkins/
* https://github.com/jenkinsci/docker/blob/master/README.md
* https://raw.githubusercontent.com/jenkinsci/docker/8f909abee98247ad482efb6d21833e2054e3e9de/Dockerfile
* http://www.catosplace.net/blog/2015/02/11/running-jenkins-in-docker-containers/
* http://container-solutions.com/2015/03/running-docker-in-jenkins-in-docker/
* http://container-solutions.com/2014/12/understanding-volumes-docker/
* http://container42.com/2014/11/18/data-only-container-madness/
* https://github.com/paoloantinori/dockerfiles/blob/master/centos/jenkins/Dockerfile

h4. Old 

Set uid to 1100 in DockerFile. 
{code}
sudo mkdir /data
sudo useradd -d /data/jenkins_home -u 1100 -m -s /bin/bash jenkins
docker run -p 8080:8080 -v /data/jenkins_home/:/var/jenkins_home sherriff/jenkins
{code}


