# maven-infrastructure

## Purpose
Collection of Docker-based tools and recipes for Maven development infrastructure. Provides Docker base images for Java applications, Nexus Maven repository, Jenkins CI, SonarQube, and Graylog2 configurations.

## Tech Stack
- Language: Dockerfile, Shell
- Framework: Docker
- Build: Docker build
- Key dependencies: Docker

## Architecture
Collection of Dockerfiles and configurations organized by tool:
- `docker-baseimages/` - Alpine and Debian JDK images (Java 8, 9)
- `nexus/` - Nexus Maven repository
- `jenkins/` - Jenkins CI server
- `sonarqube/` - SonarQube code quality
- `greylog2/` - Graylog log management
- `parentpom/` - Shared Maven parent POM

## Key Entry Points
- `docker-baseimages/` - JDK base images for Docker deployments
- `nexus/` - Maven artifact repository setup
- `parentpom/` - Cantara shared parent POM

## Development
```bash
# Build a base image
cd docker-baseimages/alpine-zulu-jdk9
docker build -t cantara/alpine-zulu-jdk9 .
```

## Domain Context
Development infrastructure and DevOps tooling. Provides the foundational Docker images, artifact repositories, and CI/CD tools used across the Cantara ecosystem.
