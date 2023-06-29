######docker commands
##To check docker version
$ docker version
	or
$ docker info
##docker root document
$ cd  /var/lib/docker
##Docker images store area
$ ll /var/lib/docker/image/overlay2/imagedb/content/sha256
  	-here display images id
##To check docker images in server
$ docker images
##pull docker images from docker hub
$ docker pull <docker_image_name:version>
$ docker pull nginx:latest
##To run docker container
$ docker run <container_image_name:version>
$ docker run centos:latest
$ docker run -itd centos:centos-7.5.1 /bin/bash
     -i--interactive mode
     -t--terminal (user able to connect terminal)
     -d--detached mode(background)
$ docker run -it centos:centos-7.5.1 /bin/bash
  	 -it will login to docker container 
  	#for exit from docker container enter exit commands
##To set name for container 
$ $ docker run -itd --name <container_label_name> <docker_image_name:version>
$ docker run -itd --name webserver <docker_image_name:version>
##To assign container name, hostname, memory, and cpu for docker container from ou
$ docker run --name webserver -it --hostname "web.cntech.local" -m 300M -c 256 --memory-swap 600M nginx /bin/bash
  	--name=webserver is label of container
##To port mapping(random port) to container
$ docker run -itd -P <docker_image_name:version>
$ docker run -itd -P centos
	-P(capital) it give randomly port for container
##Assign fixed port for container  
$ docker run -itd -p 8080:80  --name webserver nginx:latest
	-p(small letter) 8080(hostport) and 80(container port)
##To view the port mapped to the container
$ docker port <conatiner_id or conatiner_label>
##To copy file from server to docker container
$ docker cp /home/index.hmtl  <container_id:specfic_path>
$ docker cp /home/index.html 53fgc:/usr/share/nginx/html/
##To copy file from  docker container to server host
$ docker cp  <container_id:specfic_path> <server_host_path>
$ docker cp  53fgc:/usr/share/nginx/html/ .
 	 -.(dot) means present working directory
##To connect to container
$ docker attach <conatiner_id>
$ docker attach 63gcs
$ exit 
 	 -if you enter exit command it will stop container 
 	 -if you enter `press ctrl+p+q` it will not stop the container and it only exit from the container.
##To connect to container
$ docker exec -it <conatiner_id> /bin/bash or bash
 	 -if you enter the exit command it will only exit from the container and not  stop the container. 
 	 -Here using /bin/bash that why whenever we use exit it will not stop the conatiner.it will only exit from container  
##To check current running docker containers 
$ docker ps
##To check current running and stopped docker containers
$ docker ps -a
##To display only running container id 
$ docker ps -q
##To display running and stopped container id 
$ docker ps -aq
##To start the stopped  docker containers  
$ docker start <container_id>
$ docker start  521a
##To check docker all and networking details.
$ docker  inspect <container_id>
$ docker inspect  521a
##To stop  docker container
$ docker stop <container_id>
$ docker stop  521a
##To unpause  the docker container
$ docker unpause <container_id>
$ docker unpause  521a
##To pause  the docker container
$ docker pause <container_id>
$ docker pause  521a
##To stop all  docker containers at time 
$ docker stop $(docker ps -aq)
##To remove the stop containers
$ docker container prune
 - It will remove all stop container
##To start all  docker containers at time 
$ docker start $(docker ps -aq)
##To remove only stopped all  docker containers at time 
$ docker rm $(docker ps -aq)
##To remove  stopped and current running all  docker containers at time 
$ docker rm $(docker ps -aq) -f
##To remove only  the stopped  docker containers
$ docker rm <container_id>
$ docker rm  521a
##To remove  the stopped and current running  docker containers forcefully
$ docker rm <container_id> --force
###To remove   docker container images 
$ docker rmi <docker_image_name:version>
$ docker rmi nginx:latest
##To remove container after stopping the container
$ docker run -itd --rm nginx
##To run container and run after exit command
$ docker run --restart=always -itd centos
##import running docker  container 
$ docker import <container_id>  > <base_image_name.tar>
$ docker import 301851ffcd > my_centos_git_tree.tar
$ docker import 301851ffcd -o  my_centos_git_tree.tar
$ docker image import <base_image_name.tar> <store_in_localrepository>
##create docker image from running container
$ docker container commit --author "dhana" -m "this my first commit" <conatiner_id>  <base_image_name>
$ docker container commit --author "dhana" -m "this my first test commit" 301851ffcd   my_test_centos
##Tag the docker image name for push to docker-hub.
$ docker image tag my_test_centos dhanapal406/centos-7.5
##push the image to docker hub
$ docker push <docker_tag_image>
$docker push dhanapal406/centos-7.5
## We can give name of  repository and tag
$ docker commit <conatiner_id>  <repository:tag>
$ docker commit  2b62    production:webserver
##To save image as tar file(docker save)
$ docker save production:webserver > /tmp/production.tar
         OR
