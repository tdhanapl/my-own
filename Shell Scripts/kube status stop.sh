#########################stop kubernetes by shell scripting########################
#####Stoping the kubernetes using shell scripting########################
!/bin/sh
single_master_tips="Warning: This action will halt all container runtime services (Docker, Kubernetes, ITOM CDF and/or suites) on this node. Do you want to continue? [Y|N]"
multi_master_tips="! WARNING: One or more master nodes are down. This action will halt all container runtime services (Docker, Kubernetes, ITOM CDF and/or suites) on this node. This may lead to a cluster failure. Do you really want to continue? [Y|N]"
choose_tips=""
selected_yes_tips=""
selected_no_tips="Operation cancelled."
answer=""
usage() {
    echo "Usage: $0 [-y|--yes] "
    echo "       -h,--help           Print this help list."
    echo "       -y,--yes            Answer yes for any confirmations."
    exit 1
}

while [[ ! -z $1 ]] ; do
    case "$1" in
        -y|--yes) answer="Y" ; shift ;;
        *|-h|--help|/?|help) usage ;;
    esac
done

COMMON_SH=$(cd "$(dirname "$0")";pwd)/kube-common.sh
LOGFILE=/tmp/kube-stop-`date "+%Y%m%d%H%M%S"`.log

if [ ! -f $COMMON_SH ]
then
        echo Not found $COMMON_SH!
        exit 1
fi
. $COMMON_SH

if [[ -z ${answer}  ]] ; then
    masterReadyNum=0
    exec_cmd "kubectl get nodes"
    if [ $? -eq 0 ]; then
        masterNodeStatus=$(exec_cmd "kubectl get nodes -l master=true --no-headers|awk '{print \$2}'" -p=true)
        for status in $masterNodeStatus;do
            if [ "$status" == "Ready" ];then
                masterReadyNum=$(( $masterReadyNum + 1 ))
            fi
        done
    fi

    arr=($masterNodeStatus)
    if [ "${#arr[@]}" == 1 ]; then
        choose_tips=$single_master_tips
    elif [ "$masterReadyNum" == 3 ]; then
        choose_tips=$single_master_tips
    else
        choose_tips=$multi_master_tips
    fi
    read -p "$choose_tips" answer
    case $answer in
        Y|y|YES|Yes|yes)
            echo $selected_yes_tips
            ;;
        N|n|NO|No|no)
            echo $selected_no_tips
            exit 9
            ;;
        *)
            exit 0
            ;;
    esac
fi

stopNativeService(){
#stop native service with systemctl
    svcName=$1
    showName "Stopping service $svcName"
    exec_cmd "systemctl stop $svcName >/dev/null 2>&1 &" -x=INFO
    n=0
    while true; do
        waiting
        systemctl status $svcName >/dev/null 2>&1
        if [ "$?" == 3 ]; then
            showStatus "Stopped"
            exec_cmd "systemctl status $svcName -l" -x=INFO
            break
        else
            if (( n > $TIMEOUT )); then
                showStatus "Timeout"
                exec_cmd "systemctl status $svcName -l" -x=FATAL
                echo -e "\nFor more detail information, please refer to $LOGFILE\n"
                exit 2
            fi
            waiting
            n=$((n+1))
        fi
    done
}

stopNativeService kube-proxy
stopNativeService kubelet
stopNativeService docker
stopNativeService docker-bootstrap
[root@zemsmp01 bin]# cat kube-stop.sh
#####################################################
 cat kube-start.sh
#!/bin/sh

usage() {
    echo "This action will start all container runtime services (Docker, Kubernetes, ITOM CDF and/or suite containers) on this node."
    echo "Usage: $0 "
    echo "       -h,--help           Print this help list."
    exit 1
}

while [[ ! -z $1 ]] ; do
    case "$1" in
        *|-h|--help|/?|help) usage ;;
    esac
done

##start k8s
COMMON_SH=$(cd "$(dirname "$0")";pwd)/kube-common.sh
ENV_SH=$(cd "$(dirname "$0")";pwd)/env.sh
LOGFILE=/tmp/kube-start-`date "+%Y%m%d%H%M%S"`.log

#start Docker
startNativeService() {
    svcName=$1
    showName "Starting service $svcName"
    exec_cmd "systemctl daemon-reload" -x=INFO
    exec_cmd "systemctl start $svcName >/dev/null 2>&1 &" -x=INFO
    checkNativeService $svcName
}

checkNativeService(){
#check if started
    n=0
    while true; do
        waiting
        systemctl status $svcName >/dev/null 2>&1
        if [ "$?" == 0 ]; then
            showStatus "Started"
            exec_cmd "systemctl status $svcName -l" -x=INFO
            break
        else
            if (( n > $TIMEOUT )); then
                showStatus "Timeout"
                exec_cmd "systemctl status $svcName -l" -x=FATAL
                echo -e "\nFor more detail information, please refer to $LOGFILE\n"
                exit 2
            fi
            n=$((n+1))
        fi
        waiting
    done
}

isMasterNode(){
    local isMaster=
    if [[ -d ${K8S_HOME}/data/etcd ]] && [[ -d ${K8S_HOME}/log/apiserver ]] && [[ $(exec_cmd "ls ${K8S_HOME}/data/etcd|wc -l" -p=true) -gt 0 ]] ; then
        isMaster=true
    else
        isMaster=false
    fi
    echo $isMaster
}

loadCDFImages() {
    local k8s_home=${K8S_HOME}
    if [[ "${k8s_home:$((-1))}" != "/" ]] ; then
        k8s_home="${k8s_home}/"
    fi
    local image_property_dir=${k8s_home}properties/images
    source ${image_property_dir}/images.properties
    local is_master=$(isMasterNode)
    local images
    if [ "$is_master" == "true" ] ; then
        images=(${IMAGE_ITOM_CDF_APISERVER} ${IMAGE_ITOM_CDF_SUITEFRONTEND} ${IMAGE_KUBERNETES_VAULT} ${IMAGE_KUBERNETES_VAULT_INIT} ${IMAGE_KUBERNETES_VAULT_RENEW} ${IMAGE_KUBE_REGISTRY_PROXY} ${IMAGE_ITOM_REGISTRY} ${IMAGE_ITOM_BUSYBOX} ${IMAGE_HYPERKUBE} ${IMAGE_K8S_DNS_KUBE_DNS_AMD64} ${IMAGE_K8S_DNS_SIDECAR_AMD64} ${IMAGE_K8S_DNS_DNSMASQ_NANNY_AMD64} ${IMAGE_PAUSE_AMD64} ${IMAGE_KEEPALIVED})
    else
        images=(${IMAGE_KUBERNETES_VAULT_INIT} ${IMAGE_KUBERNETES_VAULT_RENEW} ${IMAGE_KUBE_REGISTRY_PROXY} ${IMAGE_PAUSE_AMD64} ${IMAGE_ITOM_BUSYBOX})
    fi
    local image_dir="${k8s_home}images"

    local repository
    local image_full_name
    local newlineIFS=$'\n'
    local firstTime="true"
    for im in ${images[@]} ; do
        local image_name=${im%:*}
        local image_tag=${im##*:}
        if [ "${image_name}" == "hyperkube" -o "${image_name}" == "k8s-dns-sidecar-amd64" -o "${image_name}" == "k8s-dns-kube-dns-amd64" -o "${image_name}" == "k8s-dns-dnsmasq-nanny-amd64" -o "${image_name}" == "pause-amd64" ] ; then
            repository="gcr.io/google_containers"
        else
            repository="localhost:5000"
        fi

        local found="false"
        local line
        local IFS="$newlineIFS"

        #several lines may match
        for line in `docker images | grep "${repository}/${image_name}" | grep "${image_tag}"`
        do
            local name=$(echo "$line" | awk -F' ' '{print $1}')
            local tag=$(echo "$line" | awk -F' ' '{print $2}')

            if [ "${name}" == "${repository}/${image_name}" ] && [ "${tag}" == "${image_tag}" ] ; then
                found="true"
                break
            fi
        done

        if [ "${found}" == "true" ] ; then
            continue
        else    #not found in the docker graph driver
            if [ "${firstTime}" == "true" ] ; then
                firstTime="false"
                echo ""
                echo "Some of the basic images are missing,try to reload:"
            fi

            res=$(ls ${image_dir} | grep "${image_name}" 2>/dev/null | wc -l)
            if [[ ${res} -eq 0 ]] ; then
                showName "Loading image:$im"
                showStatus "Failed"
                logger_err "image:${image_name}-${image_tag} no found in ${image_dir}"
                exit 1
            else
                #several images may match, and load them all
                for line in `ls ${image_dir} | grep "${image_name}" 2>/dev/null`
                do
                    showName "Loading image:$line"
                    image_full_name=${image_dir}/${line}
                    docker load -i ${image_full_name} >> $LOGFILE 2>/dev/null
                    if [[ $? -ne 0 ]] ; then
                        showStatus "Failed"
                        logger_err "fail to load image:${image_full_path}"
                        exit 1
                    fi
                    if [ "${image_name}" == "itom-busybox" ] ; then
                        org_name=${REGISTRY_ORGNAME}
                        docker tag ${repository}/${image_name}:${image_tag}    ${repository}/${org_name}/${image_name}:${image_tag}
                        if [[ $? -ne 0 ]] ; then
                            showStatus "Failed"
                            logger_err "retag image failed:${image_name}"
                            exit 1
                        fi
                    fi
                    showStatus "Done"
                done
            fi
        fi
    done

    if [ "$firstTime" = "false" ] ; then
        echo ""
    fi
}

if [ ! -f $COMMON_SH  -o ! -f $ENV_SH ]
then
        echo Not found $COMMON_SH or $ENV_SH!
        exit 1
fi
. $COMMON_SH
. $ENV_SH

startNativeService docker-bootstrap
sleep 5
startNativeService docker
sleep 5
loadCDFImages
startNativeService kubelet
sleep 5
startNativeService kube-proxy

echo
echo "Docker is restarted. Please check the pod Status with kube-status.sh in a few seconds"
#################################
        *|-h|--help|/?|help) usage ;;
    esac
done

##start k8s
COMMON_SH=$(cd "$(dirname "$0")";pwd)/kube-common.sh
ENV_SH=$(cd "$(dirname "$0")";pwd)/env.sh
LOGFILE=/tmp/kube-start-`date "+%Y%m%d%H%M%S"`.log

#start Docker
startNativeService() {
    svcName=$1
    showName "Starting service $svcName"
    exec_cmd "systemctl daemon-reload" -x=INFO
    exec_cmd "systemctl start $svcName >/dev/null 2>&1 &" -x=INFO
    checkNativeService $svcName
}

checkNativeService(){
#check if started
    n=0
    while true; do
        waiting
        systemctl status $svcName >/dev/null 2>&1
        if [ "$?" == 0 ]; then
            showStatus "Started"
            exec_cmd "systemctl status $svcName -l" -x=INFO
            break
        else
            if (( n > $TIMEOUT )); then
                showStatus "Timeout"
                exec_cmd "systemctl status $svcName -l" -x=FATAL
                echo -e "\nFor more detail information, please refer to $LOGFILE\n"
                exit 2
            fi
            n=$((n+1))
        fi
        waiting
    done
}

isMasterNode(){
    local isMaster=
    if [[ -d ${K8S_HOME}/data/etcd ]] && [[ -d ${K8S_HOME}/log/apiserver ]] && [[ $(exec_cmd "ls ${K8S_HOME}/data/etcd|wc -l" -p=true) -gt 0 ]] ; then
        isMaster=true
    else
        isMaster=false
    fi
    echo $isMaster
}

