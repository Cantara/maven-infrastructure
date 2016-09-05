# Maven Infrastructure using Docker

A collection of tools and recepies to make your Maven world shine :)

## The basics:  Some good small Java JDK Docker Baseimages

### Java 9 JDK
* alpine-zulu-jdk9 [![](https://images.microbadger.com/badges/image/cantara/alpine-zulu-jdk9.svg)](https://microbadger.com/images/cantara/alpine-zulu-jdk9 "Get your own image badge on microbadger.com")
  * https://hub.docker.com/r/cantara/alpine-zulu-jdk9/
  * https://github.com/Cantara/maven-infrastructure/tree/master/docker-baseimages/alpine-zulu-jdk9
* debian-sid-zulu-jdk9 [![](https://images.microbadger.com/badges/image/cantara/debian-sid-zulu-jdk9.svg)](https://microbadger.com/images/cantara/debian-sid-zulu-jdk9 "Get your own image badge on microbadger.com")
  * https://hub.docker.com/r/cantara/debian-sid-zulu-jdk9/
  * https://github.com/Cantara/maven-infrastructure/tree/master/docker-baseimages/debian-sid-zulu-jdk9

### Java 8 JDK
* alpine-zulu-jdk8 [![](https://images.microbadger.com/badges/image/cantara/alpine-zulu-jdk8.svg)](https://microbadger.com/images/cantara/alpine-zulu-jdk8 "Get your own image badge on microbadger.com")
  * https://hub.docker.com/r/cantara/alpine-zulu-jdk8/
  * https://github.com/Cantara/maven-infrastructure/tree/master/docker-baseimages/alpine-zulu-jdk8
* alpine-openjdk-jdk8 [![](https://images.microbadger.com/badges/image/cantara/alpine-openjdk-jdk8.svg)](https://microbadger.com/images/cantara/alpine-openjdk-jdk8 "Get your own image badge on microbadger.com") 
  * https://hub.docker.com/r/cantara/alpine-openjdk-jdk8/
  * https://github.com/Cantara/maven-infrastructure/tree/master/docker-baseimages/alpine-openjdk-jdk8
* debian-sid-zulu-jdk8 [![](https://images.microbadger.com/badges/image/cantara/debian-sid-zulu-jdk8.svg)](https://microbadger.com/images/cantara/debian-sid-zulu-jdk8 "Get your own image badge on microbadger.com")
  * https://hub.docker.com/r/cantara/debian-sid-zulu-jdk8/
  * https://github.com/Cantara/maven-infrastructure/tree/master/docker-baseimages/debian-sid-zulu-jdk8


# Tools

## Nexus [![](https://images.microbadger.com/badges/image/cantara/nexus.svg)](https://microbadger.com/images/cantara/nexus "Get your own image badge on microbadger.com") 
* https://hub.docker.com/r/cantara/nexus/
* https://github.com/Cantara/maven-infrastructure/tree/master/nexus


## Jenkins [![](https://images.microbadger.com/badges/image/cantara/jenkins.svg)](https://microbadger.com/images/cantara/jenkins "Get your own image badge on microbadger.com") 
* https://hub.docker.com/r/cantara/jenkins/ 
* https://github.com/Cantara/maven-infrastructure/tree/master/jenkins

## SonarCube [![](https://images.microbadger.com/badges/image/cantara/sonarqube.svg)](https://microbadger.com/images/cantara/sonarqube "Get your own image badge on microbadger.com") 
* https://hub.docker.com/r/cantara/sonarqube/ 
* https://github.com/Cantara/maven-infrastructure/tree/master/sonarqube


## Webproxy 

Not using docker yet. 

sudo aptitude install apache and use something like the following for webproxy config: 

```
NameVirtualHost *:80
<VirtualHost *:80>
        ServerName jenkins.company.no
        ProxyRequests     Off
        ProxyPreserveHost ON
        ProxyPass / http://localhost:8080/ nocanon
        ProxyPassReverse / http://localhost:8080/
        ProxyPassReverse  /  http://jenkins.company.no/i
        AllowEncodedSlashes NoDecode
</VirtualHost>
<VirtualHost *:80>
        ServerName mvnrepo.company.no
        ProxyPreserveHost ON
        ProxyPass / http://localhost:8081/
        ProxyPassReverse / http://localhost:8081/
</VirtualHost>
```

## Maven Parent POM
https://github.com/Cantara/maven-infrastructure/tree/master/parentpom

## Version Control

https://github.com/ or set up your own git server.


## Aggregated log-server
An initial setup for the greylog2 log-server is provided 

