### What is Zulu? Zulu Duke in a Box

Zulu is a widely available binary distribution of OpenJDK. Zulu distributions are fully tested and compatibility verified builds of the latest versions of the OpenJDK 9, 8, 7, and 6 platforms. Zulu is available free of charge for Linux, Windows, and MacOS platforms, with commercial support available upon request.

Zulu is built, tested, supported and made available by Azul Systems.

http://www.azul.com/zulu

This is a stripped down docker image with the Zulu Open JDK 8 TCK verified distribution using the Alpine Linux distribution so it is one of the smallest JDK8 Docker distributions in the world.

[![](https://images.microbadger.com/badges/version/cantara/alpine-zulu-jdk8.svg)](http://microbadger.com/images/cantara/alpine-zulu-jdk8 "Get your own version badge on microbadger.com")

```
sudo docker pull cantara/alpine-zulu-jdk8
sudo docker run -it cantara/alpine-zulu-jdk8 java -version
```