loadCDFImages() {
    local k8s_home=${K8S_HOME}
    if [[ "${k8s_home:$((-1))}" != "/" ]] ; then
        k8s_home="${k8s_home}/"
    fi
    local image_property_dir=${k8s_home}properties/images
    source ${image_property_dir}/images.properties
    local is_master=$(isMasterNode)
    local images
    if [ "$is_master" == "true" ] ; then
        images=(${IMAGE_ITOM_CDF_APISERVER} ${IMAGE_ITOM_CDF_SUITEFRONTEND} ${IMAGE_KUBERNETES_VAULT} ${IMAGE_KUBERNETES_VAULT_INIT} ${IMAGE_KUBERNETES_VAULT_RENEW} ${IMAGE_KUBE_REGISTRY_PROXY} ${IMAGE_ITOM_REGISTRY} ${IMAGE_ITOM_BUSYBOX} ${IMAGE_HYPERKUBE} ${IMAGE_K8S_DNS_KUBE_DNS_AMD64} ${IMAGE_K8S_DNS_SIDECAR_AMD64} ${IMAGE_K8S_DNS_DNSMASQ_NANNY_AMD64} ${IMAGE_PAUSE_AMD64} ${IMAGE_KEEPALIVED})
    else
        images=(${IMAGE_KUBERNETES_VAULT_INIT} ${IMAGE_KUBERNETES_VAULT_RENEW} ${IMAGE_KUBE_REGISTRY_PROXY} ${IMAGE_PAUSE_AMD64} ${IMAGE_ITOM_BUSYBOX})
    fi
    local image_dir="${k8s_home}images"

    local repository
    local image_full_name
    local newlineIFS=$'\n'
    local firstTime="true"
    for im in ${images[@]} ; do
        local image_name=${im%:*}
        local image_tag=${im##*:}
        if [ "${image_name}" == "hyperkube" -o "${image_name}" == "k8s-dns-sidecar-amd64" -o "${image_name}" == "k8s-dns-kube-dns-amd64" -o "${image_name}" == "k8s-dns-dnsmasq-nanny-amd64" -o "${image_name}" == "pause-amd64" ] ; then
            repository="gcr.io/google_containers"
        else
            repository="localhost:5000"
        fi

        local found="false"
        local line
        local IFS="$newlineIFS"

        #several lines may match
        for line in `docker images | grep "${repository}/${image_name}" | grep "${image_tag}"`
        do
            local name=$(echo "$line" | awk -F' ' '{print $1}')
            local tag=$(echo "$line" | awk -F' ' '{print $2}')

            if [ "${name}" == "${repository}/${image_name}" ] && [ "${tag}" == "${image_tag}" ] ; then
                found="true"
                break
            fi
        done

        if [ "${found}" == "true" ] ; then
            continue
        else    #not found in the docker graph driver
            if [ "${firstTime}" == "true" ] ; then
                firstTime="false"
                echo ""
                echo "Some of the basic images are missing,try to reload:"
            fi

            res=$(ls ${image_dir} | grep "${image_name}" 2>/dev/null | wc -l)
            if [[ ${res} -eq 0 ]] ; then
                showName "Loading image:$im"
                showStatus "Failed"
                logger_err "image:${image_name}-${image_tag} no found in ${image_dir}"
                exit 1
            else
                #several images may match, and load them all
                for line in `ls ${image_dir} | grep "${image_name}" 2>/dev/null`
                do
                    showName "Loading image:$line"
                    image_full_name=${image_dir}/${line}
                    docker load -i ${image_full_name} >> $LOGFILE 2>/dev/null
                    if [[ $? -ne 0 ]] ; then
                        showStatus "Failed"
                        logger_err "fail to load image:${image_full_path}"
                        exit 1
                    fi
                    if [ "${image_name}" == "itom-busybox" ] ; then
                        org_name=${REGISTRY_ORGNAME}
                        docker tag ${repository}/${image_name}:${image_tag}    ${repository}/${org_name}/${image_name}:${image_tag}
                        if [[ $? -ne 0 ]] ; then
                            showStatus "Failed"
                            logger_err "retag image failed:${image_name}"
                            exit 1
                        fi
                    fi
                    showStatus "Done"
                done
            fi
        fi
    done

    if [ "$firstTime" = "false" ] ; then
        echo ""
    fi
}

if [ ! -f $COMMON_SH  -o ! -f $ENV_SH ]
then
        echo Not found $COMMON_SH or $ENV_SH!
        exit 1
fi
. $COMMON_SH
. $ENV_SH

startNativeService docker-bootstrap
sleep 5
startNativeService docker
sleep 5
loadCDFImages
startNativeService kubelet
sleep 5
startNativeService kube-proxy

echo
echo "Docker is restarted. Please check the pod Status with kube-status.sh in a few seconds"
#############################  kube-status.sh######################
#!/bin/bash

# source /etc/profile
START_TIME=`date +%s`

COMMON_SH=$(cd "$(dirname "$0")";pwd)/kube-common.sh

if [ ! -f $COMMON_SH ]
then
        echo Not found $COMMON_SH!
        exit 1
fi

. $COMMON_SH

MASTER_NODES="mmmaster1 mmmaster2 mmmaster3 "
WORKER_NODES="mmworker1 mmworker2 "

SSH_PORTAL_PORT=5443
PORTAL_CONTAINER_PORT=9090
ETCD_ENDPOINT_PORT=4001

K8S_HOME=${K8S_HOME:-"/opt/kubernetes"}
CERT_PATH=${K8S_HOME}/ssl
K8S_LOG_PATH=${K8S_HOME}/log
INFO_LOG=${K8S_LOG_PATH}/status_info.log
ERR_LOG=${K8S_LOG_PATH}/status_err.log
TMP_FILE=${K8S_LOG_PATH}/check.tmp
RESULT_FILE=${K8S_LOG_PATH}/result_checkStatus.txt
REPORT_FILE=${K8S_LOG_PATH}/result_checkStatus.html

DELIMITER=","
STATUS_COL=4
OUTPUT_LEN=70

WAIT_TIMEOUT=600

TOTAL_CASE=0
PASSED_CASE=0
FAILED_CASE=0
IGNORED_CASE=0

AUTOTEST=n

#######################
# Lists to be checked #
#######################
POD_LIST="
core    apiserver                _master
core    controller               _master
core    scheduler                _master
"
DEPLOYMENT_LIST_DB_NONE="
kube-system  heapster-apiserver
core    idm
core    mng-portal
core    suite-db
core    cdf-apiserver
core    suite-installer-frontend
"

DEPLOYMENT_LIST_DB_SINGLE="
kube-system  heapster-apiserver
core    idm
core    mng-portal
core    suite-db
core    cdf-apiserver
core    suite-installer-frontend
core    itom-postgresql-default
"
DEPLOYMENT_LIST_DB_HA="
kube-system  heapster-apiserver
core    idm
core    mng-portal
core    suite-db
core    cdf-apiserver
core    suite-installer-frontend
core    itom-postgresql-node1
core    itom-postgresql-node2
core    itom-postgresql-pool
"
MINI_POD_LIST="
core    apiserver                _master
core    controller               _master
core    kube-dns                 _single
core    kubernetes-vault         _single
core    scheduler                _master
core    cdf-apiserver            _single
core    suite-installer-frontend _single
"

SERVICE_LIST_DB_NONE="
default kubernetes
core    idm-svc
core    kube-dns
core    kube-registry
core    kubernetes-vault
core    mng-portal
core    suite-db-svc
core    suite-installer-svc
core    cdf-svc
core    cdf-suitefrontend-svc
kube-system    heapster
"

SERVICE_LIST_DB_SINGLE="
default kubernetes
core    default-postgresql-svc
core    idm-svc
core    kube-dns
core    kube-registry
core    kubernetes-vault
core    mng-portal
core    suite-db-svc
core    suite-installer-svc
core    cdf-svc
core    cdf-suitefrontend-svc
kube-system    heapster
"

SERVICE_LIST_DB_HA="
default kubernetes
core    default-postgresql-svc
core    cdf-pgnode1
core    cdf-pgnode2
core    idm-svc
core    kube-dns
core    kube-registry
core    kubernetes-vault
core    mng-portal
core    suite-db-svc
core    suite-installer-svc
core    cdf-svc
core    cdf-suitefrontend-svc
kube-system    heapster
"

MINI_SERVICE_LIST="
default kubernetes
core    kube-dns
core    kubernetes-vault
core    cdf-svc
core    cdf-suitefrontend-svc
core    suite-installer-svc
"

RC_LIST="
core    kube-registry-v0
"

DS_LIST="
core    kube-registry-proxy
core    nginx-ingress-controller
core    kube-dns
core    kube-registry
core    kubernetes-vault
"

convert_html(){
        inf Generating report ...

        echo "<html>" > $REPORT_FILE
        echo "<head>" >> $REPORT_FILE
        echo "<style type=\"text/css\">" >> $REPORT_FILE
        echo "  body {font-family: sans-serif;font-size: 12px;}" >> $REPORT_FILE
        echo "  table {border-collapse:collapse;border:2px solid black;}" >> $REPORT_FILE
        echo "  td,th {border:1px solid black; font-size:13px; padding:3px;}" >> $REPORT_FILE
        echo "  th {background-color: #E0E0E0;font-size: 14px;}" >> $REPORT_FILE
        echo "  tfoot {font-weight:bold;border:2px solid black;}" >> $REPORT_FILE
        echo "</style>" >> $REPORT_FILE
        echo "</head>" >> $REPORT_FILE
        echo "<body>" >> $REPORT_FILE
        echo "<div><b>Local IP: </b>${LOCAL_IP}</div>" >> $REPORT_FILE
        echo "<div><b>Master: </b>${MASTER_NAME_LIST}</div>" >> $REPORT_FILE
        echo "<div><b>Worker: </b>${WORKER_NAME_LIST}</div>" >> $REPORT_FILE
        if [ ${duration} -le 1 ]
        then
                echo "<div><b>Duration: </b>${duration} second</div>" >> $REPORT_FILE
        else
                echo "<div><b>Duration: </b>${duration} seconds</div>" >> $REPORT_FILE
        fi
        if [ "${overall_status}" = "Running" ]
        then
                echo "<div><b>Status: </b><b style="color:green">${overall_status}</b></div>" >> $REPORT_FILE
        else
                echo "<div><b>Status: </b><b style="color:red">${overall_status}</b></div>" >> $REPORT_FILE
        fi
        echo "<br>" >> $REPORT_FILE
        echo "<div style=font-size:13px><b>Total Cases: ${TOTAL_CASE}</b>&emsp;&emsp;&emsp;&emsp;<b style=color:green>Passed: ${PASSED_CASE}</b>&emsp;&emsp;&emsp;&emsp;<b style=color:red>Failed: ${FAILED_CASE}</b></div>" >> $REPORT_FILE

        echo "<table>" >> $REPORT_FILE
        lines=`cat $1|wc -l`
        i=1
        while read line
        do
                # if [ $i -eq `expr $lines - 3` ]
                # then
                        # echo "<tfoot>" >> $REPORT_FILE
                # fi

                echo "<tr>" >> $REPORT_FILE
                num=`echo $line|awk -F${DELIMITER} '{print NF}'`
                j=1
                while [ $j -le $num ]
                do
                        cell=`echo "$line"|awk -F${DELIMITER} '{print $'$j'}'`
                        if [ $i -eq 1 ]
                        then
                                echo "  <th>$cell</th>" >> $REPORT_FILE
                        else
                                if [ $j -eq $STATUS_COL ]
                                then
                                        title_msg=`echo $line|awk -F${DELIMITER} '{print $'$num'}'`
                                        case "$cell" in
                                        "Running"|"Passed")
                                                # echo "  <td style=\"color:green\">$cell</td>" >> $REPORT_FILE
                                                echo "  <td style=\"color:green\">Passed</td>" >> $REPORT_FILE
                                                ;;
                                        *)
                                                echo "  <td style=\"color:red\" title=\"${title_msg}\">$cell</td>" >> $REPORT_FILE
                                                ;;
                                        # *)
                                                # echo "  <td>$cell</td>" >> $REPORT_FILE
                                                # ;;
                                        esac
                                else
                                        cell=`echo "$cell"|sed "s/  /\&emsp;\&emsp;/g"`
                                        echo "  <td>$cell</td>" >> $REPORT_FILE
                                fi
                        fi
                        j=`expr $j + 1`
                done
                echo "</tr>" >> $REPORT_FILE
                i=`expr $i + 1`
        done < $1

        echo "</tfoot>" >> $REPORT_FILE
        echo "</table>" >> $REPORT_FILE
        echo "</body>" >> $REPORT_FILE
        echo "</html>" >> $REPORT_FILE

        inf HTML report generated: $REPORT_FILE
}

