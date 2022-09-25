###################kubernetes errors########
1.itom-bo-user-deployment-pod unable create.
----     ------            ----                 ----                                                      -------
  Warning  dependency check  30s (x1138 over 9h)  init-container, itom-bo-user-deployment-586f94579f-f4cnx  Required resource kubernetes://itom-bo-ats-svc is not ready.
2.autopass-lm-v2-5b6dd67f7b-cm2zd----pod unable create.
  ClaimName:  global-volume
    ReadOnly:   false
  vault-token:
    Type:    EmptyDir (a temporary directory that shares a pods lifetime)
    Medium:
  default-token-dvqml:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-dvqml
    Optional:    false
QoS Class:       Burstable
Node-Selectors:  Worker=label
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason   Age                  From                 Message
  ----     ------   ----                 ----                 -------
  Warning  BackOff  3m (x4198 over 19h)  kubelet, 10.2.247.5  Back-off restarting failed container
3. infra-rabbitmq-0 ---pod unable create
Events:
  Type     Reason               Age   From                 Message
  ----     ------               ----  ----                 -------
  Warning  FailedPostStartHook  58m   kubelet, 10.2.247.5  Exec lifecycle hook ([/bin/sh -c /etc/rabbitmq/set_policy.sh]) for Container "itom-xruntime-rabbitmq" in Pod "infra-rabbitmq-0_itsma3(04060604-bb0e-11ec-be40-0050568e2aba)" failed - error: command '/bin/sh -c /etc/rabbitmq/set_policy.sh' exited with 137: Error: unable to connect to node 'rabbit@infra-rabbitmq-0': nodedown

DIAGNOSTICS
===========

attempted to contact: ['rabbit@infra-rabbitmq-0']

rabbit@infra-rabbitmq-0:
  * connected to epmd (port 4369) on infra-rabbitmq-0
  * epmd reports: node 'rabbit' not running at all
                  other nodes on infra-rabbitmq-0: ['rabbitmq-cli-48']
  * suggestion: start the node

current node details:
- node name: 'rabbitmq-cli-48@infra-rabbitmq-0.saw-rabbitmq.itsma3.svc.cluster.local.'
- home dir: /var/lib/rabbitmq
- cookie hash: bk23GABu88tH9eTvVuqCkA==

Error: unable to connect to node 'rabbit@infra-rabbitmq-0': nodedown

DIAGNOSTICS
===========

attempted to contact: ['rabbit@infra-rabbitmq-0']

rabbit@infra-rabbitmq-0:
  * connected to epmd (port 4369) on infra-rabbitmq-0
  * epmd reports: node 'rabbit' not running at all
                  other nodes on infra-rabbitmq-0: ['rabbitmq-cli-49']
  * suggestion: start the node

current node details:
- node name: 'rabbitmq-cli-49@infra-rabbitmq-0.saw-rabbitmq.itsma3.svc.cluster.local.'
- home dir: /var/lib/rabbitmq
- cookie hash: bk23GABu88tH9eTvVuqCkA==

Error: unable to connect to node 'rabbit@infra-rabbitmq-0': nodedown

DIAGNOSTICS
===========

attempted to contact: ['rabbit@infra-rabbitmq-0']

rabbit@infra-rabbitmq-0:
  * connected to epmd (port 4369) on infra-rabbitmq-0
  * epmd reports: node 'rabbit' not running at all
                  other nodes on infra-rabbitmq-0: ['rabbitmq-cli-18']
  * suggestion: start the node

current node details:
- node name: 'rabbitmq-cli-18@infra-rabbitmq-0.saw-rabbitmq.itsma3.svc.cluster.local.'
- home dir: /var/lib/rabbitmq
- cookie hash: bk23GABu88tH9eTvVuqCkA==

Error: unable to connect to node 'rabbit@infra-rabbitmq-0': nodedown

DIAGNOSTICS
===========

attempted to contact: ['rabbit@infra-rabbitmq-0']

rabbit@infra-rabbitmq-0:
  * connected to epmd (port 4369) on infra-rabbitmq-0
  * epmd reports: node 'rabbit' not running at all
                  other nodes on infra-rabbitmq-0: ['rabbitmq-cli-85']
  * suggestion: start the node

current node details:
- node name: 'rabbitmq-cli-85@infra-rabbitmq-0.saw-rabbitmq.itsma3.svc.cluster.local.'
- home dir: /var/lib/rabbitmq
- cookie hash: bk23GABu88tH9eTvVuqCkA==

