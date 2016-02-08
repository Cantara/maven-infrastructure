# Maven Infrastructure using Docker

## Version Control 

https://github.com/ or set up your own git server. 


## Nexus 
https://github.com/Cantara/maven-infrastructure/tree/master/nexus


## Jenkins 
https://github.com/Cantara/maven-infrastructure/tree/master/jenkins


## Maven Parent POM
https://github.com/Cantara/maven-infrastructure/tree/master/parentpom

## Some good Java Docker Baseimages

alpine-openjdk-jdk8
alpine-zulu-jdk8
alpine-zulu-jdk9
debian-sid-zulu-jdk8
debian-sid-zulu-jdk9


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

## Zulu
A stripped down Zulu base-image for generic OpenJDK8 servers based upon the official Azul Docker Image
https://github.com/Cantara/maven-infrastructure/tree/master/zulu

## Aggregated log-server
An initial setup for the greylog2 log-server is provided 

