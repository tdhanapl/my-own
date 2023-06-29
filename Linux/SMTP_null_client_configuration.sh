###SMTP null client configuration########
$ yum install postfix 

##configuration in /etc/postfix/main.cf

$ vim /etc/postfix/main.cf

alias_database = hash:/etc/aliases
alias_maps = hash:/etc/aliases
command_directory = /usr/sbin
config_directory = /etc/postfix
daemon_directory = /usr/libexec/postfix
data_directory = /var/lib/postfix
debug_peer_level = 2
debugger_command = PATH=/bin:/usr/bin:/usr/local/bin:/usr/X11R6/bin ddd $daemon_directory/$process_name $process_id & sleep 5
html_directory = no
inet_interfaces = loopback-only
inet_protocols = all
local_transport = error: local delivery disabled
mail_owner = postfix
mailq_path = /usr/bin/mailq.postfix
manpage_directory = /usr/share/man
mydestination =
mydomain = cntech.local
myhostname = server1.cntech.local
mynetworks = 127.0.0.0/8
myorigin = $mydomain
newaliases_path = /usr/bin/newaliases.postfix
queue_directory = /var/spool/postfix
readme_directory = /usr/share/doc/postfix-2.10.1/README_FILES
relayhost = ipa.cntech.local
sample_directory = /usr/share/doc/postfix-2.10.1/samples
sendmail_path = /usr/sbin/sendmail.postfix
setgid_group = postdrop
unknown_local_recipient_reject_code = 550
:wq

##check for syntax  errors
$ postfix check 

##check for non-deafult configuration
$ postconf -n 