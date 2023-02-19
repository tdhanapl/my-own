#######################################add route table######################################
https://www.redhat.com/sysadmin/route-ip-route
############create temporary route table#################################################
$ route add default gw 192.168.4.254
$ route add -i net 192.169.1.0/24 netmask  255.255.0.9 gateway 192.168.1.1
$ route add -net 17.16.4.0 netmask 255.255.254.0 gw 172.16.4.251
$ route add -net 172.16.100.0 netmask 255.255.255.0 gw 172.16.100.1
$ route add -net 192.168.85.0 netmask 255.255.255.0 gw 192.168.85.99
$ route  add -net 10.33.58.0 netmask 255.255.255.0 gw  10.32.39.254

####################################Create Permanent Static Routes#########################################
The static routes configured in the previous section are all transient, in that they are lost on reboot.
To permanently configure static routes, you can configure them by creating a route-interface file in the /etc/sysconfig/network-scripts/ directory for the interface.
For example, static routes for the enp1s0 interface would be stored in the /etc/sysconfig/network-scripts/route-enp1s0 file. 
Any changes that you make to a route-interface file do not take effect until you restart either the network service or the interface. 
To configure a permanent static route for an interface, create a file with the following format "/etc/sysconfig/network-scripts/route-<INTERFACE>". 
1. For example, we could create the "/etc/sysconfig/network-scripts/route-eth0" file with the following entries.
172.168.2.0/24 via 192.168.0.1 dev eth0
172.168.4.0/24 via 192.168.0.1 dev eth0
     #or
2.#NM: 172.16.4.0/24 via 172.16.4.254
ADDRESS0=172.16.4.0  # 0=address key prompt
NETMASK0=255.255.254.0
GATEWAY0=172.16.4.254 
