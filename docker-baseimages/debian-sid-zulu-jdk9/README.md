### What is Zulu? Zulu Duke in a Box

Zulu is a widely available binary distribution of OpenJDK. Zulu distributions are fully tested and compatibility verified builds of the latest versions of the OpenJDK 9, 8, 7, and 6 platforms. Zulu is av
ailable free of charge for Linux, Windows, and MacOS platforms, with commercial support available upon request.

Zulu is built, tested, supported and made available by Azul Systems.

http://www.azul.com/zulu

This is a stripped down docker image with the Zulu Open JDK 9 early preview using the Deboan Linux distribution.


```
sudo docker pull cantara/debian-sid-zulu-jdk9
sudo docker run -it cantara/debian-sid-zulu-jdk9 -version
```

