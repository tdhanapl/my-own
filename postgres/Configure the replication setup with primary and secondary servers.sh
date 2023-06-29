##Configure the replication of standby database postgres
Step1:
First install postgres database in primary server and start the service.
Step2:
Connect to the database and create database
Step3:
Change some configuration in primary server of  postgres.conf and pg_hba.conf
##first changes in postgres.conf
$ vim postgres.conf
listen_addresses = '*'
port = 5432
max_connections = 1000
shared_buffers = 128MB
wal_level = replica 

# - Archiving -
archive_mode = on               # enables archiving; off, on, or always
                                # (change requires restart)
archive_command = 'cp %p /opt/archivedir/%f'            # command to use to archive a logfile segment
max_wal_senders = 10            # max number of walsender processes
wal_keep_size = 0               # in megabytes; 0 disables

# REPORTING AND LOGGING
#------------------------------------------------------------------------------
# - Where to Log -

log_destination = 'stderr'              	# Valid values are combinations of
											# stderr, csvlog, syslog, and eventlog,
											# depending on platform.  csvlog
											# requires logging_collector to be on.
# This is used when logging to stderr:
logging_collector = on                  	# Enable capturing of stderr and csvlog
											# into log files. Required to be on for
											# csvlogs.
											# (change requires restart)
# These are only used if logging_collector is on:
log_directory = 'log'                   	# directory where log files are written,
											# can be absolute or relative to PGDATA
log_filename = 'postgresql-%a.log'      	# log file name pattern,
											# can include strftime() escapes
#log_file_mode = 0600                   	# creation mode for log files,
											# begin with 0 to use octal notation
log_rotation_age = 1d                       # Automatic rotation of logfiles will
											# happen after that time.  0 disables.
log_rotation_size = 0                       # Automatic rotation of logfiles will
											# happen after that much log output.
											# 0 disables.
log_truncate_on_rotation = on           	# If on, an existing log file with the
											# same name as the new log file will be
											# truncated rather than appended to.
											# But such truncation only occurs on
											# time-driven rotation, not on restarts
											# or size-driven rotation.  Default is
                                            # off, meaning append to existing files
                                            # in all cases.
:wq

##Second changes in pg_hba.conf
$ vim pg_hba.conf

# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     md5
# IPv4 local connections:
host    all             all             127.0.0.1/32            scram-sha-256

host    all             all             0.0.0.0/0            md5

host    all             all             10.10.1.88/24            md5
host    all             all             ::/0            md5
# IPv6 local connections:
host    all             all             ::1/128                 scram-sha-256
# Allow replication connections from localhost, by a user with the
# replication privilege.
local   replication     all                                     peer
host    replication     all             127.0.0.1/32            scram-sha-256
host    replication     all             ::1/128                 scram-sha-256

host    replication     all             10.10.1.88/24           md5
:wq

##After changing the configuartion file restart the service.
$ systemctl restart  postgres-14.service
$ systemctl status   postgres-14.service
Step4:
Now install postgres database in secondary  server and start the service.
Step5:
After starting the service we need delete  the configuration file in /var/lib/pgsql/14/data/ of secondary server.
Step6:
Now the following below command  used for replication setup of standby database
nohup /usr/pgsql-14/bin/pg_basebackup -h 10.10.1.173 -U postgres -p 5432 -D /var/lib/pgsql/14/data/ -c fast -X stream -R &