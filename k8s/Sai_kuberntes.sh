#####################For RBAC permission of kubernetes########################
##For checking user is having resource RBAC permission or not
$ kubectl auth can-i create pod --as rachit.soni-a -n  ns-rcp-ros
note:
If not there create RBAC role and rolebinding
##vs--virtual service 
##n-- namespace

#################Create Role and Rolebinding##################################
###creatintg Role 
$ vi ns-rcp-ros-role1.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name:  ns-rcp-ros-role1                                                          
  namespace:  ns-rcp-ros
rules:
- apiGroups:
  - '#'
  resources:
  - '#'
  verbs:
  - '#'
:wq!
  
$ kubectl create -f ns-rcp-ros-role0.yaml

#########create  Rolebinding using command and add role to multiple user.
$ kubectl create rolebinding ns-rcp-ros-rolebinding9 --role=ns-rcp-ros-role1  --user=anup.fukat-a --user=yatin.agrawal-a --user=yatin.agrawal-a --user=Utkarsh.chouhan-a --user=Jayesh.gehlod-a --user=rachit.soni-a --user=mohit.sahu-a --user=Puneet.Joshi-a --user=ajay.sharma-a --namespace=ns-rcp-ros

##########Create yaml file of role and rolebinding for the user ##############
$ vim role_rolebonding-sai.yaml

apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: full-permission-role
  namespace:  ns-rcp-ros