get_cmd(){
#
# Set commands by type to check status
#
        cmd_type=$1
        cmd_entity=$2

        case ${type} in
                DockerVersion)
                        CMD="docker --version"
                        ;;
                KubeVersion)
                        CMD="kubectl version"
                        ;;
                NativeService)
                        CMD="systemctl status $cmd_entity"
                        ;;
                APIServer)
                        CMD="curl --tlsv1.2 --output ${TMP_FILE} --silent --head --fail --cacert ${CA_FILE} --cert ${CERT_FILE} --key ${KEY_FILE} https://${API_SERVER}:${SSH_API_PORT}"
                        ;;
                MngPortal)
                        CMD="curl --tlsv1.2 --noproxy ${EXTERNAL_ACCESS_HOST} --output /dev/null --silent --head --fail -k -w %{http_code}\"\n\" https://${EXTERNAL_ACCESS_HOST}:${SSH_PORTAL_PORT}"
                        ;;
                Etcd)
                        CMD=":"
                        ;;
                Vault)
                        CMD=":"
                        ;;
                Node)
                        CMD="for(( i=0;i<${#NODES[@]};i++ ));do echo \${NODES[\$i]};done"
                        ;;
                Pod)
                        CMD="kubectl get pods --all-namespaces -a --no-headers -o wide --sort-by='{.metadata.creationTimestamp}'"
                        ;;
                Deployment)
                        CMD="kubectl get deployment --all-namespaces --no-headers --show-all"
                        ;;
                Service)
                        CMD="kubectl get svc --all-namespaces --show-all --no-headers"
                        ;;
                RC)
                        CMD="kubectl get rc --all-namespaces --show-all --no-headers"
                        ;;
                DaemonSet)
                        CMD="kubectl get ds --all-namespaces --show-all --no-headers"
                        ;;
                Process)
                        CMD="ps -ef|grep \"\b${cmd_entity}\b\"|grep -v grep"
                        ;;
                Container)
                        local container_id=`docker ps -a|grep "\b${cmd_entity}\b"|awk '{print $1}'`
                        CMD="docker inspect -f {{.State.Running}} $container_id"
                        ;;
                Bootstrap)
                        CMD="docker -H unix:///var/run/docker-bootstrap.sock ps|grep \"\b${cmd_entity}\b\"|grep -v grep"
                        ;;
                K8SService)
                        CMD="${K8S_HOME}/bin/kube-${cmd_entity}.sh &"
                        ;;
                Ping)
                        CMD="kubectl get pods --all-namespaces --show-all -o wide --sort-by='{.metadata.creationTimestamp}'"
                        ;;
                *)
                        CMD="test 1 -eq 2"
                        ;;
        esac
}

