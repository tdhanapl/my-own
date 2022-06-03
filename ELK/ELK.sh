#################ELK########################
#Installing ELK Stack on the Server
####For downloading rpm packages in  elk site 

#https://www.elastic.co/downloads/past-releases/elasticsearch-7-9-2
#https://www.elastic.co/downloads/past-releases/kibana-7-9-2
#https://www.elastic.co/downloads/past-releases/logstash-7-9-2
#https://www.elastic.co/downloads/past-releases/merticbeat-7-9-2

###############################Installation provide site by meduim.com###################################
$$$$  https://medium.com/@ammadb/installing-elk-stack-6d524db72d52 (very important)
$$$ https://medium.com/make-it-heady/what-and-why-ekl-stack-378e6c4765b9   (very important)
$$$$$  https://medium.com/getting-started-with-the-elk-stack      (very important)
https://nischalnewar.medium.com/elk-stack-the-beginners-guide-cd3e88bb5868
https://medium.com/@knoldus/fundamentals-of-elk-stack-with-demo-part-1-f131da3c41a7
https://medium.com/dataseries/elk-stack-architecture-deep-dive-41168732f0e3
#####################################
https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-elasticsearch-on-centos-7
###https://www.tecmint.com/install-elasticsearch-logstash-and-kibana-elk-stack-on-centos-rhel-7/

##Installation 
Install the Elastic Stack products you want to use in the following order:
1.Elasticsearch 
2.Kibana 
3.Logstash 
4.Beats    
5.APM 
6.Elasticsearch Hadoop 
#Elasticsearch: is a distributed RESTful search engine which stores a large amount of collected data in a powerful indexing engine.Elasticsearch stores the logs that are sent by the clients.
#Logstash: collects and process the incoming data and send it to Elasticsearch server.
#Kibana: is a web interface to visualize and query the elasticsearch data.
#Beats: are lightweight data shippers which send data from several log sources to Logstash or Elasticsearch server.

####################
Let’s begin by installing the ELK stack on the server, along with a brief explanation on what each component does:
##installation of java
# yum update
# cd /opt
# wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jre-8u102-linux-x64.rpm"
# rpm -Uvh jre-8u102-linux-x64.rpm
#nstall java-1.8*
# java -version

###############installation of Elasticsearch############
1.Download rpm package
$ wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.9.2-linux-x86_64.tar.gz
$ ll
$  rpm -ivh elasticsearch-7.9.2-x86_64.rpm
$whereis elasticsearch
$cd /etc/elasticsearch
$ vim elasticsearch.yml

# ---------------------------------- Cluster -----------------------------------
#
# Use a descriptive name for your cluster:
#
cluster.name: elk-dhana  ##cluster name
#
# ------------------------------------ Node ------------------------------------
#
# Use a descriptive name for the node:
#
node.name: node-1 ##node name
#
# Add custom attributes to the node:
#
#node.attr.rack: r1
#
# ----------------------------------- Paths ------------------------------------
#
# Path to directory where to store the data (separate multiple locations by comma):
#
path.data: /var/lib/elasticsearch
#
# Path to log files:
#
path.logs: /var/log/elasticsearch
#
# ----------------------------------- Memory -----------------------------------
#
# Lock the memory on startup:
#
#bootstrap.memory_lock: true
#
# Make sure that the heap size is set to about half the memory available
# on the system and that the owner of the process is allowed to use this
# limit.
#
# Elasticsearch performs poorly when the system is swapping the memory.
#
# ---------------------------------- Network -----------------------------------
#
# Set the bind address to a specific IP (IPv4 or IPv6):
#
network.host: 0.0.0.0 #or 192.168.1.50  ###uncomment mention  elasticsearch server ip or localhost
#
# Set a custom port for HTTP:
#
#http.port: 9200  ###by default 9200 is open port
#
# For more information, consult the network module documentation.
#
# --------------------------------- Discovery ----------------------------------
#
# Pass an initial list of hosts to perform discovery when this node is started:
# The default list of hosts is ["127.0.0.1", "[::1]"]
#
#discovery.seed_hosts: ["192.168.1.50", "127.0.0.1"]
#
# Bootstrap the cluster using an initial set of master-eligible nodes:
#
#cluster.initial_master_nodes: ["node-1"]
#
# For more information, consult the discovery and cluster formation module documentation.
#
# ---------------------------------- Gateway -----------------------------------
#
# Block initial recovery after a full cluster restart until N nodes are started:
#
#gateway.recover_after_nodes: 3
#
# For more information, consult the gateway module documentation.
#
####add by dhana
#setup discovery.type as signle node
discovery.type: single-node

