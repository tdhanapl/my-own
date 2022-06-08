######################################To known all  services status#####################################################
#systemctl list-units --type=service --state=active
OR
#systemctl daemon-reload
# systemctl --type=service --state=active
# systemctl list-units --type=service
# systemctl --type=service --state=enbaled
# systemctl --type=service --state=active 
# systemctl --type=service --state=stop
# systemctl --type=service --state=disabled
OR
# systemctl --type=service 
OR
#systemctl list-unit-files

#######Entry hostname with FQDN and ip address  in /etc/hosts############

echo `hostname -i | awk '{print $NF}'`" "`hostname`" "`hostname -s`  >> /etc/hosts
##################################Fstab configurtion Fromat########################################################
LABEL=cloudimg-rootfs   		/        ext4   			defaults,discard       0	 		1
device name 		    mountpoint    file system type		permission            backup  		fsck(File System Consistency Check)
#################How to Change Runlevels (targets) in Systemd##############################

Systemd is a modern init system for Linux: a system and service manager which is compatible with the popular SysV init system and LSB init scripts. It was intended to overcome the shortcomings of SysV init as explained in the following article.

The Story Behind ‘init’ and ‘systemd’: Why ‘init’ Needed to be Replaced with ‘systemd’ in Linux
On Unix-like systems such as Linux, the current operating state of the operating system is known as a runlevel; it defines what system services are running. Under popular init systems like SysV init, runlevels are identified by numbers. However, in systemd runlevels are referred to as targets.

In this article, we will explain how to change runlevels (targets) with systemd. Before we move any further, let’s briefly under the relationship between runlevels numbers and targets.

Run level 0 is matched by poweroff.target (and runlevel0.target is a symbolic link to poweroff.target).
Run level 1 is matched by rescue.target (and runlevel1.target is a symbolic link to rescue.target).
Run level 3 is emulated by multi-user.target (and runlevel3.target is a symbolic link to multi-user.target).
Run level 5 is emulated by graphical.target (and runlevel5.target is a symbolic link to graphical.target).
Run level 6 is emulated by reboot.target (and runlevel6.target is a symbolic link to reboot.target).
Emergency is matched by emergency.target.
How to View Current target (run level) in Systemd
When the system boots, by default systemd activates the default.target unit. It’s main work is to activate services and other units by pulling them in via dependencies.

To view the default target, type the command below.
#systemctl get-default 
graphical.target

To set the default target, run the command below.
# systemctl set-default multi-user.target  

How to Change the target (runlevel) in Systemd
While the system is running, you can switch the target (run level), meaning only services as well as units defined under that target will now run on the system.

To switch to runlevel 3, run the following command.
# systemctl isolate multi-user.target 
To change the system to runlevel 5, type the command below.
# systemctl isolate graphical.target

################################### how many Type of File in Linux##########################
--- ->Text file
d   -> Directory
c   -> Character
l   -> Linked File
b   -> blocked file
p   -> proces id file
.   -> selinux
+   -> ACL
############################Disk identification#####################################################################
#fdisk -l
/dev/sda -> SCSI hard disk
/dev/hda -> IDE hard disk 
/dev/vda -> Virtual hard disk

##############################Find old 90 or 30 days and remove that files#####################
find /var/log -type f -mtime +30 -exec ls -lrth {} \;  ##f--means file 
find /var/log -type f -mtime +30 -exec rem -rvf {} \;     ## +30--means more than 30 days
find /var/log -type f -mtime +7 -exec rem -rvf  {} \;
find /var/log -type d -mtime +90 -exec ls -lrth {} \;  ###d--means directory,  +90--means more than 90 days
find /var/log -type d -mtime +30 -exec ls -rv {} \;
find /var/dtpdev/tmp/ -type f -mtime +15 -exec r3m -f {} +
find /path/to/files/ -type f -name *.php  -mtime +30 -exec rm {} \;
#####################find more +100m size #######################
find /var/ -type f -size +100M -exec ls -ltr {} \;
#######################################realtime issue###################################
1#application is not working and kubernetes pod unable start because of security team blocked /bin/get_secret defaultdb_user_password then we asked va 
team unblocked the path then pod start to run fine then application running fine.
File name: get_secret
File path: /bin/get_secret
Command line: /bin/get_secret defaultdb_user_password
2.#Zenworker is not able acess admin page because pervious the application restart but my assumption is application is not restart praperally that why i 
suggested to restart again .
we taken approval and we restart the application then admin is able login
3.#application is unable to access due to cpu utilization high the application  is able access  after cpu utillization  under stable.
############################Assgine static IP Address############################
vi /etc/sysconfig/network-scripts/ifcfg-ens33
TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=static
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=eno1
UUID=02a690cb-b0ad-421b-ba18-0bb2722fdfc0
DEVICE=eno1
ONBOOT=yes
IPADDR=192.16.4.17
PREFIX=23
GATEWAY=172.16.4.251
DNS1=10.33.0.19
DNS2=10.33.0.22
IPV6_PRIVACY=no
:wq
#######################################add route table######################################
https://www.redhat.com/sysadmin/route-ip-route
############create temporary route table#################################################
#route add default gw 192.168.4.254
#route add -i net 192.169.1.0/24 netmask  255.255.0.9 gateway 192.168.1.1
# route add -net 17.16.4.0 netmask 255.255.254.0 gw 172.16.4.251
#route add -net 172.16.4.0 netmask 255.255.254.0 gw 172.16.4.254
#route add -net 192.168.85.0 netmask 255.255.255.0 gw 192.168.85.99
#route  add -net 10.33.58.0 netmask 255.255.255.0 gw  10.32.39.254
####################################Create Permanent Static Routes#########################################
The static routes configured in the previous section are all transient, in that they are lost on reboot.
 To configure a permanent static route for an interface, create a file with the following format "/etc/sysconfig/network-scripts/route-<INTERFACE>". 
1. For example, we could create the "/etc/sysconfig/network-scripts/route-eth0" file with the following entries.
172.168.2.0/24 via 192.168.0.1 dev eth0
172.168.4.0/24 via 192.168.0.1 dev eth0
     #or
2.#NM: 172.16.4.0/24 via 172.16.4.254
ADDRESS0=172.16.4.0  # 0=address key prompt
NETMASK0=255.255.254.0
GATEWAY0=172.16.4.254 
###########################application error#################################
503-Server overload
504 Gateway Timeout
502 Bad Gateway server error response code indicates that the server, while acting as a gateway or proxy,
    received an invalid response from the upstream server.
