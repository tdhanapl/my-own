###Scan the docker image  for vulnerability test
##url for references
#https://aquasecurity.github.io/trivy/v0.27.1/docs/vulnerability/examples/report/

$ trivy image  <docker image>

##HTML format output
$ trivy image --format template --template "@contrib/html.tpl" -o report.html golang:1.12-alpine

##The following example shows use of default HTML template when Trivy is installed using rpm.
$ trivy image --format template --template "@/usr/local/share/trivy/templates/html.tpl" -o report.html golang:1.12-alpine
##Docker tar files 
$ docker save ruby:2.3.0-alpine3.9 -o ruby-2.3.0.tar
$ trivy image --input ruby-2.3.0.tar

###Scan the yaml configuration files 
$ trivy conf <file path>
$ trivy conf ./configs

#Remote Private Container Registry
$ trivy https://hub.docker.com/repository/docker/dhanapal406/tomcat_sai-14:latest

##Remote Git Repository
$trivy repo https://github.com/csenapati12/java-tomcat-maven-docker.git