:wq
$ systemctl daemon-reload
$ systemctl enable elasticsearch.service
$ systemctl start elasticsearch.service
$ systemctl status elasticsearch.service

#Allow traffic through TCP port 9200 in your firewall:
$firewall-cmd --add-port=9200/tcp
$firewall-cmd --add-port=9200/tcp --permanent
$firewall-cmd --reload
######then check output of elasticsearch
$curl localhost:9200

###############installation of Kibana############
###downloading rpm package
$wget https://artifacts.elastic.co/downloads/kibana/kibana-7.9.2-linux-x86_64.tar.gz
$ rpm -ivh kibana-7.9.2-x86_64.rpm
vim /etc/kibana/kibana.yml
# =================================== Kibana ===================================
 58
 59 # Starting with Beats version 6.0.0, the dashboards are loaded via the Kibana API.
 60 # This requires a Kibana endpoint configuration.
 61 setup.kibana:
 62
 63   # Kibana Host
 64   # Scheme and port can be left out and will be set to the default (http and 5601)
 65   # In case you specify and additional path, the scheme is required: http://localhost:5601/path
 66   # IPv6 addresses should always be defined as: https://[2001:db8::1]:5601
 67   host: "localhost:5601" ##kibana installed server  ip adress or if its localhost
 68
 69   # Kibana Space ID
 70   # ID of the Kibana Space into which the dashboards should be loaded. By default,
 71   # the Default Space will be used.
 72   #space.id:

 # ---------------------------- Elasticsearch Output ----------------------------
 92 output.elasticsearch:
 93   # Array of hosts to connect to.
 94   hosts: ["localhost:9200"]   ###elasticsearch installed server ip adress or if its localhost
 95
 96   # Protocol - either `http` (default) or `https`.
 97   #protocol: "https"
 98
 99   # Authentication credentials - either API key or username/password.
100   #api_key: "id:api_key"
101   #username: "elastic"
102   #password: "changeme"
103
104 # ------------------------------ Logstash Output -------------------------------
105 #output.logstash:
106   # The Logstash hosts
107   #hosts: ["localhost:5044"]   ###Logstash installed server ip adress or if its localhost
 95
10
109   # Optional SSL. By default is off.
110   # List of root certificates for HTTPS server verifications
111   #ssl.certificate_authorities: ["/etc/pki/root/ca.pem"]
112
113   # Certificate for SSL client authentication
114   #ssl.certificate: "/etc/pki/client/cert.pem"
115
116   # Client Certificate Key
:wq

$ systemctl enable  kibana
$ systemctl start   kibana
$ systemctl status   kibana
# firewall-cmd --add-port=5601/tcp
# firewall-cmd --add-port=5601/tcp --permanent
####################installation of logstash###############
########installation 
$wget https://artifacts.elastic.co/downloads/logstash/logstash-7.9.2.rpm
$rpm -ivh logstash-7.9.2.rpm

#Configure Logstash input, output, and filter files:
#Input: Create /etc/logstash/conf.d/input.conf and insert the following lines into it. 
#This is necessary for Logstash to “learn” how to process beats coming from clients. Make sure the path to the certificate and key match the right paths as outlined in the previous step:

$vim /etc/logstash/conf.d/apache.conf
# INPUT HERE
input {
   beats {
      port => 5044
    }
  }
# FILTER HERE
filter{
    if [source]=="/var/log/apache2/error.log"
      {
        mutate {
            remove_tag => [ "beats_input_codec_plain_applied" ]
            add_tag => [ "apache_logs" ]
        }
    }
    if [source]=="/var/log/apache2/access.log"
     {
    mutate {
       remove_tag => [ "beats_input_codec_plain_applied" ]
       add_tag => [ "apache_logs" ]
      }
    }
 }
#OUTPUT HERE
#To getting normal output, Add this at output plugin
output {
       stdout { codec => rubydebug }
  }
 :wq
 
==================================================

#####another logstash conf file
input {
  beats {
	port => 5044
	ssl => true
	ssl_certificate => "/etc/pki/tls/certs/logstash-forwarder.crt"
	ssl_key => "/etc/pki/tls/private/logstash-forwarder.key"
  }
}

