#############Assign an IP, Netmask, and Broadcast to Network Interface#########
1.How to Assign an IP Address to Network Interface
To assign an IP address to a specific interface, use the following command with an interface name (eth0) and ip address that you want to set. For example, “ifconfig eth0 172.16.25.125” will set the IP address to interface eth0.
$ ifconfig eth0 172.16.25.125
2.How to Assign a Netmask to Network Interface
Using the “ifconfig” command with the “netmask” argument and interface name as (eth0) allows you to define a netmask to a given interface. For example, “ifconfig eth0 netmask 255.255.255.224” will set the network mask to a given interface eth0.
$ ifconfig eth0 netmask 255.255.255.224
3. How to Assign a Broadcast to Network Interface
Using the “broadcast” argument with an interface name will set the broadcast address for the given interface. For example, the “ifconfig eth0 broadcast 172.16.25.63” command sets the broadcast address to an interface eth0.
$ ifconfig eth0 broadcast 172.16.25.63
4.How to Assign an IP, Netmask, and Broadcast to Network Interface
To assign an IP address, Netmask address, and Broadcast address all at once using the “ifconfig” command with all arguments as given below.
$ ifconfig eth0 172.16.25.125 netmask 255.255.255.224 broadcast 172.16.25.63
5.How to Change MTU for a Network Interface
The “mtu” argument sets the maximum transmission unit to an interface. The MTU allows you to set the limit size of packets that are transmitted on an interface. The MTU is able to handle a maximum number of octets to an interface in one single transaction.
For example, “ifconfig eth0 mtu 1000” will set the maximum transmission unit to a given set (i.e. 1000). Not all network interfaces support MTU settings.
$ ifconfig eth0 mtu 1000
6.View Network Settings of Specific Interface
Using interface name (eth0) as an argument with the “ifconfig” command will display details of the specific network interface.
$ ifconfig eth0

eth0      Link encap:Ethernet  HWaddr 00:0B:CD:1C:18:5A
          inet addr:172.16.25.126  Bcast:172.16.25.63  Mask:255.255.255.224
          inet6 addr: fe80::20b:cdff:fe1c:185a/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2345583 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2221421 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:293912265 (280.2 MiB)  TX bytes:1044100408 (995.7 MiB)
          Interrupt:185 Memory:f7fe0000-f7ff0000
4. How to Enable a Network Interface
The “up” or “ifup” flag with interface name (eth0) activates a network interface if it is not inactive state and allowing to send and receive information. For example, “ifconfig eth0 up” or “ifup eth0” will activate the eth0 interface.
$ ifconfig eth0 up
	OR
$ ifup eth0
5. How to Disable a Network Interface
The “down” or “ifdown” flag with interface name (eth0) deactivates the specified network interface. For example, the “ifconfig eth0 down” or “ifdown eth0” command deactivates the eth0 interface if it is in an inactive state.
$ ifconfig eth0 down
OR
$ ifdown eth0
6. How to Change MTU for a Network Interface
The “mtu” argument sets the maximum transmission unit to an interface. The MTU allows you to set the limit size of packets that are transmitted on an interface. The MTU is able to handle a maximum number of octets to an interface in one single transaction.
For example, “ifconfig eth0 mtu 1000” will set the maximum transmission unit to a given set (i.e. 1000). Not all network interfaces support MTU settings.
$ ifconfig eth0 mtu 1000
7. How to Enable Promiscuous Mode
What happens in normal mode, when a packet is received by a network card, it verifies that it belongs to itself. If not, it drops the packet normally, but in the promiscuous mode is used to accept all the packets that flow through the network card.
Today’s network tools use the promiscuous mode to capture and analyze the packets that flow through the network interface. To set the promiscuous mode, use the following command.
$ ifconfig eth0 promisc
8. How to Disable Promiscuous Mode
To disable promiscuous mode, use the “-promisc” switch that drops back the network interface in normal mode.
$ ifconfig eth0 -promisc
9. How to Add New Alias to Network Interface
The ifconfig utility allows you to configure additional network interfaces using the alias feature. To add the alias network interface of eth0, use the following command. Please note that the alias network address is in the same subnet mask. For example, if your eth0 network ip address is 172.16.25.125, then the alias ip address must be 172.16.25.127.
$ ifconfig eth0:0 172.16.25.127
Next, verify the newly created alias network interface address, by using the “ifconfig eth0:0” command.
$ ifconfig eth0:0

eth0:0    Link encap:Ethernet  HWaddr 00:01:6C:99:14:68
          inet addr:172.16.25.123  Bcast:172.16.25.63  Mask:255.255.255.240
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:17
10. How to Remove Alias to Network Interface
If you no longer required an alias network interface or you incorrectly configured it, you can remove it by using the following command.
$ ifconfig eth0:0 down
11 How to Change the MAC address of Network Interface
To change the MAC (Media Access Control) address of an eth0 network interface, use the following command with the argument “hw ether“. For example, see below.
$ ifconfig eth0 hw ether AA:BB:CC:DD:EE:FF
These are the most useful commands for configuring network interfaces in Linux, for more information and usage of the ifconfig command use the manpages like “man ifconfig” at the terminal. Check out some other networking utilities below.

#Other Networking Utilities
#nmcli – a command-line client that is used to control NetworkManager and report network information.
#Tcmpdump – is a command-line packet capture and analyzer tool for monitoring network traffic.
#Netstat – is an open-source command-line network monitoring tool that monitors incoming and outgoing network packets traffic.
#ss (socket statistics) – a tool that prints network socket-related information on a Linux system.
#Wireshark – is an open-source network protocol analyzer that is used to troubleshoot network-related issues.
#Munin – is a web-based network and system monitoring application that is used to display results in graphs using rrdtool.
#Cacti – is a complete web-based monitoring and graphing application for network monitoring.