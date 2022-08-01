#!/bin/sh

# Define your function here
ipaddress () {
	   echo " hostname -i will display ipaddress of server"
	   hostname -i
   }

# Invoke your function
ipaddress