Error: rabbit application is not running on node rabbit@infra-rabbitmq-0.saw-rabbitmq.itsma3.svc.cluster.local..
 * Suggestion: start it with "rabbitmqctl start_app" and try again
4.itom-bo-ats-deployment-5bc787f7dd-6ztt4--unable create 
Events:
  Type     Reason     Age                  From                 Message
  ----     ------     ----                 ----                 -------
  Warning  Unhealthy  16m (x890 over 19h)  kubelet, 10.2.247.5  Readiness probe failed: Get http://172.16.75.19:31027/health: dial tcp 172.16.75.19:31027: getsockopt: connection refused
  Warning  BackOff    1m (x4480 over 19h)  kubelet, 10.2.247.5  Back-off restarting failed container
  
5.itom-bo-config-deployment-758dd9565f-6565c-unable create pod
Conditions:
  Type           Status
  Initialized    False
  Ready          False 
  PodScheduled   True
Volumes:
  vault-token:
    Type:    EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:  Memory
  nfs:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  global-volume
    ReadOnly:   false
  default-token-dvqml:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-dvqml
    Optional:    false
QoS Class:       Burstable
Node-Selectors:  Worker=label
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason            Age                  From                                                        Message
  ----     ------            ----                 ----                                                        -------
  Warning  dependency check  17s (x1178 over 9h)  init-container, itom-bo-config-deployment-758dd9565f-6565c  Required resource kubernetes://idm-svc is not ready.

6.itom-bo-login-deployment-5b84b47544-lrskm --------unable create pod

Events:
  Type     Reason            Age                  From                                                       Message
  ----     ------            ----                 ----                                                       -------
  Warning  dependency check  29s (x1184 over 9h)  init-container, itom-bo-login-deployment-5b84b47544-lrskm  Required resource kubernetes://idm-svc is not ready.

7.itom-bo-user-deployment-586f94579f-f4cnx-unbale create pod

                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason            Age                 From                                                      Message
  ----     ------            ----                ----                                                      -------
  Warning  dependency check  3s (x1190 over 9h)  init-container, itom-bo-user-deployment-586f94579f-f4cnx  Required resource kubernetes://itom-bo-ats-svc is not ready.
8.itom-bo-user-offline-deployment-5674498c79-qn72d---unable to create pod

                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason            Age                 From                                                              Message
  ----     ------            ----                ----                                                              -------
  Warning  dependency check  0s (x1193 over 9h)  init-container, itom-bo-user-offline-deployment-5674498c79-qn72d  Required resource kubernetes://itom-bo-ats-svc is not ready.

9.itom-xruntime-platform-57586fdb86-htf2b--pod unbale to create 
Conditions:
  Type           Status
  Initialized    False
  Ready          False
  PodScheduled   True
Volumes:
  vault-token:
    Type:    EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:  Memory
  lookup-volume:
    Type:    EmptyDir (a temporary directory that shares a pods lifetime)
    Medium:
  nfs:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  global-volume
    ReadOnly:   false
  default-token-dvqml:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-dvqml
    Optional:    false
QoS Class:       Burstable
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:          <none>

10. itom-xruntime-postgres-696c4b7675-8n5w2--pod unable to cerate 
Events:
  Type     Reason   Age                  From                 Message
  ----     ------   ----                 ----                 -------
  Normal   Pulled   17m (x232 over 19h)  kubelet, 10.2.247.5  Container image "localhost:5000/hpeswitom/itom-itsmax-base-infra-postgres:4.2.1.1" already present on machine
  Warning  BackOff  2m (x5128 over 19h)  kubelet, 10.2.247.5  Back-off restarting failed container

11.smarta-data-source-6d67dbb48d-f69nf---pod unbale create

      /var/run/secrets/kubernetes.io/serviceaccount from default-token-dvqml (ro)
Conditions:
  Type           Status
  Initialized    True
  Ready          False
  PodScheduled   True
Volumes:
  vault-token:
    Type:    EmptyDir (a temporary directory that shares a pods lifetime)
    Medium:  Memory
  global-vol:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  global-volume
    ReadOnly:   false
  default-token-dvqml:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-dvqml
    Optional:    false
QoS Class:       Burstable
Node-Selectors:  Worker=label
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason   Age                  From                 Message
  ----     ------   ----                 ----                 -------
  Warning  BackOff  1m (x4731 over 19h)  kubelet, 10.2.247.5  Back-off restarting failed container


---------------------------------------------

ansible-doc yum --help


ansible-playbook webserver -m shell yum -a "name=httpd state=latest"