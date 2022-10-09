Questions 1 Password Recovery.
Recover the root password as "postroll" on a given virtual server.
ANSWER:

at the start prompt of linux select kernel and press e ----> go to linux 16 line, press end key there it will reach at UTF-8 please type there.

rd.break console=ttyl

--> ctlr+x
#mount -o remount,rw /sysroot
#chroot /sysroot

-->#passwd root

-->New Password:

-->Retype new passwd:

-->#touch /.autorelabel

-->#exit

-->#exit      (2 time exit is required)

(if progras is showing with 33.21.. (its done) Now you get cmdline prompt, so login as root with postroll password and set to graphical.target].
##After login into root sucessfull
#systemctl set-default graphical.target 
#systemctl reboot

Questions 2 Configure IP Address. Configure Static IP address with
IP Address:172.25.X.11
Subnet mask:255.255.255.0
Gateway:172.25.X.254
DNS:172.25.254.254
DNS search path example.com

ANSWER:

#nmcli connection modify "System eth0" ipv4.addresses "172.25.0.11/24 172.25.0.254"
#nmcli connection modify "System eth0" ipv4.dns 172.25.254.254
#nmcli connection modify "System eth0" ipv4.method manual 
#nmcliconnection modify "System eth0" connection.autoconnect yes
#nmcli connection modify "System eth0" ipv4.dns-search "example.com"

Questions 3 Setup an HostName. Configure your hostname as "serverx.example.com".

ANSWER:

#hostnamectl set-hostname servero.example.com
#bash or exec bash ##forcelly update the kernel
Questions 4 Configure Selinux. Set the selinux policy in Enfrocing mode.

ANSWER:

$ vim /etc/syaconfig/selinux 
SELINUX=Enforcing
:wq
#sestatus
#setenforce 1

