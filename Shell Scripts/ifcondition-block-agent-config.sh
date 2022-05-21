#!/bin/bash
#Author=
#Purpose=
#Creation date=
#Modificaton date=
port=$(netstat -anp  | grep :2111 )
#port=$(netstat -anp  | grep :2111 | awk '{print $4}')
ps=$(ps -ef | grep dsa )
# example taken from this ! -z "$var"
if [ ! -z "$port" -a !  -z "$ps " ]
then
echo "port  is open"
echo "proces  is  running "

echo 'su – riverbed'
#password=
cp -rvf /opt/Panorama/hedzup/mn/data/dsa.ml /home/dsa.ml.bak
cd /opt/Panorama/hedzup/mn/bin
./dsactl stop
sed -i 's/Attribute name="ManageableByRemoteAgent" value="true"/Attribute name="ManageableByRemoteAgent" value="false"/gI' /opt/Panorama/hedzup/mn/data/dsa.ml
./dsactl start
echo '&port'
else 
   echo " process  is not running or port is not open "

fi