$ docker save -o /tmp/production.tar production:webserver

##To unzip the image from tar(docker load command)
$ docker load -i /tmp/production.tar
$ docker images
##Docker file
Dockerfile is used to create docker image
##In Dockerfile elements
1.FROM--It sets the base image for sub-squenent instruction
2.LABEL--It adds the metadata
3.ENV--It is used to sets the environment variable.
4.RUN--It will execute any command where docker images are created.
5.WORKDIR--It set the workdir directory or WORKDIR instruction is used to set the working directory for all the subsequent Dockerfile instructions
6.USER--It set username or user-id
7.ADD--It copy the file and directory or remote file urls. It extracts the archive file automatically.
8.COPY--It copy the file and directory .It impossible to specific  remote file urls. It will not extract the archive file automatically.
9.EXPOSE--The EXPOSE instruction exposes a particular port with a specified protocol inside a Docker Container.
10.CMD--CMD sets default command and/or parameters, which can be overwritten from command line when docker container runs. 
11.ENTRYPOINT--ENTRYPOINT command and parameters will not be overwritten from command line
12.VOLUME--It creates a mount point with this specific name and marks it holding external mount volume from docker host(server host).
Example(Dockerfile):
1.$ vim Dockerfile
FROM centos:latest
LABEL name="dhana"
LABEL email="dhanapal70328@gmail.com"

## adding environment variable
ENV name dhana
ENV  password ikt
RUN yum install -y  httpd
ADD  /home/index.html /var/www/html/
WORKDIR /var/www/html
RUN systemctl start httpd
RUN systemctl enable httpd
RUN  useradd dhana
EXPOSE 80
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]
:wq

##To reduce the file size of Dockerfile while creation
2.$ vim Dockerfile
FROM centos:latest
LABEL name="dhana"
LABEL email="dhanapal70328@gmail.com"
## adding environment variable
ENV name dhana
ENV  password ikt
RUN yum install -y  httpd
ADD  /home/index.html /var/www/html/
WORKDIR /var/www/html
RUN systemctl start httpd \
   && systemctl enable httpd \
   && systemctl status httpd  \
   && useradd dhana
EXPOSE 80
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]
:wq
Note:--The major difference between both Dockerfile we not repeting the run command in 2nd Dockerfile with the 2nd Dockerfile size will be reduce and less layer of docker image will created.
###To Build the Dockerfile has docker image
$ docker build --tag <tag_name:version> .
   -t--tag_name
## Change tag name of docker image
$ docker image tag  <old_image_name> <new_image_name>
$ docker image tag nginx:latest 127.0.0.1:5000/nginx:latest
##To push image to  local repository
$ docker push 127.0.0.1:5000/nginx:latest
#check docker image  of Dockerfile
$ docker images
##difference between CMD and RUN
RUN is used at the time of building an image and CMD is used to run a command when a container starts.
#Create docker volume
$ docker volume ls
$ docker volume create mysql-data
##Attached the create volume to docker container
$docker run -itd -p 3306:3306 -e 	MYSQL_ROOT_PASSWORD='Password' -v mysql-data:/var/lib/mysql -itd mysql:5.6
  -v--volume attached to the docker container
##To known the docker volume  details 
$ docker volume inspect <volume_name>
$ docker volume inspect wordpress-data