400 Bad Request response status code indicates that the server cannot or will not process the request due
    to something that is perceived to be a client error 
    (for example, malformed request syntax, invalid request message framing, or deceptive request routing).
##################login profile##################################
cat /etc/skel/.
1- .bashrc
2- .bash_logout
3- .bash_profile
##################stderror save in file#########################
$llsss 2> error-file.txt
################How to change priority of running process#################################
##To check all running process
$ ps -ef 
#################change priority values or renice value###########
$ renice -10 <PID>
$ renice -10 16995
########what is range of nice value####################
  from -20 to +20 
################################Find Top Running Processes by Highest Memory and CPU Usage in Linux##################
#Find Top Running Processes by Highest Memory and CPU Usage in Linux
 $ ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head
 $ ps -eo pid,ppid,%cpu,%mem,cmd --sort=-%mem | head
############Find Top 15 Processes by Memory Usage with ‘top’ in Batch Mode######
$top -b -o +%MEM | head -n 22
$top -b -o +%MEM | head -n 22 > topreport.txt
################To know traffic to server or capture traffic##########
$ tcpdump  -A . port
############################2 Ways to Re-run Last Executed Commands in Linux#################
$ history 
Then get the number(s) of the command(s) you want to re-execute (if, for example you want to restart 
PHP-FPM and view its status, you need to re-execute the commands 997 and 998) as shown.
$ !997
$ !998
#######################Disable Root Account in Linux#############################
1. Change root User’s Shell
 #$ sudo vim /etc/passwd
 Change the line:
  root:x:0:0:root:/root:/bin/bash
 to
 root:x:0:0:root:/root:/sbin/nologin
3.Disabl SSH Root Login
$ sudo vim /etc/ssh/sshd_config
  the directive PermitRootLogin:no and set its value to no 
4. Restrict root Acess to Services Via PAM
$ sudo vim /etc/pam.d/login
OR
sudo vim /etc/pam.d/sshd
Next, add the configuration below in both files.
auth    required       pam_listfile.so \
        onerr=succeed  item=user  sense=deny  file=/etc/ssh/deniedusers
		
##########################################Logical voulme Creation############################
disk /dev/sda
pvcreate /dev/sda
pvs
vgcreate vgikt /dev/sda
vgs
lvcreate -L 4GB -n logical vgikt
lvgs
lsblk
lvsdisplay vgikt
# Format the partion
mkfs.ext4 /dev/vgikt/logical
#Mounting 
mkdir ikt
mount /dev/vgikt/logical ikt
df -h
# Perment mount 
vim /etc/fstab
/dev/mapper/vgikt/logical /ikt ext4 defaults 0 0
:wq
mount -q
###Extended the volume group
pvcreate /dev/sda3
vgextend vgikt /dev/sda3
lvextend -L +5G /dev/vgikt/logical
Noted=+ we have mention if not mention it will reduce to 5GB only not adding 5GB and data will also lose.
# To update the resize LV
resize /dev/vgikt/logical
df -h
# To change name of logical volume
lvrename vgikt logical lvdisk
# To view block UID
blkid
#############################Crontab jobs#######################################################
Linux Crontab Format
MIN HOUR DOM MON DOW CMD
Crontab Fields and Allowed Ranges (Linux Crontab Syntax)
Field    Description    Allowed Value
MIN      Minute field    0 to 59
HOUR     Hour field      0 to 23
DOM      Day of Month    1-31
MON      Month field     1-12
DOW      Day Of Week     0-6  (1-6 -Mon, Tue, Wed, Thu and Fri Sat and 0 or 7-sunday)
CMD      Command         Any command to be executed.
how to set crontab 
#crontab -e
To list the cron job
#crontab -l
*********************Crontab job store path**************
#cd /var/spool/cron
here list all cron jobs with username also.
####realtime cron job
backup
compress
archive
log deletion
file copy remote
application  relative cron job
log rotation
#Execute multiple tasks using a single cron
15 0 * * * /home/scripts/backup.sh; /home/scripts/scritp.sh
#The system administrator can use a system-wide cron schedule which comes under the predefine cron directory as shown below
/etc/cron.d
/etc/cron.daily
/etc/cron.hourly
/etc/cron.monthly
/etc/cron.weekly
####################################Port number#######################
tcp-6
udp-17
ftp-20-data tranfer and 21 communication bewteen two computer
ssh-22
telnet-23 
smtp-25
smtps-543
http-80
https-443
ssl-443
dns(domain name server)-53
dhcp(dynamic host configuration protocal)-68 client and 67 server
kerbeors-88
ldap-389
pop3-110
imap-143
pop3s-995
imaps-993
syslog-514
nfs-2049
rdp-3389
jenkins-8080
samba-138
iscsi(internet small computer system information)-3260
############################Selinux ################################################
It is set of policies and modules which are going to be applied on the machine to improve overall security of the machine.
We can implement  Selinux policies in there modes
1.Enforcing
2.Permmessive
3.Disabled
########permanent SElinux###########
Configuration file of selinux
1 /etc/selinux/config ----main configuration file
2 /etc/sysconfig/seliux ---link file for above configuration 
SELINUX= can take one of these three values
#####temporary SElimux##########
# enforcing - SELinux security policy is enforced.
# permissive - SELinux prints warnings instead of enforcing.
# disabled - No SELinux policy is loaded
To change the mode from enforcing to permissive type:
sudo setenforce 0
To turn the enforcing mode back on, enter:
sudo setenforce 1
########################Zombie process #################################

Zombie process which is running without child process .it is identified  with 'z' 
###########################Linux booting process #################################
1-BIOS(Basic input/ouput system)-performs some system intergrity checks
2-MBR(master boot )-MBR is less than 512 bytes in size. It contains information about grub . In simple terms MBR loads and excute boot loader.
3-GRUB(GRand Unified Bootloader)-It contains multiple kernel images, It will choose which one to be executed.
4-KERNEL-kernel execute the /sbin/init program.since init 1st program to be executed by kernel, it has the process id(PID) of 1
5-INIT- It looks the /etc/inittab file to decide the linux run levels
6-RUN LEVELS-when the Linux booting up in run levels check deafult then services in the up

##########################Linux system information###############################
lspci------------To check mechine is physical or virtual server 
demicode---------To chek hardware information
dmesg------------message log 
lscpu------------To check cpu information
vmstat-----------To check virtual memory statics
iostat-----------To check i/p, o/p static disk
sar--------------To check load average
top--------------To check cpu utilization
systemctl get-default---To known system default run levels or target 
####### List Mounted Drives on Linux###############
1) Listing from /proc/mounts using cat command
   #cat /proc/mounts
