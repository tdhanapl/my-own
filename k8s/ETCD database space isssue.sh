##########Troubleshooting the ectd database space issue########
###referneces url 
https://discuss.kubernetes.io/t/etcdserver-mvcc-database-space-exceeded/22806/3
https://etcd.io/docs/v3.5/op-guide/maintenance/

##check the kubernetes etcd database 

$  ETCDCTL_API=3 etcdctl --endpoints=[https://${HOSTNAME}:4001] --cacert ${K8S_HOME}/ssl/ca.crt --cert ${K8S_HOME}/ssl/server.crt --key ${K8S_HOME}/ssl/server.key --write-out=table endpoint status
+-----------------------+-----------------+---------+---------+-----------+-----------+------------+
|       ENDPOINT        |       ID        | VERSION | DB SIZE | IS LEADER | RAFT TERM | RAFT INDEX |
+-----------------------+-----------------+---------+---------+-----------+-----------+------------+
|https://masternode1:4001 | fc6cfed99e4f0df |  3.2.17 |  420 MB |     false |    288212 | 631511767 |
+-----------------------+-----------------+---------+---------+-----------+-----------+------------+

##check the kubernetes etcd database alarm list 
$ ETCDCTL_API=3 etcdctl --endpoints=[https://${HOSTNAME}:4001] --cacert ${K8S_HOME}/ssl/ca.crt --cert ${K8S_HOME}/ssl/server.crt --key ${K8S_HOME}/ssl/server.key alarm list

###Storing the command in the varibale 
$ rev=$(ETCDCTL_API=3 etcdctl --endpoints=[https://${HOSTNAME}:4001] --cacert ${K8S_HOME}/ssl/ca.crt --cert ${K8S_HOME}/ssl/server.crt --key ${K8S_HOME}/ssl/server.key --write-out=json endpoint status | egrep -o '"revision":[0-9]*' | egrep -o '[0-9].*')

## compact away all old revisions
$ ETCDCTL_API=3 etcdctl --endpoints=[https://${HOSTNAME}:4001] --cacert ${K8S_HOME}/ssl/ca.crt --cert ${K8S_HOME}/ssl/server.crt --key ${K8S_HOME}/ssl/server.key compact $rev
compacted revision 327709221

### defragment away excessive space
$ ETCDCTL_API=3 etcdctl --endpoints=[https://${HOSTNAME}:4001] --cacert ${K8S_HOME}/ssl/ca.crt --cert ${K8S_HOME}/ssl/server.crt --key ${K8S_HOME}/ssl/server.key defrag
Finished defragmenting etcd member[https://masternode1:4001]

###disarm etcd alarm
ETCDCTL_API=3 etcdctl --endpoints=[https://${HOSTNAME}:4001] --cacert ${K8S_HOME}/ssl/ca.crt --cert ${K8S_HOME}/ssl/server.crt --key ${K8S_HOME}/ssl/server.key alarm disarm