##Types of docker volume
1.Host volumes
A host volume can be accessed from within a Docker container and is stored on the host, as per the name. To create a host volume, run:
bind mount: note that the host path should start with ‘/’. Use $(pwd) for convenience.
EX:-
$ docker run -v </path/on/host_server:/path/in/container>
2.unnamed volume
creates a folder in the host with an arbitrary name
$ docker container run -v /container-path image-name  
3. named volume
should not start with ‘/’ as this is reserved for bind mount. ‘volume-name’ is not a full path here. the command will cause a folder to be created with path “/var/lib/docker/volume-name” in the host.
$ docker container run -v  <volume-name:container-path image-name> 
########################################
1.$ vim Dockerfile
FROM ubuntu:latest
LABEL name="dhana"
LABEL email="dhanapal70328@gmail.com"
## adding environment variable
ENV name dhana
ENV  password ikt
RUN yum install -y  httpd
ADD  /home/index.html /var/www/html/
WORKDIR /var/www/html
RUN systemctl start httpd
RUN systemctl enable httpd
RUN  useradd dhana
EXPOSE 80
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]
:wq
################multi stage dockerfile##############
$ vim Dockerfile-1

# Copies in our code and runs NPM Install
FROM node:latest as builder
WORKDIR /usr/src/app
COPY package* ./
COPY src/ src/
RUN [“npm”, “install”]

# Lints Code
FROM node:latest as linting
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/ .
RUN [“npm”, “lint”]

# Gets Sonarqube Scanner from Dockerhub and runs it
FROM newmitch/sonar-scanner:latest as sonarqube
COPY --from=builder /usr/src/app/src /root/src

# Runs Unit Tests
FROM node:latest as unit-tests
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/ .
RUN [“npm”, “test”]

# Runs Accessibility Tests
FROM node:latest as access-tests
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/ .
RUN [“npm”, “access-tests”]

# Starts and Serves Web Page
FROM node:latest as serve
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/dest ./
COPY --from=builder /usr/src/app/package* ./
RUN [“npm”, “start”]
:wq
##build the image
 $docker build  -t  dhana:v1 -f Dockerfile-1 .

###Scan the docker image  for vulnerability test
##url for references
#https://aquasecurity.github.io/trivy/v0.27.1/docs/vulnerability/examples/report/

$ trivy image  <docker image>

##HTML format output
$ trivy image --format template --template "@contrib/html.tpl" -o report.html golang:1.12-alpine

##The following example shows use of default HTML template when Trivy is installed using rpm.
$ trivy image --format template --template "@/usr/local/share/trivy/templates/html.tpl" -o report.html golang:1.12-alpine

##################docker shared voulme################
sharable Docker volumes
============================
These volumes are sharabale between multiple containers

Create 3 centos containers c1,c2,c3.
Mount /data as a volume on c1 container ,c2 should use the volume
used by c1 and c3 should use the volume used by c2

1 Create a centos container c1 and mount /data
  docker run --name c2 -it -v /data centos

2 Go into the data folder create files in data folder
  cd data
  touch f1 f2

3  Come out of the container without exit
   ctlr+p,ctlr+q

4 Create another centos container c2 and it should used the voluems used by c1
  docker run --name c2 -it --volumes-from c1 centos
 
5 In the c2 container go into data folder and create some file
  cd data
  touch f3 f4

6 Come out of the container without exit
   ctlr+p,ctlr+q

7 Create another centos container c3 and it should use the volume used by c2
  docker run --name c3 -it --volumes-from c2 centos

8 In the c3 container go into data folder and create some file
  cd data
  touch f5 f6

9 Come out of the container without exit
   ctlr+p,ctlr+q

10 Go into any of the 3 contianers and we will see all the files
   docker attach c1
   cd /data
  ls
  exit

12 Identify the location the where the mounted data is stored
   docker inspect c1
   Search for "Mounts" section and copy the "Source" path

13 Delete all containers
   docker rm -f c1 c2 c3

14 Check if the files are still present
   cd "source_path_from" step12
   
   
================
WORKDIR /usr/local
RUN wget http://www-us.apache.org/dist/tomcat/tomcat-9/v9.0.24/bin/apache-tomcat-9.0.24.tar.gz \
    && tar -xvf apache-tomcat-9.0.24.tar.gz \
    && mv apache-tomcat-9.0.24 tomcat9 \
	&& useradd -r tomcat \
	&& chown -R tomcat:tomcat /usr/local/tomcat9 \
	&& ls -l /usr/local/tomcat9 
EXPOSE 8080
CMD ["catalina.sh" "run"]