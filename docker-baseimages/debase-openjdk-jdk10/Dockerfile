FROM blitznote/debase:17.10
MAINTAINER bard.lind@gmail.com

RUN curl -O https://download.java.net/java/GA/jdk10/10/binaries/openjdk-10_linux-x64_bin.tar.gz
RUN tar xzvf openjdk-10_linux-x64_bin.tar.gz 
RUN ls
RUN mkdir /usr/lib/jvm
RUN chpst -u root mv jdk-10 /usr/lib/jvm/java-10-openjdk-x64/
RUN rm openjdk-10_linux-x64_bin.tar.gz
ENV PATH="/usr/lib/jvm/java-10-openjdk-x64/bin:${PATH}"

RUN chpst -u root update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-10-openjdk-x64/bin/java 1
RUN chpst -u root update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-10-openjdk-x64/bin/javac 1
RUN java -version
