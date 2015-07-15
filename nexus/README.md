# Nexus Artifact Repository 

Goal: Simplify installation and configuration of Nexus artifact repository. 

See https://registry.hub.docker.com/u/sonatype/nexus/ for tips, most of it is applicable to this fork as well. 

* Data is stored in a Data Volume Container. Latest Maven 3 and Zulu JDK 8 are preinstalled. 
* Nexus OSS: 2.11.3-01 
* Webproxy (incl. TLS termination) is considered out of scope. Recommend using a separate docker container which links to this container. 
  * https://docs.docker.com/userguide/dockerlinks/ 

## Install and use 

### Install or upgrade Docker 

https://docs.docker.com/installation/ubuntulinux/

```
wget -qO- https://get.docker.com/ | sh
```

###  Install data volume container and Nexus
```
sudo docker pull cantara/nexus
sudo docker create -v /sonatype-work --name nexus-data cantara/nexus
sudo docker run -d -p 80:8081 --volumes-from nexus-data --name nexus20150708 cantara/nexus
```

### Test that service is running 
```
curl http://localhost:80/service/local/status
```


### Initial config, point your browser to http://localhost:80/
1. Review Post-Install Checklist and configure as appropriate 
  * http://books.sonatype.com/nexus-book/reference/install-sect-repoman-post-install.html
2. Set up users and roles 
  * https://wiki.cantara.no/display/sysadm/Artifact+repository+user+and+role+management


### Copy data from host into data volume container 
Nexus container must be running. 
Copy everything inside /path/to/hostdir/ into /sonatype-work/storage/ in container (which is a mounted data volume container). 
Change owner to nexus. 
Verify that everything looks like expected.

```
cd /path/to/hostdir
tar -cv * | sudo docker exec -i nexus20150714 tar x -C /sonatype-work/storage/
sudo docker exec -i nexus20150714 chown nexus:nexus -R /sonatype-work/storage/
sudo docker exec -it nexus20150714 ls -la /sonatype-work/storage
```

* After copying repositories, add new hosted repositories matching the name of the copied folders. 
  * https://books.sonatype.com/nexus-book/reference/config-sect-new-repo.html
* Then add a scheduled task 'Rebuild Maven Metadata Files' and run it. It is not necessary to schedule it very often. Perhaps nightly or once a week.. 
  * http://blog.sonatype.com/2009/09/nexus-scheduled-tasks/#.VaUTSZO1mAk



## Backup 

See https://docs.docker.com/userguide/dockervolumes/#backup-restore-or-migrate-data-volumes


## Development 

### Build and run for development

```
sudo docker build -t cantara/nexus .
sudo docker create -v /sonatype-work --name nexus-data cantara/nexus
sudo docker run -d -p 8081:8081 --name nexus20150714 --volumes-from nexus-data cantara/nexus
```

* To stop and remove all containers: 
```
sudo docker stop $(sudo docker ps -a -q) && sudo docker rm $(sudo docker ps -a -q)
```

* To log in to take a look: 
```
sudo docker ps -a
sudo docker exec -it containerIdHere bash
```