2)Using Mount Command
   #mount
3) Using df command
   #df -Th
4 ) Using findmnt
   #findmnt
#######################To run customized command#####################
 run custom command
Configure a custom command in system1 and in system2 with the name
"custom" every one can excute /bin/ps -aux command
Ans:
[root@server6 ~]# vim /etc/bashrc
at last add a line
alias custom='/usr/bin/ps -aux'
[root@server6 ~]# source /etc/bashrc
[root@server6 ~]# custom

##########################How to Send a Message to Logged Users in Linux Terminal###############
 echo "server is down from 12-3 pm " | wall
 
############################################### yum repository redhat 8 version ########################################
mkdir  /opt/yum-repository/BaseOs  /opt/yum-repository/Appstream
mount /dev/sr0 /mnt
cp -rvf /mnt/BaseOs/* /opt/yum-repository/BaseOs
cp -rvf /mnt/BaseOs/* /opt/yum-repository/Appstream
df -h
umount /mnt
cd /home/yum-repository/BaseOs && ls -l
cd /home/yum-repository/Appstream && ls -l
cd
vi /etc/yum.repos.d/local_yum.repo
[InstallMedia-BaseOS]
name=BaseOs
baseurl=file:///home/yum-repository/BaseOs/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

[InstallMedia-AppStream] 
name=AppStream
baseurl=file:///home/yum-repository/AppStream/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
:wq
yum clean all
yum repolist all
AppStream
dr-xr-xr-x. 4 root root 38 Feb  4 07:08 BaseOS
#############################epel repository download####################################
https://docs.fedoraproject.org/en-US/epel/#_el7
RHEL 8
subscription-manager repos --enable codeready-builder-for-rhel-8-$(arch)-rpms
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
CentOS Linux 8, AlmaLinux 8, Rocky Linux 8
dnf config-manager --set-enabled powertools
dnf install epel-release
EL7
RHEL 7
subscription-manager repos --enable rhel-*-optional-rpms \
                           --enable rhel-*-extras-rpms \
                           --enable rhel-ha-for-rhel-*-server-rpms
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
########To check dependencies for particular package with rpm########
$ rpm -qPR httpd-2.4.6*
	--here it will list package
##############To check configuartion file##########################
$rpm -ql httpd*
###################Remove package with yum################################
$yum remove httpd
	--here it does not removes the dependencies
$ yum autoremove httpd
	--here it removes all dependencies with packages 
######################################Extended Swap Space########################################
# Scan new lun on server with below command
ls /sys/class/scsi_host/host | while read host ; do echo "---" > /sys/class/scsi_host/$host/scan ; done
##############how to check open port in remote server##################
$nmap -A <remote-sever-ip>
$nmap -A 192.168.1.5
#############echo "---" > /sys/class/scsi_host/host{x}/scan
#"---" {-=channel,-=scsi id,-=lun} In the above command means CTL["channel on HBA" "Target Scsi id" "LUN"] 
# Vertify the new lun [ to check the new assaign to the system with size]
pvs -a -o +dev_size
systool -c fc_host | grep "port"
Add 5GB hard disk
lsblk
fdisk /dev/sdc
Command (m for help): n
Partition type :;
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 3
First sector (2048-20967390, default 2048):
Last sector, +sectors or +size{K,M,G,T,P} (2048-20967390, default 20967390): +2G
Created a new partition 3 of type 'Linux' and of size 2 GiB.
Command (m for help): p
Disk /dev/xvda2: 10 GiB, 10735304192 bytes, 20967391 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xb7c41e14
Device       Boot Start     End Sectors Size Id Type
/dev/xvda2p3       2048 4196351 4194304   2G 83 Linux
Command (m for help): t
Selected partition 3
Hex code (type L to list all codes): L
 0  Empty           24  NEC DOS         81  Minix / old Lin bf  Solaris
 1  FAT12           27  Hidden NTFS Win 82  Linux swap / So c1  DRDOS/sec (FAT-
 2  XENIX root      39  Plan 9          83  Linux           c4  DRDOS/sec (FAT-
 3  XENIX usr       3c  PartitionMagic  84  OS/2 hidden or  c6  DRDOS/sec (FAT-
 4  FAT16 <32M      40  Venix 80286     85  Linux extended  c7  Syrinx
 5  Extended        41  PPC PReP Boot   86  NTFS volume set da  Non-FS data
 6  FAT16           42  SFS             87  NTFS volume set db  CP/M / CTOS / .
 7  HPFS/NTFS/exFAT 4d  QNX4.x          88  Linux plaintext de  Dell Utility
 8  AIX             4e  QNX4.x 2nd part 8e  Linux LVM       df  BootIt
 9  AIX bootable    4f  QNX4.x 3rd part 93  Amoeba          e1  DOS access
 a  OS/2 Boot Manag 50  OnTrack DM      94  Amoeba BBT      e3  DOS R/O
 b  W95 FAT32       51  OnTrack DM6 Aux 9f  BSD/OS          e4  SpeedStor
 c  W95 FAT32 (LBA) 52  CP/M            a0  IBM Thinkpad hi ea  Rufus alignment
 e  W95 FAT16 (LBA) 53  OnTrack DM6 Aux a5  FreeBSD         eb  BeOS fs
#f  W95 Ext'd (LBA) 54  OnTrackDM6      a6  OpenBSD         ee  GPT
10  OPUS            55  EZ-Drive        a7  NeXTSTEP        ef  EFI (FAT-12/16/
11  Hidden FAT12    56  Golden Bow      a8  Darwin UFS      f0  Linux/PA-RISC b
12  Compaq diagnost 5c  Priam Edisk     a9  NetBSD          f1  SpeedStor
14  Hidden FAT16 <3 61  SpeedStor       ab  Darwin boot     f4  SpeedStor
16  Hidden FAT16    63  GNU HURD or Sys af  HFS / HFS+      f2  DOS secondary
17  Hidden HPFS/NTF 64  Novell Netware  b7  BSDI fs         fb  VMware VMFS
18  AST SmartSleep  65  Novell Netware  b8  BSDI swap       fc  VMware VMKCORE
1b  Hidden W95 FAT3 70  DiskSecure Mult bb  Boot Wizard hid fd  Linux raid auto
1c  Hidden W95 FAT3 75  PC/IX           bc  Acronis FAT32 L fe  LANstep
1e  Hidden W95 FAT1 80  Old Minix       be  Solaris boot    ff  BBT
Hex code (type L to list all codes): 8e
Changed type of partition 'Linux' to 'Linux LVM'.
Command (m for help): wq
#partprobe # It update kernel without restart after partition creation 
$ lsblk
## making   swap disk partition
Amount of RAM in the system	Recommended swap space	Recommended swap space if allowing for hibernation
⩽ 2 GB		2 times the amount of RAM	        	3 times the amount of RAM
> 2 GB 		– 8 GB	Equal to the amount of RAM		2 times the amount of RAM
> 8 GB 		– 64 GB	At least 4 GB	            	1.5 times the amount of RAM
> 64 GB		At least 4 GB							Hibernation not recommended
					or
If ram size is  lessthan 2GB then RAMx2 times of swap size
If ram size is  greaterthan 2GB then RAM size + 2 GB
swapoff   /dev/sdc
mkswap    /dev/sda2
swapon -a /dev/sda2
#######################################user administartion##########################
#usermod --help
 -c, --comment COMMENT         new value of the GECOS field
  -d, --home HOME_DIR           new home directory for the user account
  -e, --expiredate EXPIRE_DATE  set account expiration date to EXPIRE_DATE
  -f, --inactive INACTIVE       set password inactive after expiration
                                to INACTIVE
  -g, --gid GROUP               force use GROUP as new primary group
  -G, --groups GROUPS           new list of supplementary GROUPS
  -a, --append                  append the user to the supplemental GROUPS
                                mentioned by the -G option without removing
                                him/her from other groups
  -h, --help                    display this help message and exit
  -l, --login NEW_LOGIN         new value of the login name
  -L, --lock                    lock the user account
  -m, --move-home               move contents of the home directory to the
                                new location (use only with -d)
  -o, --non-unique              allow using duplicate (non-unique) UID
  -p, --password PASSWORD       use encrypted password for the new password
  -R, --root CHROOT_DIR         directory to chroot into
  -s, --shell SHELL             new login shell for the user account
  -u, --uid UID                 new UID for the user account
  -U, --unlock                  unlock the user account
  -v, --add-subuids FIRST-LAST  add range of subordinate uids
  -V, --del-subuids FIRST-LAST  remove range of subordinate uids
  -w, --add-subgids FIRST-LAST  add range of subordinate gids
  -W, --del-subgids FIRST-LAST  remove range of subordinate gids
  -Z, --selinux-user SEUSER     new SELinux user mapping for the user account
  
#useradd --help
 -b, --base-dir BASE_DIR       base directory for the home directory of the
                                new account
  -c, --comment COMMENT         GECOS field of the new account
  -d, --home-dir HOME_DIR       home directory of the new account
  -D, --defaults                print or change default useradd configuration
  -e, --expiredate EXPIRE_DATE  expiration date of the new account
  -f, --inactive INACTIVE       password inactivity period of the new account
  -g, --gid GROUP               name or ID of the primary group of the new
                                account
  -G, --groups GROUPS           list of supplementary groups of the new
                                account
  -h, --help                    display this help message and exit
  -k, --skel SKEL_DIR           use this alternative skeleton directory
  -K, --key KEY=VALUE           override /etc/login.defs defaults
  -l, --no-log-init             do not add the user to the lastlog and
                                faillog databases
  -m, --create-home             create the user's home directory
  -M, --no-create-home          do not create the user's home directory
  -N, --no-user-group           do not create a group with the same name as
                                the user
  -o, --non-unique              allow to create users with duplicate
                                (non-unique) UID
  -p, --password PASSWORD       encrypted password of the new account
  -r, --system                  create a system account
  -R, --root CHROOT_DIR         directory to chroot into
  -s, --shell SHELL             login shell of the new account
  -u, --uid UID                 user ID of the new account
  -U, --user-group              create a group with the same name as the user
  -Z, --selinux-user SEUSER     use a specific SEUSER for the SELinux user mapping
      --extrausers              Use the extra users database
#chage --help
Usage: chage [options] LOGIN

Options:
  -d, --lastday LAST_DAY        set date of last password change to LAST_DAY
  -E, --expiredate EXPIRE_DATE  set account expiration date to EXPIRE_DATE
  -h, --help                    display this help message and exit
  -I, --inactive INACTIVE       set password inactive after expiration
                                to INACTIVE
  -l, --list                    show account aging information
  -m, --mindays MIN_DAYS        set minimum number of days before password
                                change to MIN_DAYS
  -M, --maxdays MAX_DAYS        set maximim number of days before password
                                change to MAX_DAYS
  -R, --root CHROOT_DIR         directory to chroot into
  -W, --warndays WARN_DAYS      set expiration warning days to WARN_DAYS
 
#groupadd -h
Usage: groupadd [options] GROUP

Options:
  -f, --force                   exit successfully if the group already exists,
                                and cancel -g if the GID is already used
  -g, --gid GID                 use GID for the new group
  -h, --help                    display this help message and exit
  -K, --key KEY=VALUE           override /etc/login.defs defaults
  -o, --non-unique              allow to create groups with duplicate
                                (non-unique) GID
  -p, --password PASSWORD       use this encrypted password for the new group
  -r, --system                  create a system account
  -R, --root CHROOT_DIR         directory to chroot into
      --extrausers              Use the extra users database
	  
#groupmod -h
Usage: groupmod [options] GROUP

Options:
  -g, --gid GID                 change the group ID to GID
  -h, --help                    display this help message and exit
  -n, --new-name NEW_GROUP      change the name to NEW_GROUP
  -o, --non-unique              allow to use a duplicate (non-unique) GID
  -p, --password PASSWORD       change the password to this (encrypted)
                                PASSWORD
  -R, --root CHROOT_DIR         directory to chroot into

############################################ACL administartion##########################
#setfacl -h
setfacl 2.2.52 -- set file access control lists
Usage: setfacl [-bkndRLP] { -m|-M|-x|-X ... } file ...
  -m, --modify=acl        modify the current ACL(s) of file(s)
  -M, --modify-file=file  read ACL entries to modify from file
  -x, --remove=acl        remove entries from the ACL(s) of file(s)
  -X, --remove-file=file  read ACL entries to remove from file
  -b, --remove-all        remove all extended ACL entries
  -k, --remove-default    remove the default ACL
      --set=acl           set the ACL of file(s), replacing the current ACL
      --set-file=file     read ACL entries to set from file
      --mask              do recalculate the effective rights mask
  -n, --no-mask           don't recalculate the effective rights mask
  -d, --default           operations apply to the default ACL
  -R, --recursive         recurse into subdirectories
  -L, --logical           logical walk, follow symbolic links
  -P, --physical          physical walk, do not follow symbolic links
      --restore=file      restore ACLs (inverse of `getfacl -R')
      --test              test mode (ACLs are not modified)
  -v, --version           print version and exit
  -h, --help              this help text
 
#getfacl -h
getfacl 2.2.52 -- get file access control lists
Usage: getfacl [-aceEsRLPtpndvh] file ...
  -a,  --access           display the file access control list only
  -d, --default           display the default access control list only
  -c, --omit-header       do not display the comment header
  -e, --all-effective     print all effective rights
  -E, --no-effective      print no effective rights
  -s, --skip-base         skip files that only have the base entries
  -R, --recursive         recurse into subdirectories
  -L, --logical           logical walk, follow symbolic links
  -P, --physical          physical walk, do not follow symbolic links
  -t, --tabular           use tabular output format
  -n, --numeric           print numeric user/group identifiers
  -p, --absolute-names    dont strip leading '/' in pathnames
  -v, --version           print version and exit
  -h, --help              this help text

############################Dns Recorder#########################
types of DNS record?
A (Address Mapping )record - The record that holds the IP address of a domain. 
AAAA (IP Version 6 Address)record - The record that contains the IPv6 address for a domain (as opposed to A records, which list the IPv4 address). 
CNAME (Canonical Name )record - Forwards one domain or subdomain to another domain, does NOT provide an IP address. 
MX (Mail exchanger) record - Directs mail to an email server. 
TXT(Text Record) record - Lets an admin store text notes in the record. These records are often used for email security. 
NS (Name Serve)record - Stores the name server for a DNS entry. 
SOA(Start of Authority) record - Stores admin information about a domain. 
SRV (Service Location)record - Specifies a port for specific services. 
PTR (Reverse-lookup Pointer)record - Provides a domain name in reverse-lookups. 

###############Difference Between RHEL 6 & RHEL 7###########################
This page would list out some of the major differences between RHEL 7 and 6 variants and key features in RHEL 7. 
1.OS BOOT TIME
RHEL6: 40 sec
RHEL7: 20 sec

2.MAXIMUM SIZE OF SINGLE PARTITION
RHEL6: 50TB(EXT4)
RHEL7: 500TB(XFS)
signin password=Venky@0451
transcation password=venkatesh@0451
3.BOOT LOADER
RHEL6:  /boot/grub/grub.conf
RHEL7: /boot/grub2/grub.cfg

4.PROCESSOR ARCHITECTURE
RHEL6: It support 32bit & 64bit both
RHEL7: It only support 64bit

5.HOW TO FORMAT OR ASSIGN A FILE SYSTEM IN
RHEL6:      #mkfs.ext4   /dev/hda4
RHEL7:      #mkfs.xfs   /dev/hda3

6.HOW TO REPAIR A FILE SYSTEM IN
RHEL6:  #fsck -y /dev/hda3
RHEL7:  #xfs_repair /dev/hda3

7.COMMAND TO MANAGE NETWORK IN RHEL6 AND RHEL7
RHEL6:  #setup
RHEL7:  #nmtui
8.HOSTNAME CONFIGURATION FILE
RHEL6:    /etc/sysconfig/network
RHEL7:    /etc/hostname

9.FILE SYSTEM CHECK
RHEL6:   e2fsck
RHEL7:   xfs_repair

10.RESIZE A FILE SYSTEM
RHEL6:   #resize2fs -p /dev/vg00/lv1
RHEL7:    #xfs_growfs  /dev/vg00/lv1

11.TUNE A FILE SYSTEM
RHEL6: tune2fs
RHEL7: xfs_admin

12.IPTABLES AND FIREWALL
RHEL6: iptables
RHEL7: firewalld

13.IPtables
To see firewall status in RHEL7
#firewall-cmd   –state
To see Firewall status in RHEL6
#service iptables status
To stop firewall in RHEL7
#systemctl stop firewalld.service
To stop firewall in RHEL6
#service iptables stop

14.COMBINING NIC
RHEL6: Network Bonding
RHEL7: Team Driver
MANAGING SERVICES
RHEL6:
#service sshd restart
#chkconfig sshd on
RHEL7:
#systemctl restart sshd
#systemctl enable shhd SANKET

15.Kernel Version
RHEL6 default kernel version is 2.6 while RHEL7 is 3.10

16.UID Allocation
In RHEL6 default UID assigned to users would start from 500 while in RHEL7 it’s starting from 1000.
But this can be changed if required by editing /etc/login.defs file.

17.Change in file system structure
In rhel6 /bin,/sbin,/lib and /lib64 are usually under /
In rhel7, now /bin,/sbin,/lib and /lib64 are nested under /usr.

##############patching on red hat linux 7####################

#yum updateinfo list available   ------>To list all available erratas without installing them

#yum updateinfo list security all ------>To list all available security updates without installing them

#yum updateinto list sec ----- >o list all available security updates without installing them [yum info-sec |grep 'Critical:' ---see critical patches)
#yum updateinfo list security installed --->To get a list of the currently installed security updates

#yum updateinfo info security --------->To lint all available security updates with verboat descriptions of the Lasus they apply

# installing start from here

#####installation#####

1.#yum update --security ---------download and apply all available security updates from Red Hat Setwork hosted or Rent Network Satellite

2.#yum update-minimal security --------To install the package that have a security errate use

3.#yum update -cve <CVE>
e.g. 
#yum  update --cve CVE-2021-44228 ------To install a security update uning a CVE reference

4.#yum updateinfo list -------Viewing available advisories by severities

5.#yum update --advisory-=RHSA-2018:2942---apply only one specific  advisories

6.#yum updateinfo  RHSA-2020:1336------- know more information about this advisory before to apply it

7.#yum updateinfo list cves----view CEs which affect the system with

Password- harshsffdd677

8.#man yum-security to know about command

JB545235680in

###########################How to update the subscription#########################
##To check to subscription-manager or not 
[root@ebexinsp03 -1# subscription-manager list
System certificates corrupted. Please reregister.
[root@ebexjnsp03 -1# subscription-manager register --auto-attach
This system is already registered. Use --force to override
[root@ebexinsp03 -1# subscription-manager register --auto-attach --force
 Unregistering from: subscription.rham.redhat.com:44h/subscription
The system with UUID 81d4cf08-1512-431b-94a6-501a04c7c07f has been unregistered
All local data removed
Registering to: subscription.rham.redhat.com:443/subscription
Username: dhana.22unix
Password:
The system has been registered with ID: 475c6cb1-b872-479a-9bla-740780ddb834
The registered ayatem name is: ebexanapos
Installed Product Current Status:
Product Name: Red Hat Software Collections (for RHEL Server)
Status: Subscribed
Product Name: Red Hat Enterprise Linux Srever
Status: Subscribed
##To check to subscription-manager added or not 
$subscription-manager list
 or 
$subscription-manager version
##############Kernel-os-upgrade from 7.4 to 7.9##################################
1.  Login to RHEL as root user.
2. Ensure that yum’s cache is cleared out with the command.
[root@uaans ~]# yum clean all
Loaded plugins: langpacks, product-id, subscription-manager
This system is not registered to Red Hat Subscription Management. You can use subscription-manager to register.
Cleaning repos: InstallMedia uaans-repo
Cleaning up everything
[root@uaans ~]#

3.This procedure will work when your system is registered with RHSM (subscription-manager). 
To enable “–releasever” option, you need to register a system through subscription-manager
# subscription-manager register
# subscription-manager register --auto-attach

4.List the subscription available version  all release
#subscription-manager release --list
#subscription-manager release --set=7.9 

5. If the current OS version is RHEL 7.4 and the requirement is to update to 7.9 , please use the following command to update the system to specific release. 
If you don’t specify “releasever” parameter ,then system will be updated to latest major release.
# yum --releasever=7.9 update
If you would like to update only the kernel ,
# yum --releasever=7.9 update kernel

Note: If the system is registered to RHN classic through rhn_register command, this option is disabled.
6. If “–releasever” parameter is not working as we expect , please confirm the setting of rhnplugin plug-in.
/etc/yum/pluginconf.d/rhnplugin.conf 
[main]
enabled = 0
gpgcheck = 1
# You can specify options per channel, e.g.:
#
#[rhel-i386-server-5]
#enabled = 1
#
#[some-unsigned-custom-channel]
#gpgcheck = 0
 
################################Update Only Security updates ################## 
1. System Must be registered with RHSM (subscription-manager).

2. Install security plugin if you are running with RHEL 6.x servers. For RHEl 7 , YUM itself have this functionality
# yum  install yum-plugin-security
 
3. To list all available erratas without installing those updates, run the following command.
# yum updateinfo list available
 
4. To list all available security updates without installing those ,
# yum updateinfo list security all
# yum updateinfo list sec
 
5.To get a list of the currently installed security updates,
# yum updateinfo list security installed
 
6.To list all available security updates with verbose descriptions ,
# yum info-sec
#Yum updateinfo list  available --available check
 
7. To update all the secutrity patches from RHSM / Redhat satellite.
# yum -y update --security
 
8. To install the packages that have a security errata use,
# yum update-minimal --security 
 
9. To install a security update using a CVE reference number, use the following command.
# yum update --cve CVE-2008-0947
* Replace “CVE-2008-0947” with require CVE.

10.If you want to apply only one specific advisory, use the following command.
# yum update --advisory=RHSA-2014:0159

#######################Extend the /boot partition#################
1.1. Add a new disk (size of the new disk must be equal or greater than size of the existing volume group) 
and use ‘fdisk -l’ to check for the newly added disk. /dev/sdb:
# fdisk -l
2. Partition the newly added disk and change the type to Linux LVM:
# fdisk /dev/sdb
3.Create a physical volume on the partitioned disk eg. /dev/sdb1
# pvcreate /dev/sdb1
Physical volume "/dev/sdb1" successfully created
4. Check for the volume group name. Add the physical volume to the existing volume group.
# vgs
5. Migrate the physical volume from existing disk (/dev/sda2) to newly created (/dev/sdb1). Then reduce the existing volume group.
# pvmove /dev/sda2 /dev/sdb1
6. Delete the partition /dev/sda2.
# fdisk /dev/sda
Command (m for help): d
Partition number (1,2, default 2): 2
Partition 2 is deleted
Command (m for help): p
Command (m for help): w
The partition table has been altered!
7. Unmount /boot:
# umount /boot
8. Check the start and end blocks of /dev/sda1. 
Then delete the partition /dev/sda1 and create a new partition /dev/sda1 with same start block and extend the size as much required.
# fdisk /dev/sda
Command (m for help): p
Command (m for help): d
Selected partition 1
Partition 1 is deleted
Command (m for help): n
Partition type:
p primary (0 primary, 0 extended, 4 free)
e extended
Select (default p): p
Partition number (1-4, default 1): 1
Command (m for help): p
Command (m for help): w
The partition table has been altered!
9. Check the file system of /dev/sda1:
# xfs_repair /dev/sda1
10. Resize the file system:
# xfs_growfs -d /dev/sda1
xfs_growfs: /dev/sda1 is not a mounted XFS filesystem
11. Mount /boot.
# mount /boot
12. After all these steps, size of the /boot filesystem will be extended. You can check this using 'df -h' command.
# df -h
Filesystem Size Used Avail Use% Mounted on
/dev/mapper/ol-root 28G 1.6G 27G 6% /
devtmpfs 863M 0 863M 0% /dev
tmpfs 873M 0 873M 0% /dev/shm
tmpfs 873M 8.5M 865M 1% /run
tmpfs 873M 0 873M 0% /sys/fs/cgroup
tmpfs 175M 0 175M 0% /run/user/0
/dev/sda1 497M 147M 351M 30% /boot

####################################upgrade from version  6.10 to 7.6################################
https://access.redhat.com/documentation/en-us/red_hat_gluster_storage/3.4/html/installation_guide/upgrade_to_rhgs34
https://www.tecmint.com/upgrade-from-rhel-6-to-rhel-8/
#cat /etc/os-release
1.Install migration tool
Install the tool to perform the migration from RHEL 6 to RHEL 7:
#yum -y install preupgrade-assistant preupgrade-assistant-ui preupgrade-assistant-el6toel7 redhat-upgrade-tool
# yum install yum-utils
#preupg

2.Download latest RHEL 7.6 ISO
To download the RHEL 7 installation files using a Red Hat Subscription or a Red Hat Evaluation Subscription, perform the following steps:
Visit the Red Hat Customer Service Portal at https://access.redhat.com/login and enter your user name and password to log in.
Click Downloads to visit the Software & Download Center.
In the Red Hat Enterprise Linux area, click Download Software to download the latest version of the software.
3.subscription-manager repo enable
#subscription-manager repo --enable rehel-6-server-extras-rpms --enable rehel-6-server-optional-rpms
4.Disable all repositories
Disable all the enabled repositories:
# yum-config-manager --disable \*
5.Upgrade to RHEL 7 using ISO
Upgrade to RHEL 7 using the Red Hat upgrade tool and reboot after the upgrade process is completed:
# redhat-upgrade-tool --iso RHEL7_ISO_filepath --cleanup-post
#redhat-upgrade-tool --iso rhel-server-7.6-x86_64-dvd.iso --cleanup-post
noted: to go iso image path do upgrade or mention that specific path of iso image
# reboot
6.After reboot check os version
#cat /etc/os-release
#yum repolist 

###################Password Recovery######################
##Recover the root password as "postroll" on a given virtual server.

##At the start prompt of linux select kernel and press e 
----> go to linux 16 line, press end key there it will reach at UTF-8 please type there.

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

############Configure IP Address. Configure Static IP address with
IP Address:172.25.X.11
Subnet mask:255.255.255.0
Gateway:172.25.X.254
DNS:172.25.254.254
DNS search path example.com ###############

ANSWER:

#nmcli connection modify "System eth0" ipv4.addresses "172.25.0.11/24 172.25.0.254"
#nmcli connection modify "System eth0" ipv4.dns 172.25.254.254
#nmcli connection modify "System eth0" ipv4.method manual 
#nmcliconnection modify "System eth0" connection.autoconnect yes
#nmcli connection modify "System eth0" ipv4.dns-search "example.com"

###################Setup an HostName and your hostname as "serverx.example.com"################
#hostnamectl set-hostname servero.example.com
#bash or exec bash ##forcelly update the kernel
#####################Configure Selinux. Set the selinux policy in Enfrocing mode####################
$ vim /etc/syaconfig/selinux 
SELINUX=Enforcing
:wq
#sestatus
#setenforce 1


#######################################LVM_Restore####################################
##scan the new hard disk
 $ ls /sys/class/scsi_host/ | while read host ; do echo "- - -"  > /sys/class/scsi_host/$host/scan ; done
 $ lsblk
 NAME          MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda             8:0    0   20G  0 disk
├─sda1          8:1    0    1G  0 part /boot
└─sda2          8:2    0   19G  0 part
  ├─rhel-root 253:0    0   17G  0 lvm  /
  └─rhel-swap 253:1    0    2G  0 lvm  [SWAP]
sdb             8:16   0    5G  0 disk
sr0            11:0    1 1024M  0 rom
##create lvm file system
 $ vgcreate rhel /dev/sdb1
$ vgcreate vg1 /dev/sdb1
##assgin full vg to logical voulme 
$lvcreate -l +100%FREE -n lv1 vg1
##assgin certain size from volume to logical voulme
$ lvcrate -L 1G -n lv1 vg1
##format file system
$mkfs.ext4 /dev/vg1/lv1
## mount lvm
$ mount /dev/vg1/lv1 /restore
##add some content in /restore
$ cd /restore
$ touch file
$ mkdir dhana
##unmount the file sys
$ umount /dev/vg1/lv1 
##go to archive location of lvms
$ cd /ect/lvm/archive
$  ll
$ vgcfgrestore --list
##restore the remove lvm
$ vgcfgrestore -f /etc/lvm/archive/vg1_0002-18736372631234.vg lv1
##scan lv
$ lvscan
here lv in incative 
##active lv 
$ lvchanage -ay /dev/vg1/lv1
$ lvscan
##check logical volume
$lvs
here display lvs of deleted 
##mount file system
$ mount /dev/vg1/lv1 /restore
###check the previous data
$ cd /restore
$ ll
here display previous data
---------------------------------------------------------------
#####################################recover grub file or corrupt grub file#########################
##first remove grub file
$ rm -rf /boot/grub2/grub.cfg
$ init 6
after reboot grub file corrupt
It prompt for grub>
grub>
#mount the iso os image 
grub>exit
#select troubleshooting
#select recuse mode
#it prompt 4 option
#select 1 for continue
#here dispaly after selecting 1 as chroot /mnt/sysimage
#now you chanage shell by below command
$ chroot /mnt/sysimage
it dispaly bash shell
bash-4.2# mount -o remount rw /
bash-4.2# mount /dev/sr0 /mnt
bash-4.2# cd /mnt
bash-4.2#grub2-install /dev/sda #/dev/sda is /boot partition or other file system means we have mention that file system /boot present
bash-4.2# grub2-mkconfig -o /boot/grub2/grub.cfg
here display generating grub configuration file
bash-4.2#exit
sh-4.2#exit
After above step it sucessful load
######################################### vmlinuz error or kernel boot error########################
$ press continue #
$ select troubleshooting
$ select recuse mode
#it prompt 4 option
$ select 1 for continue
#here dispaly after selecting 1 as chroot /mnt/sysimage
#now you chanage shell by below command
$ chroot /mnt/sysimage
it dispaly bash shell
bash-4.2# mount -o remount rw /
bash-4.2# mount /dev/sr0 /mnt
bash-4.2# cd /mnt
bash-4.2#cd Packages
bash-4.2# rpm -ivh kernel-* --force
here display generating grub configuration file
bash-4.2#exit
sh-4.2#exit
After above step it sucessful load
-----------------------------------------------------------------------------------------------------------------------------
######################Kernel Panic Error Resolution of  initramfs image is missing or corrupted in RHEL 7/8##################
-----------------------------------------------------------------------------------------------------------------------------
1. See the details of Kernel Panic Error (Identify the reason behind it eg. New Kernel, Corrupted initramfs, New Packages after Patching, Hardware change etc.)

2. Login the system with root credentials through rescue mode.

3. Take necesarry action as the reason of getting this error.
If it is due to new kernel, then downgrade it.
If it is due to corrupted or missing initramfs, regenerate it.

4. In our case it is due to corrupted/absent initramfs file. First check your kernel version.
# uname -r
5.After get kernel panic reboot the server
select recuse mode
it will boot recuse mode and we able access the server

6. Now regenerate initramfs with dracut or mkinitrd command: (here your kernel version should be same as in previous command result)
To create new initramfs use:
bash-4.2# dracut initramfs-3.10.0-1062.el7.x86_64.img 3.10.0-1062.el7.x86_64
OR
bash-4.2# mkinitrd initramfs-3.10.0-1062.el7.x86_64.img 3.10.0-1062.el7.x86_64
OR 
bash-4.2# mkinitrd initramfs-$(uname -r).img $(uname -r)
To replace exsiting initramfs file use:
bash-4.2# dracut -f initramfs-3.10.0-1062.el7.x86_64.img 3.10.0-1062.el7.x86_64
OR
bash-4.2# mkinitrd --force initramfs-3.10.0-1062.el7.x86_64.img 3.10.0-1062.el7.x86_64
OR
bash-4.2# mkinitrd initramfs-$(uname -r).img $(uname -r) --force
bash-4.2#exit
after that umount iso image 
sh-4.2#exit

After reboot sucessful server up
####################‘chattr’ Commands to Make Important Files IMMUTABLE (Unchangeable) in Linux##########
Attributes and Flags
Following are the list of common attributes and associated flags can be set/unset using the chattr command.

If a file is accessed with ‘A‘ attribute set, its atime record is not updated.
If a file is modified with ‘S‘ attribute set, the changes are updates synchronously on the disk.
A file is set with ‘a‘ attribute, can only be open in append mode for writing.
A file is set with ‘i‘ attribute, cannot be modified (immutable). Means no renaming, no symbolic link creation, no execution, no writable, only superuser can unset the attribute.
A file with the ‘j‘ attribute is set, all of its information updated to the ext3 journal before being updated to the file itself.
A file is set with ‘t‘ attribute, no tail-merging.
A file with the attribute ‘d‘, will no more candidate for backup when the dump process is run.
When a file has ‘u‘ attribute is deleted, its data are saved. This enables the user to ask for its undeletion.

##############################SUSE Enterprise Linux  patching##################################

#zypper lu ---list out all patched 
#zypper 1p ---category security -----list out all patched
#ZYpper lu -- list out all updates
#zypper update it will update all
#zypper patch ---it will patch all
#zypper patch --category security
#zypper 1p-a-cve-CVE2020-14621 ---see security cve

Open a root shell.
>Run "zypper ref -a" to refresh all services and repositories. 
> Run "zypper update" to install package management updates.
>Reboot the server
http://192.168.166.240/sles15/packi
01246165722
CRN no 328538997
accno. 2913388890
sudo SUSEConnect -r REGISTRATION_CODE -e EMAIL _ADDRESS

#############interveiw question############
*Linux* ✓ *(RHEL)*
############
* What is Linux ?
* What are Linux OS Flavors ?
* Difference between Debian & RPM based OS ?
* What is Kernel ?
* Explain the boot process of Linux OS ?
* How is RHEL different from CentOS ?
* What is the Latest version of RHEL ?
* What is Grub ?
* Difference between Grub & Grub2 ?
* What is boot loader ?
* Do you think the boot process in RHEL 7 is faster than RHEL 6 ? If yes, How ?
* What is .rpm & .deb ?
* What is RPM ?
* What is YUM ?
* Different methods to install the rpm based packages ?
* What is Bash ?
* What is SHell ?
* How many types of SHells are there ? * Explain the daily used basic commands like cp, mv, rm ?
* What is the significance of touch command ?
* In how many ways you can create a file ?
* How to delete the content from a file ?
* Explain the process/work behind hitting the google.com ? how you access google.com ?
* How many types of permissions are there ? What is chmod ?
* What is sticky bit ?
* What is ACLs ?
* What is SetGID, SetUID & Stickybit ?
* Location where all the user information are stored ?
* File where user password are stored ?
* What is the default permission of a file ?
* What is the significance of -rvf ?
* What is PV, VG & LV ?
* What are the types of file system ?
* What is XFS ?
* Can we reduce XFS file system ?
* How can we extend LV ?
* Command to check running process ?
* Command to check RAM usage ?
* Command to check Disk usage ?
* Difference between ps -aux & top command ?
* What are the ways to check CPU usage ?
* How to check CPU details ?
* Explain the steps to create a partition & how to format with file system ?
* Explain the steps to create LV ?
* Explain steps to reduce XFS & EXT files systems ?
* Significance of .bashrc file ?
* How you check the kernel version ?
* How you check the Redhat release version ?
* Significance of resolv.conf file ?
* What is DNS ? How you resolve DNS ? Types of DNS records ?
* Difference between Nginx & HTTP Server ?
* Port no of HTTP, FTP, SSH, HTTPS ?
* What is SSH ? How you generate SSH-keys ?
* What is Private & public key ? How they authenticate ?
* Configuration file of SSH ?
* Configuration file of HTTP ?
* What is Virtual Hosting ? How you configure virtual hosting ?
* Explain ifconfig command ?
* Difference between IPv4 & IPv6 ?
* What is MAC address ? can we change the physical address ?
* How to check system uptime ?
* How to check memory information ?
* What is SWAP ?
* What is the exact memory free in your system ?
* What is cache memory ?
Why cache memory is used in Linux?
Linux always tries to use RAM to speed up disk operations by using available memory for buffers (file system metadata) and cache (pages with actual contents of files or block devices). 
This helps the system to run faster because disk information is already in memory which saves I/O operations.
* What if you can do rm -rvf / ?
* Kinds of permission in Linux ?
* What is vim & vi ?
* What is pipe | ?
* What is grep command ?
* What Find command does ?
* How to redirect commands output ?
* What is systemd in Linux ?
* What does systemctl do ?
* If you run a command like nautilus in terminal, whether it will block your terminal or not ?
* If yes, whats the solution of this to not to unblock the terminal without closing the command application?
* What is rsyslog ?
* What is SSH-tunnel ?
* How to set history size ?
* How to extend VG ?
* What are logical & extended partitions ?
* Explain the steps to reset root password at boot time ?
* What are run-levels ? How many types of run levels are there ?
* How we change the run level ?
* How to check the logs ?
* Difference between Journalctl & tail command ?
* What does the subscription-manager do ?
* How to archive a file ?
* What is umask ?
* How to kill a process ?
* How to assign IP address manually ?
* How to assign static IP address to a system ?
* Explain the different types of Linux process states ?
* What is a Zombie process ?
* What is KVM ?
* What is hypervisor ?
* Difference between MBR & GPT ?
* How you can mount a file system permanently ?
* What is cron ? How to setup a cron job ?
* What is Kickstart ?
* How to create a network bridge in Linux ?
* Difference between iptables & firewalld
* What is SElinux ?
* What is ISCSI & targetcli ?
* Difference between NFS & SAMBA ?
* What is nfsnobody ?
* What is SSHFS ?
* What is Kerberos ?
* How to secure NFS with Kerberos ?
