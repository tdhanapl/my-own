#####################For RBAC permission of kubernetes########################

###############For checking user is having resource RBAC permission or not################################
$ kubectl auth can-i create pod --as rachit.soni-a -n  ns-rcp-ros
note:
vs--virtual service 
n-- namespace
If not there create RBAC role and rolebinding
#################################Create Role and Rolebinding##################################
###ceratintg Role 
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

#########create  Rolebinding using command and add role.
$ kubectl create rolebinding ns-rcp-ros-rolebinding9 --role=ns-rcp-ros-role1  --user=anup.fukat-a --user=yatin.agrawal-a --user=yatin.agrawal-a --user=Utkarsh.chouhan-a --user=Jayesh.gehlod-a --user=rachit.soni-a --user=mohit.sahu-a --user=Puneet.Joshi-a --user=ajay.sharma-a --namespace=ns-rcp-ros

##########Create yaml file of role and rolebinding for the user ##############
$ vim role_rolebonding-sai.yaml

apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: full-permission-role
rules:
- apiGroups: ["*"]
  resources: ["*"]
  verbs: ["*"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: full-permission-rolebinding
subjects:
- kind: User
  name: sai
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: full-permission-role
  apiGroup: rbac.authorization.k8s.io
:wq!
$ kubectl cerate -f role_rolebonding-sai.yaml

#########################Create role and rolebinding using commandline   ######################################
$ kubectl create role fm-role12 -n ns-rn-ros-fm --verb=# --resource=rs
$ kubectl create rolebinding fm-rolebinding13 --role=fm-role12  --user=shubham.panchal-a -n ns-rn-ros-fm

##############################################  RBAC for top pods###############################  
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

#################################  Service Account  ###########################
kubectl create role ns-rm-rsp-role9 --resource=# --verb=# --namespace=ns-rm-rsp
kubectl create rolebinding ns-rm-rsp-rolebinding8 --role=ns-rm-rsp-role9 --serviceaccount=ns-rm-rsp:svc.rmrsp.auto-a --namespace=ns-rm-rsp

##########################################################################  
SCP command for IPV6
########################################
server to jump:-
##################
scp -r root@[240b:c0e0:102:55d8:b492:2::]:/var/log/sa/sar16 .

One server to another server
#############################################
scp -r /home/mamidipaka.saikumar/operator root@[240b:c0e0:102:55d8:b482:2::]:/opt/
From local to jump host
#######################
Command  to fetch from remote server to local server
#########################################################################8:
scp -P <jump host port in pomerium desktop> AD-ID@localhost:< path for file to fetch >  <file path to be placed>

Command  to fetch from local server to remote server:
##################################local to jumphost SCP ##############################################
Put the file into my documents
#open mobaxterm
# then go to c directory cd c:\ then do ll you will see all the folders.
cd /drives/C/Users/40031335/ONEDRI~1/DOCUME~1/ 
scp -P 2200 -r operator.zip mamidipaka.saikumar@localhost:/home/mamidipaka.saikumar
scp -P 2200 /drives/C/Users/40031335/ONEDRI~1/DOCUME~1/operator.zip  mamidipaka.saikumar@localhost:/home/mamidipaka.saikumar


scp -P <jump host port in pomerium desktop> <file path to be transfered> AD-ID@localhost:< Jump host path >

###############################Context creation#########################
robin client add-context 240b:c0e0:0102:54dc:b452:0002:0000:0000 --port 29465 --event-port 29465 --file-port 29465 --set-current --product platform
robin login username
robin k8s get-kube-config --save-as-file --dest-dir ~/.kube
##################################For seeing the Yaml file for pods######################################
kubectl get pod bf5dnifdnsk101-dns-01 -o yaml -n ns-f5-internet-and-infra-dns

##############################################
Imageback pull error
##############################################robin docker-registry tenant-share 130 tn_Mavenir_B2C-ISP-apps_staging3
Need to share the tenant to docker-registery
#########################################8
robin docker-registry list
robin docker-registry tenant-share 128 tn_Mavenir_B2C-ISP-apps_staging3
robin docker-registry tenant-share 129 tn_Mavenir_B2C-ISP-apps_staging3
##############################################
Cleaning Dangaling Images
#########################
docker system df
docker image prune -a
#####################
After that load the robin and k8s images
######################################
cd /root/upgrade_5.3.11-217/gorobintar
docker load -i robinimg.tar.gz
docker load -i k8simg.tar.gz
#########################################
Adding labels to the namespace
##########################################
kubectl label namespaces ns-rm-rsp proj=rsp   --over-write=true
kubectl get namespace <namespacensame> --show-labels.
for over deleteing label
kubectl label node <nodename> proj-

################helm install#############################################
helm install obf-service-account .    -n obf 
helm upgrade --install rsp-minio-operator /opt/operator --namespace ns-rm-rsp
###########################################8
 For checking the logs of a pod
 ################################################
 kubectl logs -f minio-operator-655d6c76d8-lgtd4 -n ns-rm-rsp
###############################
For checking event logs
#################################
kubectl get events -n ns-rm-rsp | grep -i operator 

####################################Probepending/Mantainace error########################
--robin host list
--check file collection status
l
if host status is probepending then execute below command
--robin host probe "Host name" 
--robin unset-manintaince <hostname>
#############################################Node not ready state###################################
 1. Check the ping status if ping is not working assign to build team
 2. check the ssh status if ssh services are not working assign to build team
 if you are able to login then check the kublet service if kublet service is down restart the service
 systemctl status kublet.service
 systemctl restart kublet.service
 then automatically node will come up.
######################################Taint a node with key=value labels########################8
kubectl taint nodes uhn7kl5r7rbms001.rmnkiba.local node-role.kubernetes.io/master:NoSchedule
##############For removing the taint on node level############################################
kubectl taint nodes uhn7kls2drbms001.rmnkiba.local node-role.kubernetes.io/master:NoSchedule- 				for untainting
kubectl taint nodes node1 key1=value1:NoExecute
kubectl taint nodes node1 key2=value2:NoSchedule
############################################################Large files to find######################################################
 find /var -type f -size +1G -exec ls -lrth {} \;
##########################Pod exec timeout issue################################
 robin config list | grep timeout
 If it is not 15mins we can update to 15mins by below commands.
 # robin config update manager client_timeout 15m
~# robin config update manager server_timeout 15m
###########################################################################
 Hi Team,
Process for Internet access to the pods. 
=============================
1. ARB approval for public internet access
2. Public IP pool request (Thiruapthi)
3. Firewall configuration request
4. ACI configuraton(Prateek team)
5. Cluster level ip-pool allocation (Build team)
6. Pod/helm/robin app level ip pool allocation need to be defined(static or dynamic).
###############################################################################
 Robin app delete 
 Check sjl logs and delete the pod 
 for checking sjl logs
 rbash master
 sjl <job info>
robin app delete <app name> --force.
robin app delete --force --wait --yes b2cbss-ocdportal

worker node logs can be check by
rbash robin 
ajl <job id>
to check the present logs
press SHIFT G
#########save a docker image and execute it on all the worker nodes by using for command###########
 docker image ls | grep k8s-prometheus-adapter-amd64:v0.6.0
 docker image ls | grep k8s-prometheus-adapter-amd
 docker save directxman12/k8s-prometheus-adapter-amd64
   docker save -h
   docker save directxman12/k8s-prometheus-adapter-amd64
  docker save directxman12/k8s-prometheus-adapter-amd64 -o test.tar
   docker image ls
  docker image ls | grep k8s-prometheus-adapter-amd
  ls
   scp test.tar root@[240b:c0e0:104:5400:b453:2:17:0]:/root/
####################kubectl commands######################88 
  kubectl get nodes -o wide
  kubectl get nodes | awk -F '{print $1}'
  kubectl get nodes | awk '{print $1}'
  kubectl get nodes | awk '{print $1}' | grep -v ms
  kubectl get nodes | awk '{print $1}' | grep -v ms | grep -v NAME
  for i in `kubectl get nodes | awk '{print $1}' | grep -v ms | grep -v NAME`; do scp sar.sh root@$i:/root/; done
 ssh root@uhn7kls15rbms003 "hostname"
  ssh root@uhn7kls15rbwk003 "hostname"
   for i in `kubectl get nodes | awk '{print $1}' | grep -v ms | grep -v NAME`; do ssh root@$i "docker load -i /root/test.tar" ; done
   for i in `kubectl get nodes | awk '{print $1}' | grep -v ms | grep -v NAME`; do ssh root@$i "docker images | grep directxman12/k8s-prometheus-adapter-amd64" ; done
   for i in `kubectl get nodes | awk '{print $1}' | grep -v ms | grep -v NAME`; do ssh root@$i "timedatectl" ; done
   
   for i in `robin host list | awk '{print $3}' | grep -v Hostname | grep -v all; do "robin host info $i | grep -i bmc" ; done
   for i in `robin disk info 0x55cd2e41521cab37 | grep ordina | awk -F"|" {'print $2'} | grep pvc`; do echo $i; done
   
   for i in `user-list.txt`; do robin user list $i ; done
   
   for i in `namespace.txt`; do robin namespace share $i user; done 
###################################collecting sa logs###################################################################
scp -r root@[240b:c0e0:102:55d8:b483:2:1:0]:/tmp/uhn7kls28rbwk003.rmnkiba.local_resource.txt .
 for i in $(seq -w 7 16); do echo ----- $i -----; sar -A -f /var/log/sa/sa$i; done
 
 

touch /tmp/${HOSTNAME}_resource.txt
for i in $(seq -w 7 16)
do echo ----- $i ----- >> /tmp/${HOSTNAME}_resource.txt
sar -A -f /var/log/sa/sa$i >> /tmp/${HOSTNAME}_resource.txt
echo
done
 
################################# robin app probe <app name>#############################################
# Check the app info if it is showing online and partial check the pod is running or not if pod is running then execute the above command.;
#########################################password for viewing ansible vault to check###########################################
 ansible-vault view vault_pass_cis_uhn7kl5r1.ini --vault-password-file ~/.vault_password
 
 ansible-vault encrypt vault_pass_cis_uhn7klr27.ini --vault-password-file ~/.vault_password
 
#####################################kls29 webhook issue#####################################################

kubectl api-resources | grep -i webhook 
kubectl get validatingwebhookconfigurations
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
#############################patch pvc#################################
kubectl patch pvc <PVC_NAME> -p '{"metadata":{"finalizers": []}}' --type=merge
####################################grub issue#############################

https://console.rcp.rmb-ss.jp/rcp/knowledge-hub/home/view?id=MjQ3ODc%3D&route=Home

http://isoredirect.centos.org/centos/7/isos/x86_64/

#############################Node exporter pods not running#####################################
robin metrics start --media SSD --resource-pool default --faultdomain host --replicas 3 --retention-period 7
##################################Docker registery artifactory login########################################################
docker login klstg-docker.slb-wartifactory-v.stg.rmn.local/rakuten/zadara/csi-driver:2.0.0
  786  31/01/23 18:43:34  docker image pull klstg-docker.slb-wartifactory-v.stg.rmn.local/rakuten/zadara/csi-driver:2.0.0
  787  31/01/23 18:46:55 # docker image pull klstg-docker.slb-wartifactory-v.stg.rmn.local/rakuten/b2b_bss/dep_account
  788  31/01/23 18:47:11 docker image ls |grep -i dep_account
  789  31/01/23 18:47:50 # docker image pull klstg-docker.slb-wartifactory-v.stg.rmn.local/rakuten/b2b_bss/dep_account_management:2023:-01-2426
  790  31/01/23 18:47:54 docker image pull klstg-docker.slb-wartifactory-v.stg.rmn.local/rakuten/b2b_bss/dep_account_management:2023:-01-2426
  791  31/01/23 18:48:08 docker image pull klstg-docker.slb-wartifactory-v.stg.rmn.local/rakuten/b2b_bss/dep_account_management:2023-01-2426
  792  31/01/23 18:51:13 docker image pull klstg-docker.slb-wartifactory-v.stg.rmn.local/rakuten/b2b_bss/dep_account-management:2023-01-31-2426

https://[240b:c0e0:102:54e9:c06b:2:0:1]/artifactory/Mobility-Solutions-Group/Vendors/Rakuten/Robin_Platform/Early-Releases/5.3.11/5.3.11-217/k8s-images-5.3.11-217.tar.gz"
user: lab-ro
pwd: RMI@lab-ro!23$

https://[240b:c0e0:102:54e9:c06b:2:0:1]/ui/login/
https://confluence.rakuten-it.com/confluence/pages/viewpage.action?pageId=3307859740




########################
ansible-playbook -i ../rcp-inventory-kiba/uhn7klr25/inventory_uhn7klr25.yml -i inventory/common/kiba/inventory_staging_common.yml istio-integ.yml  --extra-vars ansible_ssh_user=root --ask-pass



while [ 1 ]; do kubectl delete pdb -n databus databus-cluster-kafka; kubectl delete pdb -n databus databus-cluster-zookeeper; kubectl delete pdb -n databus databus-registry-pdb; sleep 2; done




ansible-playbook -i ../rcp-inventory-kiba/uhn7klt21/inventory_uhn7klt21.yml -i inventory/common/kiba/inventory_staging_common.yml istio-integ.yml -e istio_revision="1-10-4" --extra-vars ansible_ssh_user=root --ask-pass


grep -inR 1.10
grep -ilR integration


 kubectl drain  uhn7klt21rbwk002.rmnkiba.local --ignore-daemonsets --delete-emptydir-data
######################################RCA FORMAT##############################
RCA Format # 
     Problem Statement:-
     Analysis :
     Corrective action :

################################## 
Robin SRE Onboarding @Kiba Lab - Roles and Responsibilities
#1. Robin SREs should monitor "robin.sre" queue on LMP/QZEN portal (https://qzen.rmb-ss.jp/qzen/home).
#2. SREs should take robin related tickets from "robin.sre" queue by themselves and may raise RSD if required.
#3. SREs should be aligned with the reporter and should update LMP/RSD tickets accordingly. 
#4. SREs need to work independently.
#5. Leads/IMs/Rakuten SREs can be contacted in case of any support required.



-robin metrics start --media SSD --resource-pool default --faultdomain host --replicas 3 --retention-period 7