checkEntityStatus(){
        local simple_mode=$1
        local type=$2
        local entity=$3
        unset status

        local check_start=`date +%s%N`

        if [ "$entity" = "all" ] || [ "$entity" = "byList" ]
        then
                echo "[${type}]"
        elif [ ! -z $3 ]
        then
                showName "[${type}] ${entity}"
        fi

        err_msg="Inactive"
        detail_msg=""

        #######################
        # Run command by type #
        #######################
        get_cmd $type $entity
        logger_info "Checking [${type}] ${entity}"
        logger_info "[CMD: ${CMD}] "
        eval ${CMD} >${TMP_FILE} 2>&1
        local ret=$?

        ###################################
        # Check status by type and entity #
        ###################################
        case ${type} in
                DockerVersion)
                        if [ $ret != 0 ]
                        then
                                detail_msg="Fail to get Docker version!"
                        else
                                docker_version=`cat ${TMP_FILE}|sed "s/.*\bversion \([0-9\.]*\)\b.*/\1/g"`
                                if [ -z "$docker_version" ]
                                then
                                        docker_version=unkonwn
                                fi
                                entity="Docker:v${docker_version}"
                        fi
                        ;;
                KubeVersion)
                        if [ $ret != 0 ]
                        then
                                detail_msg="Fail to get Kubernetes version!"
                        else
                                local client_ver=`cat ${TMP_FILE}|grep "Client Version:"|sed "s/.*\bGitVersion:\"v\([0-9\.]*\)\b.*/\1/g"`
                                if [ -z $client_ver ]
                                then
                                        client_ver=unkonwn
                                fi
                                local server_ver=`cat ${TMP_FILE}|grep "Server Version:"|sed "s/.*\bGitVersion:\"v\([0-9\.]*\)\b.*/\1/g"`
                                if [ -z $server_ver ]
                                then
                                        server_ver=unkonwn
                                fi
                                entity="Client:v${client_ver}  Server:v${server_ver}"
                        fi
                        ;;
                NativeService)
                        if [ $ret != 0 ]
                        then
                                LOADED_STATUS=`grep "Loaded:" ${TMP_FILE}|awk '{print $2}'`
                                ACTIVE_STATUS=`grep "Active:" ${TMP_FILE}|awk '{print $2}'`
                                detail_msg="Active: ${ACTIVE_STATUS} | Loaded: (${LOADED_STATUS})"
                        fi
                        ;;
                APIServer)
                        if [ -z $entity ]
                        then
                                entity="API Server - https://${API_SERVER}:${SSH_API_PORT}"
                        fi
                        if [ $ret != 0 ]
                        then
                                detail_msg="Fail to access URL: http://${API_SERVER}:${SSH_API_PORT}"
                        fi
                        ;;
                Etcd)
                        case "$entity" in
                                all)
                                        logger_info "check Etcd status. Simple mode: $simple_mode"
                                        local etcd_cluster=
                                        for node_node in $MASTER_NAME_LIST
                                        do
                                                local etcd_status=
                                                local etcd_url="https://${node_node}:${ETCD_ENDPOINT_PORT}"
                                                etcd_cluster=${etcd_cluster}${etcd_url}","
                                                showName "     ETCD on ${node_node}"

                                                ETCDCTL_API=2 etcdctl --no-sync --endpoint $etcd_url --ca-file=${CA_FILE} --cert-file=${CERT_FILE} --key-file=${KEY_FILE} get /coreos.com/network/config >${TMP_FILE} 2>&1

                                                if [[ "$?" == 0 ]]; then
                                                        etcd_status="Running"
                                                else
                                                        etcd_status="Missing"
                                                        ret=1
                                                fi

                                                logger_info "${entity} status is ${etcd_status}"
                                                if [ $simple_mode = n ]
                                                then
                                                        TOTAL_CASE=$((TOTAL_CASE+1))
                                                        if [ "$etcd_status" = "Running" ]
                                                        then
                                                                PASSED_CASE=$((PASSED_CASE+1))
                                                        else
                                                                detail_msg="Access ETCD ${etcd_url} error:`head -1 ${TMP_FILE}`"
                                                                FAILED_CASE=$((FAILED_CASE+1))
                                                        fi

                                                        showStatus ${etcd_status}
                                                        check_end=`date +%s%N`
                                                        check_duration=`echo $check_start $check_end| awk '{printf "%.2f", ($2-$1)/1000000000}'`
                                                        echo "${type}${DELIMITER}ETCD - ${etcd_url}${DELIMITER}${check_duration} secs${DELIMITER}${etcd_status}${DELIMITER}${detail_msg}" >> ${RESULT_FILE}
                                                fi
                                        done

                                        ETCD_ALARM=`ETCDCTL_API=3 etcdctl --endpoints=[${etcd_cluster}] --cacert ${CA_FILE} --cert ${CERT_FILE} --key ${KEY_FILE} alarm list 2>/dev/null`
                                        if [ $? -eq 0 -a -n "$ETCD_ALARM" ]; then
                                                showStatus "     Warning: ${ETCD_ALARM}"
                                        fi

                                        if [ $simple_mode = y ]
                                        then
                                                logger_info "<simple_mode> etcd_status: $etcd_status"
                                                logger_info
                                                return $ret
                                        fi
                                        ;;
                                *)
                                        status=Ignored
                                        ;;
                        esac
                        ;;
                Vault)
                        case "$entity" in
                                all)
                                        logger_info "check vault status. Simple mode: $simple_mode"
                                        for node_node in $MASTER_NAME_LIST
                                        do
                                                local vault_status=
                                                local vault_url="https://${node_node}:8200/v1/sys/health"
                                                showName "     Vault on $node_node"

                                                local return_code=`curl --connect-timeout 5 --tlsv1.2 -s -o /dev/null -w %{http_code} -X GET $vault_url -k` 2>/dev/null

                                                if [[ "$return_code" == "200" ]] || [[ "$return_code" == "429" ]]; then
                                                        vault_status="Running"
                                                else
                                                        vault_status="Missing"
                                                        ret=1
                                                fi

                                                logger_info "${entity} status is ${vault_status}"
                                                if [ $simple_mode = n ]
                                                then
                                                        TOTAL_CASE=$((TOTAL_CASE+1))
                                                        if [ "$vault_status" = "Running" ]
                                                        then
                                                                PASSED_CASE=$((PASSED_CASE+1))
                                                        else
                                                                detail_msg="Access Vault ${vault_url} return code: $return_code"
                                                                FAILED_CASE=$((FAILED_CASE+1))
                                                        fi

                                                        showStatus ${vault_status}
                                                        check_end=`date +%s%N`
                                                        check_duration=`echo $check_start $check_end| awk '{printf "%.2f", ($2-$1)/1000000000}'`
                                                        echo "${type}${DELIMITER}${vault_url}${DELIMITER}${check_duration} secs${DELIMITER}${vault_status}${DELIMITER}${detail_msg}" >> ${RESULT_FILE}
                                                fi
                                        done

                                        if [ $simple_mode = y ]
                                        then
                                                logger_info "<simple_mode> vault_status: $vault_status"
                                                logger_info
                                                return $ret
                                        fi
                                        ;;
                                *)
                                        status=Ignored
                                        ;;
                        esac
                        ;;
                Process)
                        if [ $ret != 0 ]
                        then
                                detail_msg="Not found Process: ${entity}"
                        fi
                        ;;
                Container)
                        if [ $ret != 0 ]
                        then
                                detail_msg="Not found container: ${entity}"
                        fi
                        ;;
                K8SService)
                        while [ 1 ]
                        do
                                ps -ef|grep "kube-${entity}\.sh" > /dev/null 2>&1
                                if [ $? != 0 ]
                                then
                                        break
                                fi
                                waiting
                        done

                        if [ $ret != 0 ]
                        then
                                detail_msg="${entity} K8SService failed!"
                        else
                                case "$entity" in
                                restart | start)
                                        waitKubeStarted
                                        if [ "$kube_started" = "y" ]
                                        then
                                                status="Passed"
                                                ret=0
                                        else
                                                err_msg="Failed"
                                                detail_msg="$entity K8S failed!"
                                                ret=1
                                        fi
                                        ;;
                                stop)
                                        getKubeStatus >/dev/null 2>&1
                                        if [ "$kube_started" = "n" ]
                                        then
                                                status="Passed"
                                                ret=0
                                        else
                                                err_msg="Failed"
                                                detail_msg="Stop K8S failed!"
                                                ret=1
                                        fi
                                        ;;
                                *)
                                        logger_err "unknown K8Service operation: $entity"
                                        ;;
                                esac
                        fi
                        ;;
                Node)
                        if [ $ret != 0 ]
                        then
                                detail_msg="Get nodes failed!"
                                unset entity
                        else
                                case $entity in
                                byList)
                                        old_IFS=$IFS
                                        IFS=$'\n'
                                        for node in `cat ${TMP_FILE}`
                                        do
                                                IFS=$old_IFS
                                                node_name=$(echo $node|awk -F"#" '{print $1}')
                                                node_type=$(echo $node|awk -F"#" '{print $2}')
                                                node_status=$(echo $node|awk -F"#" '{print $3}')
                                                detail_msg=""
                                                TOTAL_CASE=$((TOTAL_CASE+1))

                                                if [ -z $node_status ]
                                                then
                                                        node_status="Missing"
                                                fi

                                                if [ "$node_status" != "Ready" ]
                                                then
                                                        detail_msg="${node_type} node '${node_name}' is ${node_status}"
                                                        FAILED_CASE=$((FAILED_CASE+1))
                                                        ret=1
                                                else
                                                        node_status="Running"
                                                        PASSED_CASE=$((PASSED_CASE+1))
                                                fi

                                                showName "     ($node_type) ${node_name}"
                                                showStatus ${node_status}
                                                logger_info "${node_type} node '${node_name}' is ${node_status}"
                                                check_end=`date +%s%N`
                                                check_duration=`echo $check_start $check_end| awk '{printf "%.2f", ($2-$1)/1000000000}'`
                                                echo "${type}${DELIMITER}($node_type) ${node_name}${DELIMITER}${check_duration} secs${DELIMITER}${node_status}${DELIMITER}${detail_msg}" >> ${RESULT_FILE}
                                        done
                                        IFS=$old_IFS
                                        ;;
                                *)
                                        cnt=`grep $entity ${TMP_FILE}|wc -l`
                                        if [ $cnt = 0 ]
                                        then
                                                err_msg="Not found"
                                                detail_msg="Not found node: $entity"
                                                ret=1
                                        else
                                                ret=`grep $entity ${TMP_FILE}|grep -v Running|wc -l`
                                                if [ $ret != 0 ]
                                                then
                                                        detail_msg="$entity status: `grep $entity ${TMP_FILE}|grep -v Running|head -1`"
                                                fi
                                        fi
                                        ;;
                                esac
                        fi
                        ;;
                Bootstrap)
                        if [ $ret != 0 ]
                        then
                                detail_msg="Not found Bootstrap container: ${entity}"
                        fi
                        ;;
                MngPortal)
                        local portal_url="https://${EXTERNAL_ACCESS_HOST}:${SSH_PORTAL_PORT}"

                        if [ $ret != 0 ]
                        then
                                curl --tlsv1.2 --noproxy ${EXTERNAL_ACCESS_HOST} --output /dev/null --silent --head --fail --connect-timeout 10 -k -w %{http_code}"\n" ${portal_url} >${TMP_FILE} 2>&1
                                ret=$?
                        fi

                        if [ $ret != 0 ]
                        then
                                detail_msg="Access management portal error: http-code `head -1 ${TMP_FILE}`"
                        fi

                        entity="URL: $portal_url"
                        ;;
                Pod)
                        PODS=()
                        if [ $ret != 0 ]
                        then
                                unset entity
                                detail_msg="Fail to get pods on server ${LOCAL_IP}"
                        else
                                case $entity in
                                all)
                                        logger_info "check all Pod (simple_mode=$simple_mode) ..."
                                        old_IFS=$IFS
                                        IFS=$'\n'
                                        for pod_line in `grep -v "info:" ${TMP_FILE}`
                                        do
                                                IFS=$old_IFS
                                                detail_msg=""
                                                pod_namespace=`echo $pod_line|awk '{print $1}'`
                                                pod_name=`echo $pod_line|awk '{print $2}'`
                                                pod_status=`echo $pod_line|awk '{print $4}'`

                                                logger_info "(${pod_namespace}) ${pod_name} is ${pod_status}"
                                                if [ $simple_mode = n ]
                                                then
                                                        TOTAL_CASE=$((TOTAL_CASE+1))
                                                        if [ "${pod_status}" != "Running" ]
                                                        then
                                                                detail_msg="Pod '${pod_name}' is ${pod_status}"
                                                                ret=1
                                                                FAILED_CASE=$((FAILED_CASE+1))
                                                        else
                                                                PASSED_CASE=$((PASSED_CASE+1))
                                                        fi
                                                        showName "     (${pod_namespace}) ${pod_name}"
                                                        showStatus ${pod_status}
                                                        check_end=`date +%s%N`
                                                        check_duration=`echo $check_start $check_end| awk '{printf "%.2f", ($2-$1)/1000000000}'`
                                                        echo "${type}${DELIMITER}(${pod_namespace}) ${pod_name}${DELIMITER}${check_duration} secs${DELIMITER}${pod_status}${DELIMITER}${detail_msg}" >> ${RESULT_FILE}
                                                else
                                                        if [ "${pod_status}" != "Running" ]
                                                        then
                                                                ret=1
                                                        fi
                                                fi
                                        done
                                        IFS=$old_IFS

                                        if [ $simple_mode = y ]
                                        then
                                                logger_info "check all Pods in simple mode return: $ret"
                                                logger_info
                                                return $ret
                                        fi
                                        ;;
                                byList)
                                        local list_name=$4
                                        local pod_tmp=/tmp/checkStatus_pod.tmp
                                        logger_info "check Pod (simple_mode=$simple_mode) by list: $list_name"
                                        > $pod_tmp
                                        old_IFS=$IFS
                                        IFS=$'\n'
                                        eval "for pod_line in \$$list_name; do echo \$pod_line >> \$pod_tmp; done"

                                        # for pod_info in $POD_LIST
                                        for pod_info in `cat $pod_tmp`
                                        do
                                                IFS=$old_IFS
                                                pod_namespace=`echo $pod_info|awk '{print $1}'`
                                                pod_prefix=`echo $pod_info|awk '{print $2}'`
                                                pod_tocheck=`echo $pod_info|awk '{print $3}'`

                                                case "$pod_tocheck" in
                                                "_master")
                                                        POD_NODES="$MASTER_NAME_LIST"
                                                        ;;
                                                "_node"|"_node_nopost")
                                                        POD_NODES="$MASTER_NAME_LIST $WORKER_NAME_LIST"
                                                        ;;
                                                *)
                                                        POD_NODES="$pod_prefix"
                                                        ;;
                                                esac


                                                POD_NODES=`echo $POD_NODES|sed 's/^[[:space:]]*//g'`
                                                for pod_node in $POD_NODES
                                                do
                                                        local node_name=$pod_node
                                                        detail_msg=""
                                                        if [ "${pod_tocheck}" = "_single" ] || [ "${pod_tocheck}" = "_node_nopost" ]
                                                        then
                                                                pod_name=`grep $pod_namespace ${TMP_FILE}|grep "\sRunning\s"|grep "$pod_node"|awk '{print $2}'|\
                                                                grep "^${pod_prefix}\(-[0-9a-zA-Z]\+-[a-z0-9]\{5\}$\|-[a-z0-9]\{5\}$\|$\)"|head -1`

                                                                if [ -z "$pod_name" ]
                                                                then
                                                                        pod_name=`grep $pod_namespace ${TMP_FILE}|grep "$pod_node"|awk '{print $2}'|\
                                                                        grep "^${pod_prefix}\(-[0-9a-zA-Z]\+-[a-z0-9]\{5\}$\|-[a-z0-9]\{5\}$\|$\)"|tail -1`
                                                                        if [ -z "$pod_name" ]
                                                                        then
                                                                                pod_name=$pod_prefix
                                                                        fi
                                                                fi

                                                                if [ "${pod_tocheck}" = "_single" ]
                                                                then
                                                                        node_name=`grep $pod_namespace ${TMP_FILE}|grep "\s${pod_name}\s"|awk '{print $8}'`
                                                                fi

                                                                node_name=${node_name:-"_unknown"}
                                                        else
                                                                pod_name=${pod_prefix}-$pod_node
                                                        fi

                                                        pod_status=`grep $pod_namespace ${TMP_FILE}|grep "\s${pod_name}\s"|awk '{print $4}'`
                                                        if [ -z "${pod_status}" ]
                                                        then
                                                                pod_status="Missing"
                                                        fi

                                                        logger_info "pod_name=$pod_name, pod_status=$pod_status, simple_mode=$simple_mode"
                                                        if [ $simple_mode = n ]
                                                        then
                                                                TOTAL_CASE=$((TOTAL_CASE+1))
                                                                if [ "${pod_status}" = "Running" ]
                                                                then
                                                                        PASSED_CASE=$((PASSED_CASE+1))
                                                                else
                                                                        detail_msg="Pod '${pod_name}' is ${pod_status}"
                                                                        FAILED_CASE=$((FAILED_CASE+1))
                                                                        ret=1
                                                                fi

                                                                check_end=`date +%s%N`
                                                                check_duration=`echo $check_start $check_end| awk '{printf "%.2f", ($2-$1)/1000000000}'`
                                                                PODS+=("${pod_namespace}${DELIMITER}${pod_name}${DELIMITER}${pod_status}${DELIMITER}${node_name}")
                                                                echo "${type}${DELIMITER}(${pod_namespace}) ${pod_name}${DELIMITER}${check_duration} secs${DELIMITER}${pod_status}${DELIMITER}${detail_msg}" >> ${RESULT_FILE}
                                                        else
                                                                if [ "${pod_status}" != "Running" ]
                                                                then
                                                                        ret=1
                                                                fi
                                                        fi
                                                done

                                        done
                                        IFS=$old_IFS
                                        rm -f $pod_tmp

                                        if [ $simple_mode = n ]
                                        then
                                                local count_n=${#NODES[@]}
                                                for (( i=0; i<count_n; i++ ))
                                                do
                                                        node_name=$(echo ${NODES[$i]}|awk -F"#" '{print $1}')
                                                        echo "   <${node_name}>"
                                                        local count_p=${#PODS[@]}
                                                        if [ $count_p -eq 0 ]
                                                        then
                                                                echo "     (no pods)"
                                                        fi
                                                        for (( j=0; j<count_p; j++ ))
                                                        do
                                                                if [ "$node_name" = "$(echo ${PODS[j]}|awk -F"${DELIMITER}" '{print $4}')" ]
                                                                then
                                                                        pod_namespace=`echo ${PODS[j]}|awk -F"${DELIMITER}" '{print $1}'`
                                                                        pod_name=`echo ${PODS[j]}|awk -F"${DELIMITER}" '{print $2}'`
                                                                        pod_status=`echo ${PODS[j]}|awk -F"${DELIMITER}" '{print $3}'`
                                                                        showName "     (${pod_namespace}) ${pod_name}"
                                                                        showStatus ${pod_status}
                                                                fi
                                                        done

                                                done

                                                showed_title=n
                                                for (( j=0; j<count_p; j++ ))
                                                do
                                                        if [ "$(echo ${PODS[j]}|awk -F"${DELIMITER}" '{print $4}')" = "_unknown" ]
                                                        then
                                                                if [ $showed_title = n ]
                                                                then
                                                                        echo "   <unknown node>"
                                                                        showed_title=y
                                                                fi
                                                                pod_namespace=`echo ${PODS[j]}|awk -F"${DELIMITER}" '{print $1}'`
                                                                pod_name=`echo ${PODS[j]}|awk -F"${DELIMITER}" '{print $2}'`
                                                                pod_status=`echo ${PODS[j]}|awk -F"${DELIMITER}" '{print $3}'`
                                                                showName "     (${pod_namespace}) ${pod_name}"
                                                                showStatus ${pod_status}
                                                        fi
                                                done
                                        else
                                                logger_info "check Pods in simple mode return: $ret"
                                                logger_info
                                                return $ret
                                        fi

                                        ;;
                                *)
                                        cnt=`grep $entity ${TMP_FILE}|wc -l`
                                        if [ $cnt = 0 ]
                                        then
                                                err_msg="Not found"
                                                detail_msg="Not found pod: $entity"
                                                ret=1
                                        else
                                                ret=`grep $entity ${TMP_FILE}|grep -v Running|wc -l`
                                                if [ $ret != 0 ]
                                                then
                                                        detail_msg="$entity status: `grep $entity ${TMP_FILE}|grep -v Running|head -1`"
                                                fi
                                        fi
                                        ;;
                                esac
                        fi
                        ;;
                Deployment)
                        if [ $ret != 0 ]
                        then
                                detail_msg="Fail to get Deployment Controllers on server ${LOCAL_IP}"
                                unset entity
                        else
                                case $entity in
                                byList)
                                        old_IFS=$IFS
                                        IFS=$'\n'
                                        local list_name=$4
                                        local deployment_tmp=/tmp/checkStatus_deployment.tmp
                                        logger_info "check Deployment (simple_mode=$simple_mode) by list: $list_name"
                                        > $deployment_tmp
                                        old_IFS=$IFS
                                        IFS=$'\n'
                                        eval "for deployment_line in \$$list_name; do echo \$deployment_line >> \$deployment_tmp; done"
                                        for dm_info in `cat $deployment_tmp`
                                        do
                                                detail_msg=""
                                                TOTAL_CASE=$((TOTAL_CASE+1))
                                                IFS=$old_IFS
                                                dm_namespace=`echo $dm_info|awk '{print $1}'`
                                                dm_name=`echo $dm_info|awk '{print $2}'`

                                                grep $dm_namespace ${TMP_FILE}|awk '{print $2}'|grep "^${dm_name}$" 1>/dev/null 2>&1
                                                if [ $? != 0 ]
                                                then
                                                        dm_status="Missing"
                                                        detail_msg="Deployment '${dm_name}' is ${dm_status}"
                                                        FAILED_CASE=$((FAILED_CASE+1))
                                                else
                                                        dm_item=`grep $dm_namespace ${TMP_FILE} | grep "${dm_name}" 2>/dev/null`
                                                        dm_desired=`echo $dm_item|awk '{print $3}'`
                                                        dm_available=`echo $dm_item|awk '{print $6}'`
                                                        dm_status="${dm_available}/${dm_desired}"
                                                        if [ $dm_available -lt $dm_desired ]; then
                                                                FAILED_CASE=$((FAILED_CASE+1))
                                                        else
                                                                PASSED_CASE=$((PASSED_CASE+1))
                                                        fi
                                                fi

                                                showName "     (${dm_namespace}) ${dm_name}"
                                                showStatus ${dm_status}
                                                logger_info "(${dm_namespace}) ${dm_name} is ${dm_status}"
                                                check_end=`date +%s%N`
                                                check_duration=`echo $check_start $check_end| awk '{printf "%.2f", ($2-$1)/1000000000}'`
                                                echo "${type}${DELIMITER}(${dm_namespace}) ${dm_name}${DELIMITER}${check_duration} secs${DELIMITER}${dm_status}${DELIMITER}${detail_msg}" >> ${RESULT_FILE}
                                        done
                                        IFS=$old_IFS
                                        rm -f $deployment_tmp
                                        ;;
                                *)
                                        cnt=`grep $entity ${TMP_FILE}|wc -l`
                                        if [ $cnt = 0 ]
                                        then
                                                err_msg="Not found"
                                                detail_msg="Not found pod: $entity"
                                                ret=1
                                        else
                                                ret=`grep $entity ${TMP_FILE}|grep -v Running|wc -l`
                                                if [ $ret != 0 ]
                                                then
                                                        detail_msg="$entity status: `grep $entity ${TMP_FILE}|grep -v Running|head -1`"
                                                fi
                                        fi
                                        ;;
                                esac
                        fi
                        ;;
                Service)
                        if [ $ret != 0 ]
                        then
                                detail_msg="Fail to get service on server ${LOCAL_IP}"
                                unset entity
                        else
                                case $entity in
                                byList)
                                        local list_name=$4
                                        local svc_tmp=/tmp/checkStatus_svc.tmp
                                        logger_info "check Service (simple_mode=$simple_mode) by list: $list_name"
                                        > $svc_tmp
                                        old_IFS=$IFS
                                        IFS=$'\n'
                                        eval "for svc_line in \$$list_name; do echo \$svc_line >> \$svc_tmp; done"
                                        old_IFS=$IFS
                                        IFS=$'\n'
                                        for service_info in `cat $svc_tmp`
                                        do
                                                detail_msg=""
                                                TOTAL_CASE=$((TOTAL_CASE+1))
                                                IFS=$old_IFS
                                                service_namespace=`echo $service_info|awk '{print $1}'`
                                                service_name=`echo $service_info|awk '{print $2}'`

                                                grep $service_namespace ${TMP_FILE}|awk '{print $2}'|grep "^${service_name}$" 1>/dev/null 2>&1
                                                if [ $? != 0 ]
                                                then
                                                        service_status="Missing"
                                                        detail_msg="Service '${service_name}' is ${service_status}"
                                                        FAILED_CASE=$((FAILED_CASE+1))
                                                else
                                                        service_status="Running"
                                                        PASSED_CASE=$((PASSED_CASE+1))
                                                fi

                                                showName "     (${service_namespace}) ${service_name}"
                                                showStatus ${service_status}
                                                logger_info "(${service_namespace}) ${service_name} is ${service_status}"
                                                check_end=`date +%s%N`
                                                check_duration=`echo $check_start $check_end| awk '{printf "%.2f", ($2-$1)/1000000000}'`
                                                echo "${type}${DELIMITER}(${service_namespace}) ${service_name}${DELIMITER}${check_duration} secs${DELIMITER}${service_status}${DELIMITER}${detail_msg}" >> ${RESULT_FILE}
                                        done
                                        IFS=$old_IFS
                                        rm -f $svc_tmp
                                        ;;
                                *)
                                        cnt=`grep $entity ${TMP_FILE}|wc -l`
                                        if [ $cnt = 0 ]
                                        then
                                                err_msg="Not found"
                                                detail_msg="Not found pod: $entity"
                                                ret=1
                                        else
                                                ret=`grep $entity ${TMP_FILE}|grep -v Running|wc -l`
                                                if [ $ret != 0 ]
                                                then
                                                        detail_msg="$entity status: `grep $entity ${TMP_FILE}|grep -v Running|head -1`"
                                                fi
                                        fi
                                        ;;
                                esac
                        fi
                        ;;
                RC)
                        if [ $ret != 0 ]
                        then
                                detail_msg="Fail to get Replication Controllers on server ${LOCAL_IP}"
                                unset entity
                        else
                                case $entity in
                                byList)
                                        old_IFS=$IFS
                                        IFS=$'\n'
                                        for rc_info in $RC_LIST
                                        do
                                                detail_msg=""
                                                TOTAL_CASE=$((TOTAL_CASE+1))
                                                IFS=$old_IFS
                                                rc_namespace=`echo $rc_info|awk '{print $1}'`
                                                rc_name=`echo $rc_info|awk '{print $2}'`

                                                grep $rc_namespace ${TMP_FILE}|awk '{print $2}'|grep "^${rc_name}$" 1>/dev/null 2>&1
                                                if [ $? != 0 ]
                                                then
                                                        rc_status="Missing"
                                                        detail_msg="Replication Controller '${rc_name}' is ${rc_status}"
                                                        FAILED_CASE=$((FAILED_CASE+1))
                                                else
                                                        rc_status="Running"
                                                        PASSED_CASE=$((PASSED_CASE+1))
                                                fi

                                                showName "     (${rc_namespace}) ${rc_name}"
                                                showStatus ${rc_status}
                                                logger_info "(${rc_namespace}) ${rc_name} is ${rc_status}"
                                                check_end=`date +%s%N`
                                                check_duration=`echo $check_start $check_end| awk '{printf "%.2f", ($2-$1)/1000000000}'`
                                                echo "${type}${DELIMITER}(${rc_namespace}) ${rc_name}${DELIMITER}${check_duration} secs${DELIMITER}${rc_status}${DELIMITER}${detail_msg}" >> ${RESULT_FILE}
                                        done
                                        IFS=$old_IFS
                                        ;;
                                *)
                                        cnt=`grep $entity ${TMP_FILE}|wc -l`
                                        if [ $cnt = 0 ]
                                        then
                                                err_msg="Not found"
                                                detail_msg="Not found pod: $entity"
                                                ret=1
                                        else
                                                ret=`grep $entity ${TMP_FILE}|grep -v Running|wc -l`
                                                if [ $ret != 0 ]
                                                then
                                                        detail_msg="$entity status: `grep $entity ${TMP_FILE}|grep -v Running|head -1`"
                                                fi
                                        fi
                                        ;;
                                esac
                        fi
                        ;;
                DaemonSet)
                        if [ $ret != 0 ]
                        then
                                detail_msg="Fail to get Daemonset Controllers on server ${LOCAL_IP}"
                                unset entity
                        else
                                case $entity in
                                byList)
                                        old_IFS=$IFS
                                        IFS=$'\n'
                                        for ds_info in $DS_LIST
                                        do
                                                detail_msg=""
                                                TOTAL_CASE=$((TOTAL_CASE+1))
                                                IFS=$old_IFS
                                                ds_namespace=`echo $ds_info|awk '{print $1}'`
                                                ds_name=`echo $ds_info|awk '{print $2}'`

                                                grep $ds_namespace ${TMP_FILE}|awk '{print $2}'|grep "^${ds_name}$" 1>/dev/null 2>&1
                                                if [ $? != 0 ]
                                                then
                                                        ds_status="Missing"
                                                        detail_msg="DaemonSet '${ds_name}' is ${ds_status}"
                                                        FAILED_CASE=$((FAILED_CASE+1))
                                                else
                                                        ds_item=`grep $ds_namespace ${TMP_FILE} | grep "${ds_name}" 2>/dev/null`
                                                        ds_desired=`echo $ds_item|awk '{print $3}'`
                                                        ds_available=`echo $ds_item|awk '{print $7}'`
                                                        ds_status="${ds_available}/${ds_desired}"
                                                        if [ $ds_available -lt $ds_desired ]; then
                                                                FAILED_CASE=$((FAILED_CASE+1))
                                                        else
                                                                PASSED_CASE=$((PASSED_CASE+1))
                                                        fi
                                                fi

                                                showName "     (${ds_namespace}) ${ds_name}"
                                                showStatus ${ds_status}
                                                logger_info "(${ds_namespace}) ${ds_name} is ${ds_status}"
                                                check_end=`date +%s%N`
                                                check_duration=`echo $check_start $check_end| awk '{printf "%.2f", ($2-$1)/1000000000}'`
                                                echo "${type}${DELIMITER}(${ds_namespace}) ${ds_name}${DELIMITER}${check_duration} secs${DELIMITER}${ds_status}${DELIMITER}${detail_msg}" >> ${RESULT_FILE}
                                        done
                                        IFS=$old_IFS
                                        ;;
                                *)
                                        cnt=`grep $entity ${TMP_FILE}|wc -l`
                                        if [ $cnt = 0 ]
                                        then
                                                err_msg="Not found"
                                                detail_msg="Not found pod: $entity"
                                                ret=1
                                        else
                                                ret=`grep $entity ${TMP_FILE}|grep -v Running|wc -l`
                                                if [ $ret != 0 ]
                                                then
                                                        detail_msg="$entity status: `grep $entity ${TMP_FILE}|grep -v Running|head -1`"
                                                fi
                                        fi
                                        ;;
                                esac
                        fi
                        ;;
                Ping)
                        if [ $ret != 0 ]
                        then
                                detail_msg="Fail to get pods on server ${LOCAL_IP}"
                        else
                                local mngPortal_pod=`grep "\sRunning\s" ${TMP_FILE}|awk '{print $2}'|grep "^mng-portal\(-[0-9a-zA-Z]\+-[a-z0-9]\{5\}$\|-[a-z0-9]\{5\}$\|$\)"|head -1`
                                if [ -z $mngPortal_pod ]
                                then
                                        err_msg="noMngPortal"
                                        detail_msg="No running base pod: mng-portal"
                                        ret=1
                                else
                                        mngPortal_node_ip=`grep "\s${mngPortal_pod}\s" ${TMP_FILE}|awk '{print $8}'`
                                        mngPortal_ns=`grep "\s${mngPortal_pod}\s" ${TMP_FILE}|awk '{print $1}'`
                                        local ping_pod_name=`grep "\sRunning\s" ${TMP_FILE}|grep -v "${mngPortal_node_ip}"|awk '{print $2}'|grep "^${entity}\b"|head -1`
                                        if [ -z $ping_pod_name ]
                                        then
                                                status="Ignored"
                                                detail_msg="No pod $entity running on different node from the one where management portal locates"
                                        else
                                                ping_pod_ip=`grep "\s${ping_pod_name}\s" ${TMP_FILE}|awk '{print $7}'`
                                                kubectl exec -ti ${mngPortal_pod} --namespace=${mngPortal_ns} -- ping -c 1 ${ping_pod_ip} > /dev/null 2>&1
                                                if [ $? = 0 ]
                                                then
                                                        status="Passed"
                                                else
                                                        err_msg="Unreachable"
                                                        detail_msg="Destination Host ${ping_pod_name}(${ping_pod_ip}) Unreachable"
                                                        ret=1
                                                fi
                                        fi
                                fi
                        fi
                        ;;
                *)
                        err_msg="invalid type"
                        detail_msg="Not support type: ${type}"
                        ;;
        esac

        #
        # print single entity status
        #
        if [ "$entity" != "all" ] && [ "$entity" != "byList" ]
        then
                if [ $simple_mode = y ]
                then
                        logger_info "checking $type in simple mode returns: $ret"
                        logger_info
                        return $ret
                else
                        if [ -z $3 ]
                        then
                                showName "[${type}] ${entity}"
                        fi
                        TOTAL_CASE=$((TOTAL_CASE+1))
                        if [ $ret = 0 ]
                        then
                                status=${status:-"Running"}
                                logger_info [${type}] ${entity} is ${status}
                                if [ "$status" = "Ignored" ]
                                then
                                        IGNORED_CASE=$((IGNORED_CASE+1))
                                        logger_info detailed: ${detail_msg}
                                else
                                        PASSED_CASE=$((PASSED_CASE+1))
                                fi
                        else
                                FAILED_CASE=$((FAILED_CASE+1))
                                status=${err_msg}
                                logger_err [${type}] ${entity} is ${status}
                                logger_err detailed: ${detail_msg}
                                logger_err
                        fi
                        showStatus ${status}

                        check_end=`date +%s%N`
                        check_duration=`echo $check_start $check_end| awk '{printf "%.2f", ($2-$1)/1000000000}'`
                        echo "${type}${DELIMITER}${entity}${DELIMITER}${check_duration} secs${DELIMITER}${status}${DELIMITER}${detail_msg}" >> ${RESULT_FILE}
                fi
        fi
        logger_info
}