rules:
- apiGroups: ["*"]
  resources: ["*"]
  verbs: ["*"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: full-permission-rolebinding
subjects: ##points to user or serviceaccount
- kind: User
  name: sai ##useraccount to  bind 
  apiGroup: rbac.authorization.k8s.io
roleRef: ##points to my role 
  kind: Role
  name: full-permission-role ##name of role 
  apiGroup: rbac.authorization.k8s.io
:wq!

$ kubectl create -f role_rolebonding-sai.yaml

#########################Create role and rolebinding using commandline   ######################################
$ kubectl create role fm-role12 -n ns-rn-ros-fm --verb=# --resource=rs
$ kubectl create rolebinding fm-rolebinding13 --role=fm-role12  --user=shubham.panchal-a -n ns-rn-ros-fm

##############################  RBAC for top pods###############################  
##first create the role 
$ vi ns-rbss-ha2-role0.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name:  ns-rbss-ha2-role0
  namespace:  ns-rbss-ha2
rules:
- apiGroups: ["metrics.k8s.io"]
  resources: ["#"]
  verbs: ["#"]
:wq!

$ kubectl create -f ns-rbss-ha2-role0.yaml
Note:
1.By default if user have RABC permission he can not do kubectl get top pods or nodes if he have certain limit permission then   you need to create above role with apiGroups: ["metrics.k8s.io"].
2. add this role to the rolebinding with namespace, username  with below command 

##second add the created role to the rolebinding with username 
$ kubectl create rolebinding ns-rbss-ha2-role0-rolebind  --role=ns-rbss-ha2-role0  --user=debjeet.mazumdar --namespace=ns-rbss-ha2 

#############################cluster role ########################################
##first create the role 

$ vim node-view-role.yaml
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: node-view
rules:
- apiGroups: [""]
  resources: ["nodes"]
  verbs: ["get", "list", "watch"]
:wq!

$ kubectl create -f node-view-role.yaml

##second add the created role to the rolebinding with username

$ kubectl create clusterrolebinding clusterrolenodeview2 --clusterrole=node-view --user=gaurav.jain-a

###############Create RBAC for Service Account  ###########################
$ kubectl create role ns-rm-rsp-role9 --resource=# --verb=# --namespace=ns-rm-rsp
$ kubectl create rolebinding ns-rm-rsp-rolebinding8 --role=ns-rm-rsp-role9 --serviceaccount=ns-rm-rsp:svc.rmrsp.auto-a --namespace=ns-rm-rsp

###############Node not ready state##########################
1. Check the ping status if ping is not working assign to build team
2. check the ssh status if ssh services are not working assign to build team
 if you are able to login then check the kublet service if kublet service is down restart the service
 systemctl status kublet.service
 systemctl restart kublet.service
 then automatically node will come up.
 
##################################For seeing the Yaml file for pods######################################
$ kubectl get pod bf5dnifdnsk101-dns-01 -n ns-f5-internet-and-infra-dns -o yaml

##################Cleaning Dangaling Images#################
$ docker system df
$ docker image prune -a

## After that load the doker images  and k8s images
cd /root/upgrade_5.3.11-217/gorobintar
$ docker load -i robinimg.tar.gz
$ docker load -i k8simg.tar.gz

####################Adding labels to the namespace######################
$ kubectl label namespaces ns-rm-rsp proj=rsp   --over-write=true
$ kubectl get namespace <namespacensame> --show-labels
## for over deleteing label
$ kubectl label node <nodename> proj-

################helm install#############################################
$ helm install obf-service-account .    -n obf 
$ helm upgrade --install rsp-minio-operator /opt/operator --namespace ns-rm-rsp

##############For checking the logs of a pod#######################################
$ kubectl logs -f minio-operator-655d6c76d8-lgtd4 -n ns-rm-rsp
 
#############For checking event logs#########################
$ kubectl get events -n ns-rm-rsp | grep -i operator 

######################################Taint a node with key=value labels########################8
$ kubectl taint nodes uhn7kl5r7rbms001.rmnkiba.local node-role.kubernetes.io/master:NoSchedule
##############For removing the taint on node level############################################
$ kubectl taint nodes uhn7kls2drbms001.rmnkiba.local node-role.kubernetes.io/master:NoSchedule- 				for untainting
$ kubectl taint nodes node1 key1=value1:NoExecute
$ kubectl taint nodes node1 key2=value2:NoSchedule

############################################################Large files to find######################################################
 find /var -type f -size +1G -exec ls -lrth {} \;

#########save a docker image and execute it on all the worker nodes by using for command###########
$ docker image ls | grep k8s-prometheus-adapter-amd64:v0.6.0
$ docker image ls | grep k8s-prometheus-adapter-amd
$ docker save directxman12/k8s-prometheus-adapter-amd64
$ docker save -h
$ docker save directxman12/k8s-prometheus-adapter-amd64
$ docker save directxman12/k8s-prometheus-adapter-amd64 -o test.tar
$ docker image ls
$ docker image ls | grep k8s-prometheus-adapter-amd

####################kubectl commands######################88 
$ kubectl get nodes -o wide
$ kubectl get nodes | awk -F '{print $1}'
$ kubectl get nodes | awk '{print $1}'
$ kubectl get nodes | awk '{print $1}' | grep -v ms
$ kubectl get nodes | awk '{print $1}' | grep -v ms | grep -v NAME
$ for i in `kubectl get nodes | awk '{print $1}' | grep -v ms | grep -v NAME`; do scp sar.sh root@$i:/root/; done
$ ssh root@uhn7kls15rbms003 "hostname"
$ ssh root@uhn7kls15rbwk003 "hostname"
$ for i in `kubectl get nodes | awk '{print $1}' | grep -v ms | grep -v NAME`; do ssh root@$i "docker load -i /root/test.tar" ; done
$ for i in `kubectl get nodes | awk '{print $1}' | grep -v ms | grep -v NAME`; do ssh root@$i "docker images | grep directxman12/k8s-prometheus-adapter-amd64" ; done
$ for i in `kubectl get nodes | awk '{print $1}' | grep -v ms | grep -v NAME`; do ssh root@$i "timedatectl" ; done
$ for i in `robin host list | awk '{print $3}' | grep -v Hostname | grep -v all; do "robin host info $i | grep -i bmc" ; done
$ for i in `robin disk info 0x55cd2e41521cab37 | grep ordina | awk -F"|" {'print $2'} | grep pvc`; do echo $i; done
$ for i in `user-list.txt`; do robin user list $i ; done
$ for i in #`namespace.txt; do robin namespace share $i user; done 

#################password for viewing ansible vault to check###########################################
$ ansible-vault view vault_pass_cis_uhn7kl5r1.ini --vault-password-file ~/.vault_password
$ ansible-vault encrypt vault_pass_cis_uhn7klr27.ini --vault-password-file ~/.vault_password
 
###################kls29 webhook issue#####################################################
$ kubectl api-resources | grep -i webhook 
$ kubectl get validatingwebhookconfigurations
NAME                                          WEBHOOKS   AGE
controllers-validating-webhook                1          28d
gatekeeper-validating-webhook-configuration   2          375d
ippoolcr-validating-webhook                   1          28d
istiod-istio-system                           1          252d
kyverno-policy-validating-webhook-cfg         1          8m47s check this are running or not if not running delete this one 
kyverno-resource-validating-webhook-cfg       2          8m47s check this are running or not if not running delete this oneK!
namespaces-validating-webhook                 1          252d
pods-validating-webhook                       1          28d
pvcs-validating-webhook                       1          28d
stackrox                                      2          258d

#######################grub issue#############################
https://console.rcp.rmb-ss.jp/rcp/knowledge-hub/home/view?id=MjQ3ODc%3D&route=Home
http://isoredirect.centos.org/centos/7/isos/x86_64/

##################Docker registery artifactory login########################################################
$ docker login klstg-docker.slb-wartifactory-v.stg.rmn.local/rakuten/zadara/csi-driver:2.0.0
$ docker image pull klstg-docker.slb-wartifactory-v.stg.rmn.local/rakuten/zadara/csi-driver:2.0.0
$ docker image ls |grep -i klstg-docker

########################
$ ansible-playbook -i ../rcp-inventory-kiba/uhn7klr25/inventory_uhn7klr25.yml -i inventory/common/kiba/inventory_staging_common.yml istio-integ.yml  --extra-vars ansible_ssh_user=root --ask-pass
$ while [ 1 ]; do kubectl delete pdb -n databus databus-cluster-kafka; kubectl delete pdb -n databus databus-cluster-zookeeper; kubectl delete pdb -n databus databus-registry-pdb; sleep 2; done
$ ansible-playbook -i ../rcp-inventory-kiba/uhn7klt21/inventory_uhn7klt21.yml -i inventory/common/kiba/inventory_staging_common.yml istio-integ.yml -e istio_revision="1-10-4" --extra-vars ansible_ssh_user=root --ask-pass
$ kubectl drain  uhn7klt21rbwk002.rmnkiba.local --ignore-daemonsets --delete-emptydir-data

##################refernce  url for utilise X509 Client Certificates & RBAC to secure Kubernetes###################
$ https://medium.com/swlh/how-we-effectively-managed-access-to-our-kubernetes-cluster-38821cf24d57

#####What is CrashLoopBackOff Status
In K8s, CrashLoopBackOff is a common error that you may have encountered when deploying your Pods. A pod in a CrashLoopBackOff state indicates that it is repeatedly crashing and being restarted by the k8s system. 
This can happen for the following reasons:
1)Incorrect Pod Configuration: The pod or container might be configured with wrong parameters or flags leading to crash.
2)Container image issues: The container image may be missing or corrupted, causing the container to crash as soon as it starts.
3)Resource constraints: The pod may be requesting more resources (e.g. CPU, memory) than are available on the node, causing the container to crash due to resource starvation.
4)Incompatible environment: The container may be expecting certain environment variables or configurations that are not present in the pod, causing the container to crash.
5)Application bugs: The application inside the container may have bugs that cause it to crash.
6)Issue with Third-Party Services (DNS Error): Sometimes, the CrashLoopBackOff error is caused by an issue with one of the third-party services, such as unable to resolve DNS.
7)Missing Dependencies: Runtime dependencies (i.e., the var, run, secrets, kubernetes.io, or service account) are missing.


