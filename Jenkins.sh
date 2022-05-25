#######################Configuration ##############################
###Home directory for jenkins
By default, Jenkins stores all of its data in this directory on the file system
$ ll /var/lib/jenkins

###############Reverse Proxy with nginx for jenkin url access########
#set hostname with FQDN
$ hostnamectl set-hostname jenkins.cntech.local
$ echo `hostname -i | awk '{print $NF}'`" "`hostname`" "`hostname -s ` >> /etc/hosts
##now install nginx 
$ yum install nginx
 # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }
	-------------remove above line the in above configuration file 
	------starting from server line to last flower bracket }
:wq!
##create new file in /etc/nginx/conf.d/jenkins-proxy.conf
$ vim /etc/nginx/conf.d/jenkins-proxy.conf
#########
####reverse proxy configuration link
#https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/
upstream jenkins {
    #server <server-ip-address:8080>;
	server 35.154.4.51:8080; 
}
server {
    listen       80 default;
    server_name   jenkins.cntech.local; # replace 'jenkins.cntech.local' with your server domain name
	
	access_log   /var/log/jenkins.access.log;
	error_log   /var/log/jenkins.error.log;
location / {
    proxy_buffers 16 4k;
    proxy_buffer_size 2k;
    proxy_set_header Accept-Encoding "";
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_pass http://jenkins;

	}
}

:wq!
##To check configuration reverse proxy syntax error
$  nginx -t
$ systemctl restart nginx
###################Periodic Backup(plug-in)###############
#Backup plugin allows archiving and restoring your Jenkins (and Hudson) home directory.
#With Periodic Backup we schudle cron jobs for backup perpouse
->Now go to jenkins 
->manage jenkins->manage plugins->Periodic Backup(search available)->Periodic Backup(select)->install(without restart)
->now to go jenkins server create a directory for storing jenkins backup data.
$ mkdir /opt/backup-jenkins-data
$chown -R jenkins:jenkins /opt/backup-jenkins-data
->Again to manage jenkins->configure system->Periodic Backup Manager->click here to configure it->
->Root Directory=/var/lib/jenkins
->Temporary Directory=/tmp
->Backup schedule (cron)=30 * * * * (every day  30 minutes)
->Maximum backups in location=20
->Store no older than (days)=15
->File Management Strategy= ConfigOnly/FullBackup
->Storage Strategy=TarGzStorage
->Backup Location=/opt/backup-jenkins-data
->mark enable this location
->click validate
->clik save
###For taking backup 
-> click Backup Now
###For restore backup  
##if any important job deletd means we can restore with this 
-> click restore
############### Securirty########
->Now go to jenkins 
->manage jenkins->manage plugins->Role-based Authorization Strategy(search available)->Role-based Authorization Strategy(select)->install(without restart)

############LDAP configuration in jenkins##############
##server LDAP configuration details (deatils for configure LDAP in jenkins###
objectClass: top
objectClass: dcObject 
objectClass: organization
o: example.com
dc: example.com
structuralobjectClass: organization
entryUID: bies4684-739-1036-8256-33433ee5d363
creatorsName: cn=admin,dc=example,dc=com
createTimestamp: 202187210636232
Security Realm createTimestamp: 287187216636737
entryCSN: 20210721053623,32521320000000000000000
modifiersName: cn=admin,dc=example,dc=com
modifyTimestamp: 282187210636232