setNodeList(){
#
# Get nodes_list, master_list, worker_list
# node_list contains "node_name#type#status"
# master_list, workerlist including a name_list and an ip_list
#
        MASTER_IP_LIST=
        WORKER_IP_LIST=
        MASTER_NAME_LIST=
        WORKER_NAME_LIST=
        NODES=()
        local node_ip=
        local node_name=
        local node_status=
        local node_tmp=/tmp/checkStatus_node.tmp
        local nodeStatus_tmp=/tmp/checkStatus_nodeStatus.tmp

        > $node_tmp
        > $nodeStatus_tmp

        kubectl get nodes -a -o=custom-columns=NAME:.metadata.name,IP:.status.addresses[0].address,LABELS:.metadata.labels --no-headers > $node_tmp 2>/dev/null
        kubectl get nodes -a --no-headers > $nodeStatus_tmp 2>&1

        inf Get Node IP addresses ...

        if [ "$AUTOTEST_201706" = y ]
        then
        #
        # Set node list from predefined MASTER_NODES and WORKER_NODES
        #
                for masterNode in $MASTER_NODES
                do
                        node_ip=`ping -c 1 ${masterNode} 2>/dev/null|grep -o -E '([0-9]*\.){3}[0-9]*'|head -1`
                        if [ -z $node_ip ]
                        then
                                node_name=${masterNode}
                        else
                                node_name=`cat $node_tmp|grep "\s$node_ip\s"|awk '{print $1}'`
                                if [ "$LOCAL_IP" = "$node_ip" ]
                                then
                                        isMaster=y
                                fi
                        fi
                        node_name=${node_name:-$node_ip}
                        MASTER_IP_LIST="${MASTER_IP_LIST} ${node_ip}"
                        MASTER_NAME_LIST="${MASTER_NAME_LIST} ${node_name}"
                done

                for workerNode in $WORKER_NODES
                do
                        node_ip=`ping -c 1 ${workerNode} 2>/dev/null|grep -o -E '([0-9]*\.){3}[0-9]*'|head -1`
                        if [ -z $node_ip ]
                        then
                                node_name=${workerNode}
                        else
                                node_name=`cat $node_tmp|grep "\s$node_ip\s"|awk '{print $1}'`
                        fi
                        node_name=${node_name:-$node_ip}
                        WORKER_IP_LIST="${WORKER_IP_LIST} ${node_ip}"
                        WORKER_NAME_LIST="${WORKER_NAME_LIST} ${node_name}"
                done
        else
        #
        # Get node list by 'kubectl get nodes' command
        #
                old_IFS=$IFS
                IFS=$'\n'
                for node in `cat $node_tmp`
                do
                        IFS=$old_IFS
                        node_name=$(echo $node|awk '{print $1}')
                        node_ip=$(echo $node|awk '{print $2}')
                        echo $node|grep "master:true" >/dev/null 2>&1
                        if [ $? = 0 ]
                        then
                                MASTER_NAME_LIST="${MASTER_NAME_LIST} ${node_name}"
                                MASTER_IP_LIST="${MASTER_IP_LIST} ${node_ip}"
                                if [ "$LOCAL_IP" = "$node_ip" ]
                                then
                                        isMaster=y
                                fi
                        else
                                WORKER_NAME_LIST="${WORKER_NAME_LIST} ${node_name}"
                                WORKER_IP_LIST="${WORKER_IP_LIST} ${node_ip}"
                        fi
                done
                IFS=$old_IFS
        fi
        MASTER_IP_LIST=`echo $MASTER_IP_LIST|sed 's/^[[:space:]]*//g'`
        WORKER_IP_LIST=`echo $WORKER_IP_LIST|sed 's/^[[:space:]]*//g'`
        MASTER_NAME_LIST=`echo $MASTER_NAME_LIST|sed 's/^[[:space:]]*//g'`
        WORKER_NAME_LIST=`echo $WORKER_NAME_LIST|sed 's/^[[:space:]]*//g'`

        for node_name in $MASTER_NAME_LIST
        do
                node_status=`cat $nodeStatus_tmp|grep "^$node_name\s"|awk '{print $2}'`
                NODES+=("${node_name}#Master#${node_status}")
        done

        for node_name in $WORKER_NAME_LIST
        do
                node_status=`cat $nodeStatus_tmp|grep "^$node_name\s"|awk '{print $2}'`
                NODES+=("${node_name}#Worker#${node_status}")
        done

        if [ ${#NODES[@]} -eq 0 ]
        then
                err Not able to get nodes!
                rm -f $node_tmp
                rm -f $nodeStatus_tmp
                exit 1
        fi

        inf

        inf "Master servers:  $MASTER_NAME_LIST"
        inf "Worker servers:  $WORKER_NAME_LIST"
        inf

        if [ $(echo ${MASTER_IP_LIST}|awk '{print NF}') -eq 0 ] && [ $(echo ${WORKER_IP_LIST}|awk '{print NF}') -eq 0 ]
        then
                err Not able to get nodes IP!
                rm -f $node_tmp
                rm -f $nodeStatus_tmp
                exit 1
        fi


        rm -f $node_tmp
        rm -f $nodeStatus_tmp
}

waitKubeStarted(){
#
# wait for K8S getting ready by checking APIServer/Portal/SuiteInstaller and if started
#
        logger_info "Waiting for Kubernetes getting ready ..."
        checkKube_start=`date +%s%N`

        kube_started=n

        logger_info "Waiting for APIServer, Portal Management and SuiteInstaller ... "
        http_status="Inactive"
        checkKube_duration=0
        while [ $checkKube_duration -lt $WAIT_TIMEOUT ] && [ "$kube_started" != "y" ]
        do
                waiting
                if [ "$http_status" != "Running" ]
                then
                        apiHTTPcode=`curl --tlsv1.2 --output /dev/null -k --silent --fail --head -w %{http_code}"\n" https://${API_SERVER}:${SSH_API_PORT}`
                        portalHTTPcode=`curl --tlsv1.2 --output /dev/null -k --silent --fail --head -w %{http_code}"\n" https://${EXTERNAL_ACCESS_HOST}:${SSH_PORTAL_PORT}`
                        suiteHTTPcode=`curl --tlsv1.2 --output /dev/null -k --silent --fail --head -w %{http_code}"\n" https://${EXTERNAL_ACCESS_HOST}:${SSH_PORTAL_PORT}/suiteInstaller/suite-installer.html`
                        if [ "$apiHTTPcode" != "000" ] && [ "$portalHTTPcode" = "200" ] && [ "$suiteHTTPcode" = "403" ]
                        then
                                http_status="Running"
                                logger_info "APIServer, Portal Management and SuiteInstaller are running"
                                logger_info
                                logger_info "Waiting for Kubernetes started ..."
                        fi
                else
                        getKubeStatus >/dev/null 2>&1
                fi

                checkKube_current=`date +%s%N`
                checkKube_duration=`echo $checkKube_start $checkKube_current| awk '{printf "%d", ($2-$1)/1000000000}'`
                # sleep 1
                waiting
        done

        if [ "$kube_started" != "y" ]
        then
                logger_err "Waiting Kubernetes started timeout after $WAIT_TIMEOUT seconds!"
                logger_err "apiHTTPcode=$apiHTTPcode, portalHTTPcode=$portalHTTPcode, suiteHTTPcode=$suiteHTTPcode, http_status=$http_status, kube_started=$kube_started"
        fi
}

getKubeStatus() {
#
# get a rough K8S status
#
        logger_info "Checking if Kubernetes started ..."

        kube_started=n

        local result=0
        checkEntityStatus y NativeService docker;((result+=$?))
        checkEntityStatus y NativeService docker-bootstrap;((result+=$?))
        checkEntityStatus y Etcd all;((result+=$?))
        checkEntityStatus y Vault all;((result+=$?))
        checkEntityStatus y NativeService kubelet;((result+=$?))
        checkEntityStatus y NativeService kube-proxy;((result+=$?))
        checkEntityStatus y Pod all;((result+=$?))

        if [ $result = 0 ]
        then
                kube_started=y
                logger_info "Kubernetes started!"
        else
                logger_info "Kubernetes not started!"
        fi
        logger_info

}

getBaseConfig() {
#
# get dynamic global variables
#

        local config_out=`kubectl get configmaps base-configmap -n core -o=custom-columns=API_SERVER:.data.API_SERVER,ETCD_ENDPOINT:.data.ETCD_ENDPOINT,MASTER_API_SSL_PORT:.data.MASTER_API_SSL_PORT,EXTERNAL_ACCESS_HOST:.data.EXTERNAL_ACCESS_HOST --no-headers`
        #local config_out=`kubectl get configmaps base-configmap -n core -o=custom-columns=API_SERVER:.data.API_SERVER,ETCD_ENDPOINT:.data.ETCD_ENDPOINT,MASTER_API_SSL_PORT:.data.MASTER_API_SSL_PORT --no-headers`

        API_SERVER=$(echo $config_out|awk '{print $1}')
        ETCD_ENDPOINT=$(echo $config_out|awk '{print $2}')
        SSH_API_PORT=$(echo $config_out|awk '{print $3}')
        EXTERNAL_ACCESS_HOST=$(echo $config_out|awk '{print $4}')

        FIRST_MASTER_IP=$(echo $MASTER_IP_LIST|awk '{print $1}')
        FIRST_MASTER_NAME=$(echo $MASTER_NAME_LIST|awk '{print $1}')

        API_SERVER=${API_SERVER:-${FIRST_MASTER}}
        ETCD_ENDPOINT=${ETCD_ENDPOINT:-"https://${API_SERVER}:${ETCD_ENDPOINT_PORT}"}
        SSH_API_PORT=${SSH_API_PORT:-8443}
        EXTERNAL_ACCESS_HOST=${EXTERNAL_ACCESS_HOST:-${FIRST_MASTER_NAME}}


        if [[ -f ${CERT_PATH}/server.crt ]] ; then
                CERT_FILE_PREFIX="server"
        else
                CERT_FILE_PREFIX="client"
        fi

        CA_FILE=${CERT_PATH}/ca.crt
        CERT_FILE=${CERT_PATH}/${CERT_FILE_PREFIX}.crt
        KEY_FILE=${CERT_PATH}/${CERT_FILE_PREFIX}.key

        Mini_CDF=true
        DB_HA=false
        EMBEDDED_DB=true
        CMS=`${K8S_HOME}/bin/kubectl get cm -n core --no-headers | awk '{print $1}'`
        if [ ! $? = 0 ]; then
                echo "Please ensure CDF operates well"
                exit 1
        fi
        echo $CMS | grep '\<default-database-configmap\>' >/dev/null 2>/dev/null
        if [ $? = 0 ]; then
                Mini_CDF=false
                EMBEDDED_DB=`${K8S_HOME}/bin/kubectl get cm -n core default-database-configmap -o json | ${K8S_HOME}/bin/jq -r .data.EMBEDDED_DB 2> /dev/null`
                DB_HA=`${K8S_HOME}/bin/kubectl get cm -n core default-database-configmap -o json | ${K8S_HOME}/bin/jq -r .data.DEFAULT_DB_HA 2> /dev/null`
        fi
}

checkCertificate() {
        if [ $isMaster = y ]; then
                certificate_type="server"
        else
                certificate_type="client"
        fi
        expire_date=`openssl x509 -in ${K8S_HOME}/ssl/${certificate_type}.crt -noout -enddate | cut -d "=" -f 2`
        expire_date_stamp=`date -d "${expire_date}" +%s`
        today_stamp=`date +%s`
        days=$(( ($expire_date_stamp - $today_stamp)/86400 ))
        echo -e "\n${certificate_type^} certificate expiration date: \033[35m${expire_date}\033[0m, \033[35m${days}\033[0m days left"
}

checkNfsPathStatus(){
    local tmp_file=/tmp/check_status_nfss.tmp
    > ${tmp_file}
    kubectl describe pv > ${tmp_file}
    local pvs=($(cat ${tmp_file}|grep Name:|awk '{print $2}'))
    local servers=($(cat ${tmp_file}|grep Server:|awk '{print $2}'))
    local paths=($(cat ${tmp_file}|grep Path:|awk '{print $2}'))
        echo "[NFS]"
    for ((i=0;i<${#pvs[@]};i++))
    do
        echo "   <PersistentVolume: ${pvs[$i]}>"
                local status=""
        local host=${servers[$i]}
        local path=${paths[$i]}
                showName "     ${host}:${path}"
        timeout 30 ${K8S_HOME}/scripts/checkNFS.sh -s ${host} -f ${path} 1>/dev/null 2>&1
        if [ "$?" == 0 ] ;then
            status="Passed"
        else
            status="Error"
            FAILED_CASE=$((FAILED_CASE+1))
        fi
        showStatus ${status}
    done
    rm -f ${tmp_file}
}

########
# checkDBStatus start
KUBECTL=${K8S_HOME}/bin/kubectl
KUBE_SYSTEM_NAMESPACE=core
BASEINFRA_VAULT_APPROLE=baseinfra
TIMEOUT_FOR_SERVICES=60

getDbUserPwd(){
    getVaultRootToken
    if [ "$?" -ne 0 ]; then
        return 1
    fi
    BASEINFRA_VAULT_ROLE_ID=$(vault read -ca-cert=${K8S_HOME}/ssl/ca.crt -address=https://${K8S_MASTER_IP}:8200 auth/approle/role/${KUBE_SYSTEM_NAMESPACE}-${BASEINFRA_VAULT_APPROLE}/role-id 2>>${ERR_LOG} | grep role_id | awk '{print $2}')
    local dbpasswordkey=$1
    PASSWORD_TEMP=""
    local passwordTemp=""
    local SECONDS=0
    while [ -z "$passwordTemp" ]
    do
        passwordTemp=$(vault read -ca-cert=${K8S_HOME}/ssl/ca.crt -address=https://${K8S_MASTER_IP}:8200 -field=value itom/suite/${BASEINFRA_VAULT_ROLE_ID}/${dbpasswordkey} 2>>${ERR_LOG})
        ((SECONDS++))
        if [[ ${SECONDS} == ${TIMEOUT_FOR_SERVICES} ]]; then
            logger_err "A timeout occurred while waiting for reading ${dbpasswordkey} from vault."
            return 1
        fi
        sleep 1
    done
    PASSWORD_TEMP=${passwordTemp#*PASS=}
}

isMasterNode(){
    local isMaster=
    if [[ -d ${K8S_HOME}/data/etcd ]] && [[ -d ${K8S_HOME}/log/apiserver ]] && [[ $(ls ${K8S_HOME}/data/etcd|wc -l) -gt 0 ]] ; then
        isMaster=true
    else
        isMaster=false
    fi
    echo $isMaster
}

getVaultRootToken() {
    local cert=
    local key=
    local ca=${K8S_HOME}/ssl/ca.crt
    local isMaster=$(isMasterNode)
    if [[ "$isMaster" == "true" ]]; then
                cert=${K8S_HOME}/ssl/server.crt
                key=${K8S_HOME}/ssl/server.key
    else
                cert=${K8S_HOME}/ssl/client.crt
                key=${K8S_HOME}/ssl/client.key
    fi

    local n=0
    local VAULT_RT_TOKEN=""
    while [[ $n -lt ${TIMEOUT_FOR_SERVICES} ]] ; do
        n=$(( $n + 1 ))
        vaultTokenKey="/cdf/vault/config/root-token"
        VAULT_RT_TOKEN=$(ETCDCTL_API=3 ${K8S_HOME}/bin/etcdctl --endpoints=${ETCD_ENDPOINT} --cacert ${ca} --cert ${cert} --key ${key} get ${vaultTokenKey}|grep -v ${vaultTokenKey})
        if [[ $? -ne 0 ]] && [[ $n -lt ${TIMEOUT_FOR_SERVICES} ]] ; then
            sleep 1
            continue
        elif [[ $n -ge ${TIMEOUT_FOR_SERVICES} ]] ; then
            logger_err "Failed to get vault root token from etcd."
            return 1
        else
            if [[ -z ${VAULT_RT_TOKEN} ]] || [[ "${VAULT_RT_TOKEN}" == "null" ]] ; then
                logger_err "Failed to get vault root token from etcd (the value is null)."
                return 1
            else
                export VAULT_TOKEN=${VAULT_RT_TOKEN}
            fi
            break
        fi
    done
}

createCacert(){
        TMP_CACERT_FILE="/tmp/db-tmp-trust.cacert"
        local str=$($KUBECTL get cm default-database-configmap -n ${KUBE_SYSTEM_NAMESPACE} -o json|grep DEFAULT_DB_CA|sed -e 's/\s//g' -e 's/^\"DEFAULT_DB_CA\":\"//' -e 's/\",\?$//')
        if [ "${str}" != "" ] ; then
                local base64file="/tmp/db-tmp-trust.base64"
                echo ${str} > ${base64file}
                base64 -d  ${base64file} > ${TMP_CACERT_FILE}
                local ret=$?
                rm -f ${base64file}
                if [ "${ret}" -ne 0 ] ; then
                        logger_err "ERROR in create database ca certificate"
                        return 1
                fi
        else
                return 1
        fi
}

createTrustStore(){
    DB_SSL_ENABLED=$($KUBECTL get cm default-database-configmap -n ${KUBE_SYSTEM_NAMESPACE} -o json | ${K8S_HOME}/bin/jq ".data.DB_SSL_ENABLED" | sed -e 's/\^/,/g' -e 's/"//g')
    if [[ ${DB_SSL_ENABLED} == "true" ]];then
        if [ "$EMBEDDED_DB" == "true" ]; then
                TMP_CACERT_FILE="/tmp/db-tmp-trust.cacert"
                cp ${K8S_HOME}/ssl/ca.crt ${TMP_CACERT_FILE}
        else
                createCacert
        fi
        if [ "$?" -ne 0 ]; then
            return 1
        fi
        local storepass="changeit"
        TMP_TRUST_STORE="/tmp/db-tmp-trust.keystore"
                rm -f ${TMP_TRUST_STORE}
        keytool -import -alias local -keystore ${TMP_TRUST_STORE} -file ${TMP_CACERT_FILE} -trustcacerts -storepass ${storepass} -noprompt 1>/dev/null 2>>${ERR_LOG}
        chmod +x ${TMP_TRUST_STORE}
        JAVA_PARAM_1="-Djavax.net.ssl.trustStore=${TMP_TRUST_STORE}"
        JAVA_PARAM_2="-Djavax.net.ssl.trustStorePassword=${storepass}"
    fi
}

cleanTrustStore(){
    if [[ ${DB_SSL_ENABLED} == "true" ]];then
        rm -f ${TMP_TRUST_STORE}
        rm -f ${TMP_CACERT_FILE}
    fi
}

testDatabaseConnection() {
    local dbName=${DB_NAME}
    local database_name=${DB_NAME}
    local dbpasswordkey=$($KUBECTL get cm default-database-configmap -n ${KUBE_SYSTEM_NAMESPACE} -o json | ${K8S_HOME}/bin/jq ".data.DEFAULT_DB_PASSWORD_KEY" | sed -e 's/\^/,/g' -e 's/"//g')
    getDbUserPwd ${dbpasswordkey}
    if [ "$?" -ne 0 ]; then
        return 1
    fi
    local dbPassword=${PASSWORD_TEMP}

    local dbUser=$($KUBECTL get cm default-database-configmap -n ${KUBE_SYSTEM_NAMESPACE} -o json | ${K8S_HOME}/bin/jq ".data.DEFAULT_DB_USERNAME" | sed -e 's/\^/,/g' -e 's/"//g')
    local dbUrl=$($KUBECTL get cm default-database-configmap -n ${KUBE_SYSTEM_NAMESPACE} -o json | ${K8S_HOME}/bin/jq ".data.DEFAULT_DB_CONNECTION_URL" | sed -e 's/\^/,/g' -e 's/"//g')
    local dbType=$($KUBECTL get cm default-database-configmap -n ${KUBE_SYSTEM_NAMESPACE} -o json | ${K8S_HOME}/bin/jq ".data.DEFAULT_DB_TYPE" | sed -e 's/\^/,/g' -e 's/"//g')
    local dbPort=$($KUBECTL get cm default-database-configmap -n ${KUBE_SYSTEM_NAMESPACE} -o json | ${K8S_HOME}/bin/jq ".data.DEFAULT_DB_PORT" | sed -e 's/\^/,/g' -e 's/"//g')
    local dbHost=$($KUBECTL get cm default-database-configmap -n ${KUBE_SYSTEM_NAMESPACE} -o json | ${K8S_HOME}/bin/jq ".data.DEFAULT_DB_HOST" | sed -e 's/\^/,/g' -e 's/"//g')

    local dbSvc=""
    local n=0
        if [[ -z ${dbUrl} ]]; then
                if [[ "${DEFAULTDB_ISEMBEDDED}" == "true" ]] ; then
                        dbSvc=${dbHost%%.*}
                        dbHost=null
                        while [[ "${dbHost}" == "null" ]] ; do
                                dbHost=$($KUBECTL get ep ${dbSvc} -n ${KUBE_SYSTEM_NAMESPACE} -o json|${K8S_HOME}/bin/jq --raw-output .subsets[0].addresses[0].ip)
                                if [[ -z "${dbHost}" ]] ; then
                                        logger_err "The ${database_name} service not found, please check if all CDF pods are in running status."
                                        return 1
                                fi
                                sleep 1
                                n=$(( $n + 1 ))
                                if (( n > ${TIMEOUT_FOR_SERVICES} )); then
                                        logger_err "A timeout occurred while waiting for get ${database_name} service."
                                        return 1
                                else
                                        continue
                                fi
                        done
                fi
        fi
    createTrustStore
    local SECONDS=0
    while true; do
        if [ $(java -classpath ${K8S_HOME}/jar/idm/:${K8S_HOME}/tools/drivers/jdbc/* ${JAVA_PARAM_1} ${JAVA_PARAM_2} dataBaseConnectionTest "${dbType}" "${dbUser}" "${dbPassword}" "${dbHost}" "${dbPort}" "${dbName}" "${dbUrl}" "${DB_SSL_ENABLED}" "false" "true" 2>>${ERR_LOG} ) -eq 0 ] ; then
            break
        elif (( SECONDS > ${TIMEOUT_FOR_SERVICES} )); then
            logger_err "A timeout occurred while waiting for connecting the ${database_name}."
            cleanTrustStore
            return 1
        fi
        SECONDS=$(( $SECONDS + 1 ))
        sleep 1
    done
    cleanTrustStore
}


checkDBStatus(){
    ETCD_ENDPOINT=$($KUBECTL get configmap base-configmap -n core -o json | ${K8S_HOME}/bin/jq ".data.ETCD_ENDPOINT?" | sed -e 's/\^/,/g' -e 's/"//g')
    DEFAULTDB_ISEMBEDDED=$($KUBECTL get cm default-database-configmap -n ${KUBE_SYSTEM_NAMESPACE} -o json | ${K8S_HOME}/bin/jq ".data.EMBEDDED_DB" | sed -e 's/\^/,/g' -e 's/"//g')
    K8S_MASTER_IP=$($KUBECTL get configmap base-configmap -n core -o json | ${K8S_HOME}/bin/jq ".data.API_SERVER?" |sed -e 's/"//g')

    DB_NAME=$($KUBECTL get cm default-database-configmap -n ${KUBE_SYSTEM_NAMESPACE} -o json | ${K8S_HOME}/bin/jq ".data.DEFAULT_DB_NAME" | sed -e 's/\^/,/g' -e 's/"//g')
    export ETCDCTL_API=3

    showName "[DB] ${DB_NAME}"
    testDatabaseConnection
    if [ "$?" -ne 0 ]; then
        showStatus "Error"
        FAILED_CASE=$((FAILED_CASE+1))
    else
        showStatus "Passed"
    fi
}

# checkDBStatus end
########

########
# Main #
########

# if 'y', the program will wait Kubernetes being ready before checking status.
waitKube=n

# status of the Kubernetes started.
kube_started=

# if 'y', HTML report will be generted.
GEN_REPORT=n

# current node type
isMaster=n

while getopts "asrwh" arg
do
        case $arg in
                a)
                        AUTOTEST=y
                        ;;
                w)
                        waitKube=y
                        ;;
                r)
                        GEN_REPORT=y
                        ;;
                ?|h)
                        echo "Usage: $0 [OPTION]"
                        echo "Options:"
                        echo "  -a     run as automation test mode. set MASTER_NODES and WORKER_NODES before running"
                        echo "  -w     wait for Kubernetes started before checking"
                        echo "  -h     show this help"
                        echo "  -r     generate a HTML report"
                        exit 1
                        ;;
        esac
done

rm -f ${TMP_FILE}
rm -f ${INFO_LOG}
rm -f ${ERR_LOG}
rm -f ${RESULT_FILE}
rm -f ${REPORT_FILE}

setNodeList
getBaseConfig

echo "Type${DELIMITER}Name${DELIMITER}Duration${DELIMITER}Status${DELIMITER}Detail" >> ${RESULT_FILE}

inf Checking status on $LOCAL_IP

if [ "$waitKube" = "y" ]
then
        waitKubeStarted
fi
echo "--------------------------------------"

###################
# Cases to be run #
###################
checkEntityStatus n DockerVersion
checkEntityStatus n KubeVersion
checkEntityStatus n NativeService docker
checkEntityStatus n NativeService docker-bootstrap
checkEntityStatus n NativeService kubelet
checkEntityStatus n NativeService kube-proxy
checkEntityStatus n Etcd all
checkEntityStatus n Vault all
checkEntityStatus n APIServer
if [ $Mini_CDF = "false" ]; then
        checkEntityStatus n MngPortal
fi
checkEntityStatus n Process flanneld
checkEntityStatus n Process kubelet
checkEntityStatus n Bootstrap kube_flannel
if [ $isMaster = y ]
then
        checkEntityStatus n Bootstrap vault_container
        checkEntityStatus n Bootstrap etcd_container
fi
checkEntityStatus n Node byList
if [ "$Mini_CDF" = "true" ]; then
        checkEntityStatus n Pod byList MINI_POD_LIST
        checkEntityStatus n Service byList MINI_SERVICE_LIST
elif [ "$EMBEDDED_DB" = "false" ]; then
        checkEntityStatus n Pod byList POD_LIST
        checkEntityStatus n DaemonSet byList
        checkEntityStatus n Deployment byList DEPLOYMENT_LIST_DB_NONE
        checkEntityStatus n Service byList SERVICE_LIST_DB_NONE
        checkEntityStatus n Ping kube-registry-proxy
        checkNfsPathStatus
        checkDBStatus
elif [ "$DB_HA" = "true" ]; then
        checkEntityStatus n Pod byList POD_LIST
        checkEntityStatus n DaemonSet byList
        checkEntityStatus n Deployment byList DEPLOYMENT_LIST_DB_HA
        checkEntityStatus n Service byList SERVICE_LIST_DB_HA
        checkEntityStatus n Ping kube-registry-proxy
        checkNfsPathStatus
        checkDBStatus
else
        checkEntityStatus n Pod byList POD_LIST
        checkEntityStatus n DaemonSet byList
        checkEntityStatus n Deployment byList DEPLOYMENT_LIST_DB_SINGLE
        checkEntityStatus n Service byList SERVICE_LIST_DB_SINGLE
        checkEntityStatus n Ping kube-registry-proxy
        checkNfsPathStatus
        checkDBStatus
fi
checkCertificate

####################
# Handling results #
####################
inf
if [ "$Mini_CDF" = "true" ]; then
        phase="Minimized CDF"
elif [ "$Mini_CDF" = "false" ]; then
        phase="Full CDF"
fi
if [[ $FAILED_CASE = 0 ]]; then
        overall_status="Running"
        inf "$phase is Running"
else
        overall_status="NOT Started"
        err "$phase is NOT started!!"
fi

end_time=`date +%s`
duration=$((end_time-START_TIME))

if [ $AUTOTEST = y ]
then
        inf
        inf Duration: ${duration} seconds

        inf Total cases: $TOTAL_CASE"    "Passed: $PASSED_CASE"    "Failed: $FAILED_CASE"    "Ignored: $IGNORED_CASE
        inf
fi
if [ $AUTOTEST = y ] || [ $GEN_REPORT = y ]
then
        convert_html ${RESULT_FILE}
fi

rm -f ${TMP_FILE}
rm -f ${RESULT_FILE}

if [[ $FAILED_CASE != 0 ]]; then
        exit 1
fi
[root@zemsmp01 bin]#