filter {
if [type] == "syslog" {
	grok {
  	match => { "message" => "%{SYSLOGLINE}" }
	}

	date {
match => [ "timestamp", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]
}
  }
}

output {
  elasticsearch {
	hosts => ["localhost:9200"]
	sniffing => true
	manage_template => false
	index => "%{[@metadata][beat]}-%{+YYYY.MM.dd}"
	document_type => "%{[@metadata][type]}"
  }
}
:wq

#To verify your configuration, run the following command:
$ /usr/share/logstash/bin/logstash  -f apache.conf — config.test_and_exit

#If the configuration file passes the configuration test, start Logstash with the following command:
$ /usr/share/logstash/bin/logstash -f apache.conf — config.reload.automatic

#To run the logstash
$ /usr/share/logstash/bin/logstash -f /etc/logstash/conf.d/apache.conf
#####adding another logstash/.conf file
$ vim /etc/logstash/conf.d/first-pipeline.conf
input {
    beats {
        port => "5044"
    }
}
 filter {
    grok {
        match => { "message" => "%{COMBINEDAPACHELOG}"}
    }
    geoip {
        source => "clientip"
    }
}
output {
    elasticsearch {
        hosts => [ "localhost:9200" ]
    }
}
:wq
$ /usr/share/logstash/bin/logstash -f /etc/logstash/conf.d/first-pipeline.conf

#Start and enable logstash:
$ systemctl daemon-reload
$ systemctl start logstash
$ systemctl enable logstash
#Configure the firewall to allow Logstash to get the logs from the clients (TCP port 5044):
$ firewall-cmd --add-port=5044/tcp
$ firewall-cmd --add-port=5044/tcp --permanent

#############installation of  merticbeat-7-9-2#####################
$ wget https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.9.2-x86_64.rpm
$  rpm -ivh metricbeat-7.9.2-x86_64.rpm
$ cd /etc/merticbeat

$vim merticbeat.yml
 # =========================== Modules configuration ============================

