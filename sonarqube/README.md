# SonarQube using Docker

Goal: Simplify installation of SonarQube

- SonarQube version 6.0
- Base image: https://github.com/Cantara/maven-infrastructure/tree/master/docker-baseimages/alpine-zulu-jdk8

## Install and use

### Install or upgrade Docker

https://docs.docker.com/installation/ubuntulinux/

	$ wget -qO- https://get.docker.com/ | sh

### Install and run SonarQube

	$ sudo docker run \
		-d \
		-p 9000:9000 \
		-e SONARQUBE_JDBC_USERNAME=<username> \
		-e SONARQUBE_JDBC_PASSWORD=<password> \
		-e SONARQUBE_JDBC_URL=<jdbc_url> \
		--name sonarqube \
		cantara/sonarqube

### Initial SonarQube config

1. Point browser http://localhost:9000/
2. Login as admin
    * Default credentials are admin:admin
3. Change your password
    * http://localhost:9000/account/security
4. Force user authentication
    * http://localhost:9000/settings?category=security
    * Set *Force user authentication* to *true*
5. Generate security token for use with other services
    * http://localhost:9000/account/security
6. Update plugins
    * http://localhost:9000/updatecenter/installed

## Development

### Build and run with embedded database

	$ docker build -t cantara/sonarqube .
	$ docker run -d -p 9000:9000 --name sonarqube cantara/sonarqube

### Build and run with postgresql

	$ docker run -e POSTGRES_USER=sonar -e POSTGRES_PASSWORD=sonar -p 5432:5432 -d --name sonarqube-postgres postgres
	$ docker run -d --link sonarqube-postgres:pgsonar -e SONARQUBE_JDBC_USERNAME=sonar -e SONARQUBE_JDBC_PASSWORD=sonar -e SONARQUBE_JDBC_URL=jdbc:postgresql://pgsonar:5432/sonar --name sonarqube -p 9000:9000 cantara/sonarqube
		
### Plugins

Maintain a list of plugins here to find plugin key, version and description of what it does.

- http://sonarsource.bintray.com/Distribution/sonar-java-plugin/
- http://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/
- http://sonarsource.bintray.com/Distribution/sonar-csharp-plugin/
- http://sonarsource.bintray.com/Distribution/sonar-scm-git-plugin/
- http://sonarsource.bintray.com/Distribution/sonar-scm-svn-plugin/

### Read more

- http://docs.sonarqube.org/display/SONAR/Documentation
