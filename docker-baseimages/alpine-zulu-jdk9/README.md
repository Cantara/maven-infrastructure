### What is Zulu? Zulu Duke in a Box

Zulu is a widely available binary distribution of OpenJDK. Zulu distributions are fully tested and compatibility verified builds of the latest versions of the OpenJDK 9, 8, 7, and 6 platforms. Zulu is available free of charge for Linux, Windows, and MacOS platforms, with commercial support available upon request.

Zulu is built, tested, supported and made available by Azul Systems.

http://www.azul.com/zulu

This is a stripped down docker image with the Zulu Open JDK 9 early preview using the Alpine Linux distribution so it is one of the smallest JDK9 Docker distributions in the world.


```
sudo docker pull cantara/zulu9-minimal
sudo docker run -it cantara/zulu9-minimal java -version
```
 And have some fun

```
sudo docker run -it cantara/zulu9-minimal jshell  ### Start the new REPL jshell (Project Kulla)
```