metricbeat.config.modules:
  # Glob pattern for configuration loading
  path: ${path.config}/modules.d/*.yml

  # Set to true to enable config reloading
  reload.enabled: true   ####change false to true

  # Period on which files under path should be checked for changes
  reload.period: 10s   #####uncomment reload.period 

# ================================== General ===================================

# The name of the shipper that publishes the network data. It can be used to group
# all the transactions sent by a single shipper in the web interface.
name: dhana-metric  ####dhana changes

# The tags of the shipper are included in their own field with each
# transaction published.
tags: ["elk"] #### add by dhana

# Optional fields that you can specify to add additional information to the
# output.
#fields:
#  env: staging

# ================================= Dashboards =================================
# These settings control loading the sample dashboards to the Kibana index. Loading
# the dashboards is disabled by default and can be enabled either by setting the
# options here or by using the `setup` command.
setup.dashboards.enabled: true #####from false to true

# The URL from where to download the dashboards archive. By default this URL
# has a value which is computed based on the Beat name and version. For released
# versions, this URL points to the dashboard archive on the artifacts.elastic.co
# website.
#setup.dashboards.url:



# =================================== Kibana ===================================
# Starting with Beats version 6.0.0, the dashboards are loaded via the Kibana API.
# This requires a Kibana endpoint configuration.
setup.kibana:

  # Kibana Host
  # Scheme and port can be left out and will be set to the default (http and 5601)
  # In case you specify and additional path, the scheme is required: http://localhost:5601/path
  # IPv6 addresses should always be defined as: https://[2001:db8::1]:5601
  host: "localhost:5601"  ####kibana ip address or localhost of kibana

  # Kibana Space ID
  # ID of the Kibana Space into which the dashboards should be loaded. By default,
  # the Default Space will be used.
  #space.id:
  
# ================================== Outputs ===================================

# Configure what output to use when sending the data collected by the beat.

# ---------------------------- Elasticsearch Output ----------------------------
output.elasticsearch:
  # Array of hosts to connect to.
  hosts: ["localhost:9200"]    ##########elasticsearch server ip address or if its installed local then localhost 
# hosts: ["http://192.168.1.50:9200/"]
  # Protocol - either `http` (default) or `https`.
  protocol: "http" ####change from https to http

  # Authentication credentials - either API key or username/password.
  #api_key: "id:api_key"
  #username: "elastic"
  #password: "changeme"

# ------------------------------ Logstash Output -------------------------------
#output.logstash:
  # The Logstash hosts
  #hosts: ["localhost:5044"] ##########logstash server ip address or if its installed local then localhost 

  # Optional SSL. By default is off.
  # List of root certificates for HTTPS server verifications
  #ssl.certificate_authorities: ["/etc/pki/root/ca.pem"]

  # Certificate for SSL client authentication
  #ssl.certificate: "/etc/pki/client/cert.pem"

  # Client Certificate Key
  #ssl.key: "/etc/pki/client/cert.key"

# ================================== Logging ===================================

# Sets log level. The default log level is info.
# Available log levels are: error, warning, info, debug
logging.level: debug ####uncomment

# At debug level, you can selectively enable logging only for some components.
# To enable all selectors use ["*"]. Examples of other selectors are "beat",
# "publish", "service".
logging.selectors: ["*"] #####uncomment

##add by dhana
logging.to_files: true
logging.files:
path: /var/log/merticbeat
keepfiles: 7
permissions: 0664

# ============================= X-Pack Monitoring ==============================
# Metricbeat can export internal metrics to a central Elasticsearch monitoring
# cluster.  This requires xpack monitoring to be enabled in Elasticsearch.  The
# reporting is disabled by default.

# Set to true to enable the monitoring reporter.
monitoring.enabled: true ##uncomment and change flase to true

# Sets the UUID of the Elasticsearch cluster under which monitoring data for this
# Metricbeat instance will appear in the Stack Monitoring UI. If output.elasticsearch
# is enabled, the UUID is derived from the Elasticsearch cluster referenced by output.elasticsearch.
#monitoring.cluster_uuid:

# Uncomment to send the metrics to Elasticsearch. Most settings from the
# Elasticsearch output are accepted here as well.
# Note that the settings should point to your Elasticsearch *monitoring* cluster.
# Any setting that is not set is automatically inherited from the Elasticsearch
# output configuration, so if you have the Elasticsearch output configured such
# that it is pointing to your Elasticsearch monitoring cluster, you can simply
# uncomment the following line.
monitoring.elasticsearch: ####uncomment
:wq

$cd /ect/metricbeat
$ls
cd modules.d/
$ ll
#To check all modules list
$ metricbeat modules list
#To enable the modules
$ metricbeat modules enable elasticsearch-xpack kibana-xpack beat-xpack #example like kibana-xpack system
$ metricbeat modules enable beat-xpack
$ metricbeat modules enable kibana-xpack
$ vim system.yml
#here we no need edit above file  this will default path
#Configure modules in the metricbeat.yml file
#here we no need edit above file  this will default path

#check metricbeat configuration
$ metricbeat setup

# start the service and check service
$ systemctl enable metricbeat
$ systemctl start metricbeat
$ systemctl status metricbeat
$ systemctl status kibana
$ systemctl restart metricbeat

---------------------------------------------------
###########################installation of filebeat#######################
###########Download and install Filebeat
$wget  https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.9.2-x86_64.rpm
$rpm -vih filebeat-7.9.2-x86_64.rpm
#Edit the configuration
#Modify /etc/filebeat/filebeat.yml to set the connection information:
$vim /etc/filebeat/filebeat.yml

# You can find the full configuration reference here:
# https://www.elastic.co/guide/en/beats/filebeat/index.html

# For more available modules and options, please see the filebeat.reference.yml sample
# configuration file.

# ============================== Filebeat inputs ===============================

filebeat.inputs:

# Each - is an input. Most options can be set at the input level, so
# you can use different inputs for various configurations.
# Below are the input specific configurations.

- type: log

  # Change to true to enable this input configuration.
  enabled: true  ##uncomment change false to true

  # Paths that should be crawled and fetched. Glob based paths.
  paths:
    - /var/log/*.log
    #- c:\programdata\elasticsearch\logs\*

  # Exclude lines. A list of regular expressions to match. It drops the lines that are
  # matching any regular expression from the list.
  #exclude_lines: ['^DBG']

  # Include lines. A list of regular expressions to match. It exports the lines that are
  # matching any regular expression from the list.
  #include_lines: ['^ERR', '^WARN']

  # Exclude files. A list of regular expressions to match. Filebeat drops the files that
  # are matching any regular expression from the list. By default, no files are dropped.
  #exclude_files: ['.gz$']

  # Optional additional fields. These fields can be freely picked
  # to add additional information to the crawled log files for filtering
  #fields:
  #  level: debug
  #  review: 1

  ### Multiline options

  # Multiline can be used for log messages spanning multiple lines. This is common
  # for Java Stack Traces or C-Line Continuation

  # The regexp Pattern that has to be matched. The example pattern matches all lines starting with [
  #multiline.pattern: ^\[

  # Defines if the pattern set under pattern should be negated or not. Default is false.
  #multiline.negate: false

  # Match can be set to "after" or "before". It is used to define if lines should be append to a pattern
  # that was (not) matched before or after or as long as a pattern is not matched based on negate.
  # Note: After is the equivalent to previous and before is the equivalent to to next in Logstash
  #multiline.match: after

# ============================== Filebeat modules ==============================

filebeat.config.modules:
  # Glob pattern for configuration loading
  path: ${path.config}/modules.d/*.yml

  # Set to true to enable config reloading
  reload.enabled: true ####change false to true

  # Period on which files under path should be checked for changes
  reload.period: 10s    #####uncomment reload.period 

# ======================= Elasticsearch template setting =======================

setup.template.settings:
  index.number_of_shards: 1
  #index.codec: best_compression
  #_source.enabled: false


# ================================== General ===================================

# The name of the shipper that publishes the network data. It can be used to group
# all the transactions sent by a single shipper in the web interface.
#name:

# The tags of the shipper are included in their own field with each
# transaction published.
tags: ["elk"] #### add by dhana

# Optional fields that you can specify to add additional information to the
# output.
#fields:
#  env: staging

# ================================= Dashboards =================================
# These settings control loading the sample dashboards to the Kibana index. Loading
# the dashboards is disabled by default and can be enabled either by setting the
# options here or by using the `setup` command.
setup.dashboards.enabled: true ###uncomment change false to true 

# The URL from where to download the dashboards archive. By default this URL
# has a value which is computed based on the Beat name and version. For released
# versions, this URL points to the dashboard archive on the artifacts.elastic.co
# website.
#setup.dashboards.url:

# =================================== Kibana ===================================

# Starting with Beats version 6.0.0, the dashboards are loaded via the Kibana API.
# This requires a Kibana endpoint configuration.
setup.kibana:

  # Kibana Host
  # Scheme and port can be left out and will be set to the default (http and 5601)
  # In case you specify and additional path, the scheme is required: http://localhost:5601/path
  # IPv6 addresses should always be defined as: https://[2001:db8::1]:5601
  host: "192.168.1.50:5601" ##kibana server ip or localhost

  # Kibana Space ID
  # ID of the Kibana Space into which the dashboards should be loaded. By default,
  # the Default Space will be used.
  #space.id:

# =============================== Elastic Cloud ================================

# These settings simplify using Filebeat with the Elastic Cloud (https://cloud.elastic.co/).

# The cloud.id setting overwrites the `output.elasticsearch.hosts` and
# `setup.kibana.host` options.
# You can find the `cloud.id` in the Elastic Cloud web UI.
#cloud.id:

# The cloud.auth setting overwrites the `output.elasticsearch.username` and
# `output.elasticsearch.password` settings. The format is `<user>:<pass>`.
#cloud.auth:

# ================================== Outputs ===================================

# Configure what output to use when sending the data collected by the beat.

# ---------------------------- Elasticsearch Output ----------------------------
output.elasticsearch:
  # Array of hosts to connect to.
  hosts: ["192.168.1.50:9200"]  ####Elasticsearch installed server ip adress or if its localhost then localhost

  # Protocol - either `http` (default) or `https`.
  protocol: "http"   ####uncomment change https to http

  # Authentication credentials - either API key or username/password.
  #api_key: "id:api_key"
  #username: "elastic"   #if you elasticsearch user and password then uncomment and change username and password
  #password: "changeme"

# ------------------------------ Logstash Output -------------------------------
#output.logstash:
  # The Logstash hosts
  #hosts: ["localhost:5044"]      ####logstash installed server ip adress or if its localhost then localhost and port whatever you give logstash of *.conf file you need mention that port.

  # Optional SSL. By default is off.
  # List of root certificates for HTTPS server verifications
  #ssl.certificate_authorities: ["/etc/pki/root/ca.pem"]

  # Certificate for SSL client authentication
  #ssl.certificate: "/etc/pki/client/cert.pem"

  # Client Certificate Key
  #ssl.key: "/etc/pki/client/cert.key"

# ================================= Processors =================================
processors:
  - add_host_metadata:
      when.not.contains.tags: forwarded
  - add_cloud_metadata: ~
  - add_docker_metadata: ~
  - add_kubernetes_metadata: ~

# ================================== Logging ===================================

# Sets log level. The default log level is info.
# Available log levels are: error, warning, info, debug
logging.level: debug  ###uncomment

# At debug level, you can selectively enable logging only for some components.
# To enable all selectors use ["*"]. Examples of other selectors are "beat",
# "publish", "service".
logging.selectors: ["*"]    ###uncomment

##add by dhana
logging.to_files: true
logging.files:
path: /var/log/filebeat
keepfiles: 7
permissions: 0664
# ============================= X-Pack Monitoring ==============================
# Filebeat can export internal metrics to a central Elasticsearch monitoring
# cluster.  This requires xpack monitoring to be enabled in Elasticsearch.  The
# reporting is disabled by default.

# Set to true to enable the monitoring reporter.
#monitoring.enabled: false

# Sets the UUID of the Elasticsearch cluster under which monitoring data for this
# Filebeat instance will appear in the Stack Monitoring UI. If output.elasticsearch
# is enabled, the UUID is derived from the Elasticsearch cluster referenced by output.elasticsearch.
#monitoring.cluster_uuid:

# Uncomment to send the metrics to Elasticsearch. Most settings from the
# Elasticsearch output are accepted here as well.
# Note that the settings should point to your Elasticsearch *monitoring* cluster.
# Any setting that is not set is automatically inherited from the Elasticsearch
# output configuration, so if you have the Elasticsearch output configured such
# that it is pointing to your Elasticsearch monitoring cluster, you can simply
# uncomment the following line.
#monitoring.elasticsearch:

# ============================== Instrumentation ===============================

# Instrumentation support for the filebeat.
#instrumentation:
    # Set to true to enable instrumentation of filebeat.
    #enabled: false

    # Environment in which filebeat is running on (eg: staging, production, etc.)
    #environment: ""

    # APM Server hosts to report instrumentation results to.
    #hosts:
    #  - http://localhost:8200

    # API Key for the APM Server(s).
    # If api_key is set then secret_token will be ignored.
    #api_key:

    # Secret token for the APM Server(s).
    #secret_token:


# ================================= Migration ==================================

# This allows to enable 6.7 migration aliases
#migration.6_to_7.enabled: true
http.enabled: true
http.port: 5067
####Elasticsearch installed server ip adress or if its localhost
:wq

#To check all modules list
$ filebeat modules list
#To enable the modules
$filebeat modules enable elasticsearch 
$filebeat modules enable  kibana
$filebeat modules enable  system

1.#Modify the settings in the /etc/filebeat/modules.d/elasticsearch.yml file.
#here we no need edit above file  this will default path 
2.Modify the settings in the /etc/filebeat/modules.d/kibana.yml file.
#here we no need edit above file  this will default path 
3.Modify the settings in the /etc/filebeat/modules.d/system.yml file.
#here we no need edit above file  this will default path 
- module: system
  syslog:
    enabled: true
    var.paths: ["/path/to/log/syslog*"]
  auth:
    enabled: true
    var.paths: ["/path/to/log/auth.log*"]
:q!
	
#check filebeat configuration
$filebeat setup

#Start Filebeat service
$ systemctl enable filebeat
$ systemctl start  filebeat
$ systemctl status filebeat




###########################Indexes##########
#Get API
The get API is useful for retrieving a document when you already know the ID of the
document. It is essentially a get by primary key operation, as follows:
GET /catalog/_doc/1ZFMpmoBa_wgE5i2FfWV
The format of this request is GET /<index>/<type>/<id>. 

###############Create serv for systemctl for binary value start service#################
cat /etc/systemd/system/logstash.service
[Unit]
Description=logstash

[Service]
Type=simple
User=logstash
Group=logstash
# Load env vars from /etc/default/ and /etc/sysconfig/ if they exist.
# Prefixing the path with '-' makes it try to load, but if the file doesn't
# exist, it continues onward.
EnvironmentFile=-/etc/default/logstash
EnvironmentFile=-/etc/sysconfig/logstash
ExecStart=/usr/share/logstash/bin/logstash "--path.settings" "/etc/logstash"
Restart=always
WorkingDirectory=/
Nice=19
LimitNOFILE=16384

# When stopping, how long to wait before giving up and sending SIGKILL?
# Keep in mind that SIGKILL on a process can cause data loss.
TimeoutStopSec=infinity

[Install]
WantedBy=multi-user.target
:wq











