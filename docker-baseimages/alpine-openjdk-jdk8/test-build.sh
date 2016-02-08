#!/bin/sh

docker build -t cantara/alpine-openjdk-jdk8 .
docker run --rm -it cantara/alpine-openjdk-jdk8 sh -c "java -version; cat /etc/os-release"

