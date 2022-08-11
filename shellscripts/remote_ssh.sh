#!/bin/bash
tput setf 2
for servername in 'cat /home/serverlist'
do
#ssh dhanapal@$servername sh /scripts/diskspace.sh
ssh root@ec2-15-206-67-34.ap-south-1.compute.amazonaws.com sh /home/ec2-user/server_reachable_check.sh 
done
