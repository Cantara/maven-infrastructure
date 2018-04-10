### Minimal Ubuntu distribution with JDK 10

From https://github.com/Blitznote/debase

```
sudo docker pull cantara/debase-openjdk-jdk10
sudo docker run -it cantara/debase-openjdk-jdk10 java -version
```
 And have some fun

```
sudo docker run -it cantara/debase-openjdk-jdk10 jshell  ### Start the new REPL jshell (Project Kulla)
```
