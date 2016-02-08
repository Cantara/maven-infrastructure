#!/bin/sh

docker build -t cantara/openjdk8 .
docker run --rm -it cantara/openjdk8 sh -c "java -version; cat /etc/os-release"