dn: cn=admin,dc=example,dc=com
objectClass simpleSecurityObject 
objectClass: organizationalRole
cn: admin
description: LOAP administrator
user Password: #INTSEF3atybJZOM VZVVFZIU
structuralObjectClass: organizationalRole
entryUID: bies4684-739-1036-8256-33433ee5d363
creatorsName: cn=admin,dc=example,dc=com
entryUID: bies4684-739-1036-8256-33433ee5d363
createTimestamp: 202187210636232 
entryCSN: 20210721053623,32521320000000000000000
modifierstime: cn=admin,dc=example,dc=com 
modifyTimestamp: 202107210636732
------------------
#Authentication(LDAP configuration)
->Security Realm=LDAP
Server
->Server= 172.13.43.20:389(Syntax of server field is SERVER or SERVER:PORT or ldaps://SERVER[:PORT])
->root DN= dc=example,dc=com(Allow blank rootDN)
->User search base= OU=people
->User search filter= uid={0}
->Group search base= OU=groups
-> Group search filter= empty (leave default)
->Group membership
Parse user attribute for list of LDAP groups/Search for LDAP groups containing user
-> mark Search for LDAP groups containing user
->Group membership filter= ((member={0})(uniqueMember={0})(memberUid={1}))
->Manager DN= cn=admin,dc=example,dc=com
->Manager Password= LDAP password
->Display Name LDAP attribute= cn <displayname>
->Email Address LDAP attribute= mail
-> Environment Properties--leave default
-> click test LDAP user-> username= dhana->password=dhan@1234
-> mark Disable Ldap Email Resolver
-> mark Disable Backward Compatibility for Roles
->click save
-> click apply
##Now go to jenkins  for security
->manage jenkins->click Configure Global Security
->Authorization= Role-Based Strategy
->click save
-> click apply
->now again manage jenkins
->under Security
-> click Manage and Assign Roles 
->click Manage Roles
->Role to add= devops
->click add
->again Role to add= devolper
->click add
-> here dispaly two user mark the required permission for the user

########################################Installation  maveen##############################
wget https://dlcdn.apache.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz
tar -xzvf apache-maven-3.8.4-bin.tar.gz
mkdir maveen
mv apache-maven-3.8.4-bin  maveen
cd maveen
cd bin
echo $PATH
cd 
vim .profile
export M2_HOME=/opt/maven/bin
export PATH=$PATH:$M2_HOME
:wq!
mvn --version
cd /maveen/bin/
./mvn archetype:generate
mvn archetype:generate -DarchetypeArtifactId=maven-archetype-application

#####################Integrate Your GitHub Repository to Your Jenkins Project##################################
Configuring GitHub
Step 1: go to your GitHub repository and click on ‘Settings
Step 2: Click on Webhooks and then click on ‘Add webhook’.
Step 3: In the ‘Payload URL’ field, paste your Jenkins environment URL. At the end of this URL add /github-webhook/. 
In the ‘Content type’ select: ‘application/json’ and leave the ‘Secret’ field empty.
Step 4: In the page ‘Which events would you like to trigger this webhook?’ choose ‘Let me select individual events.’ Then, check ‘Pull Requests’ and ‘Pushes’. 
At the end of this option, make sure that the ‘Active’ option is checked and click on ‘Add webhook’.
###Configuring Jenkins

Step 5: In Jenkins, click on ‘New Item’ to create a new project.
Step 6: Give your project a name, then choose ‘Pipeline’ and finally, click on ‘OK’.click pipeline project->click build trigger-
------->mark github hook trigger for GITSCM polling----->click apply.


################################Jenkins master--Slave configuration######################
1. adding agent with Launch method via Launch agents via SSH

->In a production environment, there are lot and lot of builds need to run in parallel. This is the time Jenkins slave nodes come into the play. We can run builds in separate Jenkins slave nodes. This will reduce build overhead to the Jenkins master and we can run build in parallel. This article contains in the step by step guide to add Jenkins slave node. This step by step guide will help you to add any flavour of Linux machine as a Jenkins slave node. If you haven’t still install Jenkins Master server read this article “Install Production Jenkins on CentOS 7 in 6 Steps”.
Prepare Slave nodes
->Before adding a slave node to the Jenkins master we need to prepare the node. We need to install Java on the slave node. Jenkins will install a client program on the slave node. To run the client program we need to install the same Java version we used to install on Jenkins master. I am going to use this slave node to build Java Maven project. Therefore I need to install Maven as well. According to your production environment, you need to install and configure the necessary tool in the slave node.
->Install OpenJDK 8 on the slave node.
# sudo yum install -y java-1.8.0-openjdk
->As mention above, now I am going to install apache maven on the slave node. You can download the Apache Maven from their official site.
# mkdir -p build/software/maven/
# wget https://www-eu.apache.org/dist/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.tar.gz --directory /home/centos/build/software/maven/
# tar -xvf /home/centos/build/software/maven/apache-maven-3.6.2-bin.tar.gz --directory /home/centos/build/software/
$Configure ssh connectivity to slave node from master
Log in to the Jenkins master node and create an ssh key-pair. Use the below command to create the key-pair
# ssh-keygen
#cat .ssh/id_rsa.pub
Now to slave node copy of master node .ssh/id_rsa.pub to slave node .ssh/authorized_keys
Copy the content and log in to the slave node. Add the copied content to authorized_keys.
# vim .ssh/authorized_keys
->From the master ssh to the slave node. It will ask to accept the ssh fingerprint, type yes and enter. If you haven’t done anything wrong you should be able to ssh into the slave node.
Adding the slave node to the master
->Log in to the Jenkins console via the browser and click on "Manage Jenkins" and scroll down to the bottom. From the list click on "Manage Nodes". In the new window click on "New Node".
->Add new node
->Give a name to the node, select "Permanent Agent" and click on OK
->Jenkins Slave Node name
->In the remote root directory field enter a path in the slave node. Note that ssh user must have read/write access to this directory path. Here I use the ssh uses home directory.
->Enter the slave nodes IP address in the field.
->Set IP and cre
->Click on the "Add" button near the credentials field. Jenkins will popup a new window to add credentials. Select the kind as "SSH Username with private key" from the drop-down. Enter the user name of the slave node. In the private key field add the Jenkins masters private key. You can find the private key with the below command,
->Add new credentials to the Jenkins
#cat /home/centos/.ssh/id_rsa
->Click on add and select the credentials we created from the drop-down. Click on save. If you did all the correct slave node will come to live state within a few seconds.
->Slave node list
->Troubleshooting
->You can click on the slave node and from there you can view the log. Fix any error shown in the log
2. ########Configure Clouds agent(EC2 instance)
->Now go to jenkins 
->click manage jenkins->manage plugins->Amazon ec2 instance, docker and kubernetes (search available)->Amazon ec2 instance, docker and kubernetes (select)->install(without restart)
###Now go aws console for create IAM group and user assigned AmazonEC2FullAccess policy
1.create group jenkins
2.add permission (AmazonEC2FullAccess) to jenkins group
3.create IAM user dhanapal user->download access key and secret key
4.click add dhanapal user to jenkins group
###Now create keypair 
1.click create keypair 
2. select  .pem
3.click save 
->now again click manage jenkins
->click Manage nodes and clouds
->click Configure Clouds
->select Amazon EC2
->Name= ec2-agent
->Amazon EC2 Credentials->click add (jenkins)->
->Add Credentials
->Domain= Global credentials (unrestricted)
->Kind= AWS Credentials
->Scope= Global (Jenkins, nodes, items, all child items, etc)
->ID= AWS-KEYS
->Description= AWS-KEYS
->Access Key ID= AKIA4PNPSPCJNBYNPM4Z (acess key IAM role of dhanapal)
->Secret Access Key= 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
->IAM Role Support->click advance
->IAM Role To Use=
->External Id To Use=
->MFA Serial Number=
->MFA Token= 
->STS Token Duration= 3600
->click add
->Use EC2 instance profile to obtain credentials (leave default=unmark)
->Alternate EC2 Endpoint(leave deafult)
->Region= ap-south-1 (select your wish of region)
->EC2 Key Pairs Private Key->click add (jenkins)->
->Add Credentials
->Domain= Global credentials (unrestricted)
->Kind= SSH Username with private key
->Scope= Global (Jenkins, nodes, items, all child items, etc)
->ID= AWS-KEYS
->Description= AWS-KEYS
->ID= ec2private-keys
->Description= ec2private-keys
-.Username= ec2-user
->mark Treat username as secret
->Private Key->Enter directly->Key(add the pem key )
->click add
click test connection --here display sucess
->click AMIs (List of AMIs to be launched as agents)
->Description= AWS-Ec2-ap-south-1a
->AMI ID= ami-06a0b4e3b7eb7a300
->AMI Owners= leave default
->AMI Users= leave deafult
->AMI Filters= leave defult
->Instance Type= T2micro
->EBS Optimized, Monitoring, T2 Unlimited (leave deafult =unmark)
->Availability Zone
->vailability Zone=ap-south-1a
->Spot configuration (unmark )
->Security group names= sg-0684a74fe71f043b5
->Remote FS root= /home/redhat
->Remote user= redhat
->AMI Type= unix
->Root command prefix= sudo
->Agent command prefix= (leave deafult)
->Agent command suffix= (leave deafult)
->Remote ssh port= 22
->Boot Delay= (leave deafult)
->Labels= aws-jenkins-agent
->Usage= Only build jobs with label expressions matching this node
->Idle termination time= 25 (it delete after 25 minutes and idle time is 25 minutes )
->Init script= yum install git -y 
			   yum install maven -y 
		    yum install  java-1.8.0-openjdk -y 
->click advance
->Number of Executors= 2
->VM Options= leave deafult
->Stop/Disconnect on Idle Timeout = leave deafult
->Subnet IDs for VPC= subnet-0913f861258ec54fc
->Tags
->EC2 Tag/Value Pairs
->Minimum number of instances= 0
->Minimum number of spare instances= 0
-> Only apply minimum number of instances during specific time range= leave deafult
->Instance Cap
->IAM Instance Profile
->Delete root device on instance termination
->Use ephemeral devices
->Encrypt EBS root volume
->Based on AMI
->Block device mapping
->Launch Timeout in seconds
->Associate= Public IP
->Tenancy= Default
->Connection Strategy= Public IP
-> mark Connect by SSh
->click apply
->click save
############################################SonarQube intergration with jenkins################################################################
do not all this things with root and created separate username as sonaruser
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.6.50800.zip
apt install unzip 
unzip sonarqube-8.9.6.50800.zip
ls -lrt
cd sonarqube-8.9.6.50800
ls	-lrt
cd conf/
ls -lrt
vi sonar.properties
sonar.jbc.username=sonarqube
sonar.jbc.password=sonarqube
#sonar.embeddedDatabase.port=we are database port mysql or postgreql
#web server
sonar.web.host=0.0.0.0
sonar.web.port=9000
sonar.web.context=/sonarqube
:wq
vi wrapper.conf
wrapper.java.command=/usr/lib/jvm/java-8-openjdk-amd64/bin/java
:wq
cd bin 
cd linux-x86-64
ls -lrt
./sonar.sh console
go website
->this url=3.104.45.3:9000/sonarqube
 uersname=admin default
 password=admin default
 oldpassword=admin
 newpassword=dhana@406
 confirm password=dhana@406
 ->Now go to jenkins 
 ->manage jenkins->manage plugins->sonarqube(search available)->sonarqube scanner(select)->install(without restart)
 Again to manage jenkins->configure system->SonarQube Server->mark Environment variables->Add SonarQube->Name=Sonarjenkins->
 -->Server Url=url=3.104.45.3:9000/sonarqube(SonarQube url)---
 now go to SonarQube server to create token
 click Administartor->security->users->click tokens->Generate tokens=jenkins->generate->copy that token
 Now goto jenkins continue to before part
 click add(jenkins credintaials)->domain =global credentails->kind=secret text(select)->secret=paste the copied sonarqube token->Descrition=jenkins->save---
 ->authication=Sonarjenkins->apply
 
#############################Jfrog Artifactory Installation###########################################################
##Installation Steps
#Pre-requisites:
->An AWS T2.small EC2 instance (Linux)
->Open port 8081 and 8082 in the security group
#Login to instance as a root user and install Java
yum install java-1.8* -y 
->Download Artifactory packages onto /opt/
->For refernces puporse of download link of Jfrog https://jfrog.bintary.com/artifactory/jfrog-artifactory-oss-6
cd /opt 
wget https://jfrog.bintray.com/artifactory/jfrog-artifactory-oss-6.9.6.zip
->extract artifactory tar.gz file

unzip jfrog-artifactory-oss-6.9.6.zip
->Go inside to bin directory and start the services
cd /opt/jfrog-artifactory-oss-6.9.6/bin
./artifactory.sh start
#Access artifactory from browser
->http://<PUBLIC_IP_Address>:8081 
# Provide credentials
username: admin
password: passwrod 
->Create new user 
->click admin->click user->click new->uersname=jenkins->email address=jenkins@gmail->mark admin previlage->mark can update profile->set-password=redhat

################################################Integrate Artifactory with Jenkins######################################
pre-requisites
->An Artifactory server 
->A Jenkins Server 
->Integration Steps
->Login to Jenkins to integrate Artifactory with Jenkins

->Install "Artifactory" plug-in
->Manage Jenkins -> Jenkins Plugins -> available -> artifactory-> select without restart.
->Configure Artifactory server credentials
->Manage Jenkins -> Configure System -> Artifactory
->Artifactory Servers
->Server ID : Artifactory-Server
->URL : <<<Artifactory Server URL>>>
->Username : jenkins
->Password : redhat
->click test connection->here found Artifactory version 

---------------------------------------Jenkins(CI continue intergration/Continue delivery CD)---------------------------------------------------
->source code commit--trigger automatically(web-hook)-->checkout(Git)-->Build(maveen)-->sonar analysis(SonarQube)-->test(junit)---------
->upload artifactory(nexus/jfrog)-->Deploy to pre-production(Docker Environment)---->Deploy to Production(Kubernetes).
pipeline {
    agent any
	tools {
        maven "maven123"
    }
    options {
        timeout(30)
		buildDiscarder(logRotator(numToKeepStr: '5'))
		
    }
	stages {
        stage('Checkout') {
			steps{
				checkout scm
				}
		}
		stage('Build'){
			steps{
				mvn clean install 
				}
			}
		stage('Scan') {
			steps {
				withSonarQubeEnv(installationName: 'sonarjenkins') { 
				sh './mvnw clean org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar'
        }
	    stage('create Image') {
            steps {
                sh """
                    docker build -t dhanapal406/tomcat-$BUILD_NUMBER .
                    docker login -u $DOCKER_LOGIN_USR -p $DOCKER_LOGIN_PSW
                    docker opt dhanapapush dhanapal406/tomcat-$BUILD_NUMBER
                    docker run -itd -p 8080:8080 -v /dhana:/l406/tomcat-$BUILD_NUMBER
                """
            }
        }
//	    stage('SonarQube analysis') {
//      def scannerHome = tool 'SonarScanner 4.0';
//        steps{
//       withSonarQubeEnv('sonarqube-8.9') { 
// If you have configured more than one global server connection, you can specify its name
//            sh "${scannerHome}/bin/sonar-scanner"
          sh "mvn sonar:sonar"
        }
        stage('Test') {
            steps {
                sh 'make check'
            }
        }
  
    post {
        always {
            junit '**/target/*.xml'
        }
        failure {
            mail to: team@example.com, subject: 'The Pipeline failed :('
        }
		sucess {
			mail to: dhanapal703278@gmail.com, subject: The Pipeline sucess 
		}
    }
}


####################################################Kubernetes command#############################
kubectl get pods  --all-namespaces
kubectl create deployment nginx --image=nginx
kubectl create service nodeport nginx --tcp=80:80
kubectl get svc
kubectl cluster-info
kubectl cluster-info dump
kubectl cluster-info dump --output-directory = /path/to/cluster-state
kubectl config current-context
Kubectl commands are used to interact and manage Kubernetes objects and the cluster. In this chapter, we will discuss a few commands used in Kubernetes via kubectl.

kubectl annotate − It updates the annotation on a resource.

$kubectl annotate [--overwrite] (-f FILENAME | TYPE NAME) KEY_1=VAL_1 ...
KEY_N = VAL_N [--resource-version = version]
For example,

kubectl annotate pods tomcat description = 'my frontend'
kubectl api-versions − It prints the supported versions of API on the cluster.

$ kubectl api-version;
kubectl apply − It has the capability to configure a resource by file or stdin.

$ kubectl apply –f <filename>
kubectl attach − This attaches things to the running container.

$ kubectl attach <pod> –c <container>
$ kubectl attach 123456-7890 -c tomcat-conatiner
kubectl autoscale − This is used to auto scale pods which are defined such as Deployment, replica set, Replication Controller.

$ kubectl autoscale (-f FILENAME | TYPE NAME | TYPE/NAME) [--min = MINPODS] --
max = MAXPODS [--cpu-percent = CPU] [flags]
$ kubectl autoscale deployment foo --min = 2 --max = 10
kubectl cluster-info − It displays the cluster Info.

$ kubectl cluster-info
kubectl cluster-info dump − It dumps relevant information regarding cluster for debugging and diagnosis.

$ kubectl cluster-info dump
$ kubectl cluster-info dump --output-directory=/path/to/cluster-state
kubectl config − Modifies the kubeconfig file.

$ kubectl config <SUBCOMMAD>
$ kubectl config –-kubeconfig <String of File name>
kubectl config current-context − It displays the current context.

$ kubectl config current-context
#deploys the current context
kubectl config delete-cluster − Deletes the specified cluster from kubeconfig.

$ kubectl config delete-cluster <Cluster Name>
kubectl config delete-context − Deletes a specified context from kubeconfig.

$ kubectl config delete-context <Context Name>
kubectl config get-clusters − Displays cluster defined in the kubeconfig.

$ kubectl config get-cluster
$ kubectl config get-cluster <Cluser Name>
kubectl config get-contexts − Describes one or many contexts.

$ kubectl config get-context <Context Name>
kubectl config set-cluster − Sets the cluster entry in Kubernetes.

$ kubectl config set-cluster NAME [--server = server] [--certificateauthority =
path/to/certificate/authority] [--insecure-skip-tls-verify = true]
kubectl config set-context − Sets a context entry in kubernetes entrypoint.

$ kubectl config set-context NAME [--cluster = cluster_nickname] [--user = user_nickname] [--namespace = namespace]
$ kubectl config set-context prod –user = vipin-mishra
kubectl config set-credentials − Sets a user entry in kubeconfig.

$ kubectl config set-credentials cluster-admin --username = vipin --password = uXFGweU9l35qcif
kubectl config set − Sets an individual value in kubeconfig file.

$ kubectl config set PROPERTY_NAME PROPERTY_VALUE
kubectl config unset − It unsets a specific component in kubectl.

$ kubectl config unset PROPERTY_NAME PROPERTY_VALUE
kubectl config use-context − Sets the current context in kubectl file.

$ kubectl config use-context <Context Name>
kubectl config view

$ kubectl config view
$ kubectl config view –o jsonpath='{.users[?(@.name == "e2e")].user.password}'
kubectl cp − Copy files and directories to and from containers.

$ kubectl cp <Files from source> <Files to Destinatiion>
$ kubectl cp /tmp/foo <some-pod>:/tmp/bar -c <specific-container>
kubectl create − To create resource by filename of or stdin. To do this, JSON or YAML formats are accepted.

$ kubectl create –f <File Name>
$ cat <file name> | kubectl create –f -
In the same way, we can create multiple things as listed using the create command along with kubectl.

deployment
namespace
quota
secret docker-registry
secret
secret generic
secret tls
serviceaccount
service clusterip
service loadbalancer
service nodeport

$ kubectl delete − Deletes resources by file name, stdin, resource and names.

$ kubectl delete –f ([-f FILENAME] | TYPE [(NAME | -l label | --all)])
$ kubectl describe − Describes any particular resource in kubernetes. Shows details of resource or a group of resources.

$ kubectl describe <type> <type name>
$ kubectl describe pod tomcat
$ kubectl drain − This is used to drain a node for maintenance purpose. It prepares the node for maintenance. This will mark the node as unavailable so that it should not be assigned with a new container which will be created.

$ kubectl drain tomcat –force
$ kubectl edit − It is used to end the resources on the server. This allows to directly edit a resource which one can receive via the command line tool.

$ kubectl edit <Resource/Name | File Name)
Ex.
$ kubectl edit rc/tomcat
$ kubectl exec − This helps to execute a command in the container.

$ kubectl exec POD <-c CONTAINER > -- COMMAND < args...>
$ kubectl exec tomcat 123-5-456 date
$ kubectl expose − This is used to expose the Kubernetes objects such as pod, replication controller, and service as a new Kubernetes service. This has the capability to expose it via a running container or from a yaml file.

$ kubectl expose (-f FILENAME | TYPE NAME) [--port=port] [--protocol = TCP|UDP]
[--target-port = number-or-name] [--name = name] [--external-ip = external-ip-ofservice]
[--type = type]
$ kubectl expose rc tomcat –-port=80 –target-port = 30000
$ kubectl expose –f tomcat.yaml –port = 80 –target-port =
$ kubectl get − This command is capable of fetching data on the cluster about the Kubernetes resources.

$ kubectl get [(-o|--output=)json|yaml|wide|custom-columns=...|custom-columnsfile=...| go-template=...|go-template-file=...|jsonpath=...|jsonpath-file=...]
(TYPE [NAME | -l label] | TYPE/NAME ...) [flags]
For example,

$ kubectl get pod <pod name>
$ kubectl get service <Service name>
$ kubectl logs − They are used to get the logs of the container in a pod. Printing the logs can be defining the container name in the pod. If the POD has only one container there is no need to define its name.

$ kubectl logs [-f] [-p] POD [-c CONTAINER]
Example
$ kubectl logs tomcat.
$ kubectl logs –p –c tomcat.8
$ kubectl port-forward − They are used to forward one or more local port to pods.

$ kubectl port-forward POD [LOCAL_PORT:]REMOTE_PORT [...[LOCAL_PORT_N:]REMOTE_PORT_N]
$ kubectl port-forward tomcat 3000 4000
$ kubectl port-forward tomcat 3000:5000
$ kubectl replace − Capable of replacing a resource by file name or stdin.

$ kubectl replace -f FILENAME
$ kubectl replace –f tomcat.yml
$ cat tomcat.yml | kubectl replace –f -
$ kubectl rolling-update − Performs a rolling update on a replication controller. Replaces the specified replication controller with a new replication controller by updating a POD at a time.

$ kubectl rolling-update OLD_CONTROLLER_NAME ([NEW_CONTROLLER_NAME] --image = NEW_CONTAINER_IMAGE | -f NEW_CONTROLLER_SPEC)
$ kubectl rolling-update frontend-v1 –f freontend-v2.yaml
$ kubectl rollout − It is capable of managing the rollout of deployment.

$ Kubectl rollout <Sub Command>
$ kubectl rollout undo deployment/tomcat
Apart from the above, we can perform multiple tasks using the rollout such as −

rollout history
rollout pause
rollout resume
rollout status
rollout undo
$ kubectl run − Run command has the capability to run an image on the Kubernetes cluster.

$ kubectl run NAME --image = image [--env = "key = value"] [--port = port] [--replicas = replicas] [--dry-run = bool] [--overrides = inline-json] [--command] --[COMMAND] [args...]
$ kubectl run tomcat --image = tomcat:7.0
$ kubectl run tomcat –-image = tomcat:7.0 –port = 5000
$ kubectl scale − It will scale the size of Kubernetes Deployments, ReplicaSet, Replication Controller, or job.

$ kubectl scale [--resource-version = version] [--current-replicas = count] --replicas = COUNT (-f FILENAME | TYPE NAME )
$ kubectl scale –-replica = 3 rs/tomcat
$ kubectl scale –replica = 3 tomcat.yaml
$ kubectl set image − It updates the image of a pod template.

$ kubectl set image (-f FILENAME | TYPE NAME) CONTAINER_NAME_1 = CONTAINER_IMAGE_1 ... CONTAINER_NAME_N = CONTAINER_IMAGE_N
$ kubectl set image deployment/tomcat busybox = busybox ngnix = ngnix:1.9.1
$ kubectl set image deployments, rc tomcat = tomcat6.0 --all
$ kubectl set resources − It is used to set the content of the resource. It updates resource/limits on object with pod template.

$ kubectl set resources (-f FILENAME | TYPE NAME) ([--limits = LIMITS & --requests = REQUESTS]
$ kubectl set resources deployment tomcat -c = tomcat --limits = cpu = 200m, memory = 512Mi
$ kubectl top node − It displays CPU/Memory/Storage usage. The top command allows you to see the resource consumption for nodes.

$ kubectl top node [node Name]