######################To display inodes information of the all files system###############
$ df -i

#########size of All the file only ##########
$ du -ah <filename> 
$ du -h
$ du -sh 
$ du -csh
NOTE:
-a, -- All the files
-c, --total 			produce a grand total
-s, --summarize 		display only a total for each argument
-h, --human-readable 	print sizes in human readable format	
-i  --inode 			Ir		
	  
####To check the mount point or disk size###
$ df -h
##########To find the release linux version########
$ cat /etc/redhat-release
#####TO find the os release linux version########
$ cat /etc/os-release
$ cat /etc/system-release
###To display the hard disk #########
$ lsblk 
note:
#script
I remove the hard disk from system if and again excute the "lsblk" command still it display 
$ echo 1 > /sys/block/<system disk name>/device/delete  
Ex:
$ echo 1 > /sys/block/sdc/device/delete

########creating the directory#########
To create directory
$ mkdir <directoryname>
Ex:
$ mkdir dir1d
to create the multiple directory
$ mkdir dir2 dir2 dir3 dir4
$ mkdir sales{1..10} -->no of directory create
           or
$ mkdir {Dir1,Dir2,Dir3}
$ mkdir {jan,feb,mar}_{doc,reports}
create the nested directories
$ mkdir -pv /data/salesdata/reports --->
$ mkdir -pv depts/{web dev hr} 
#####To create multiple directories inside a directory######
$ mkdir -pv CNTECH/{linux/{rhel7,rhel8},window/{ram,thulasi},dhanapal/{dhana,pal}}

$ tree CNTECH
NOTE:
-p, --parents	no error if existing, make parent directories as needed
-v, --verbose	print a message for each created directory

$ ls -1 <file or directory>   -->It is show the vertical line
nl --->print the line number before the data
Ex:
$ ls -1 | nl <file or directory> 
#######To display the file and directory with "," sapareted########
$ ls -m  <file or directory> 
##########TO list the file and directory long listing#########
$ls -l
or
$ll
$ls -l= $ ll    -->both command gives the same output
##list the file and directories  in human-readable
$ ls -lh <pathname>
    or
$ ll -h

##list the file and directories it the  time staly format
$ ls -lh  --time-style long-iso <pathname>  --> the command showing the  date fully showing

##list the details information last modifed time (latast file display the first ---means most resend the bottom)
$ls -lth <pathname>

##old files  should be top the most resend files bottom
$ ll -ltrh <pathname>

##list the detial information with descending order(big size file is frist come and small size last)
$ls -lhS  <pathname>
or 
$ll -hS

##To display the inode number file and directories
$ls  -il <pathname>
##To list the all files and directories including hiden files
$ls -al
or 
$ll -al 

$ll -Al

########To  create the hiden file or directories
$ mkdir .thulasi or $ touch .thulasi

########only hiden file or directories
$ l.

########to viwe property directories or file
$ ls -l <file name>	

########to list the only directories########
$ ls -lh <pathname> |grep "^d" 
to list the only files
$ ls -lh  <pathname> |grep "^-"
to list the particular excution  of file

$ ls -lR /backup/

(Single dot) 
$cp /thulasi/*.mm .

$mv ./*.mm  /thulasi/
(double dot)  - one level up

########private ip address range#########
================================================================================================================
 class          Range                   Network identification    Host identification      Default subnet mask
                                               (NID)                      (HID)
classA 10.0.0.0   -10.255.255.255  ---->         1                          3                   255.0.0.0
classB 172.16.0.0 -172.31.255.255  ---->         2                          2                   255.255.0.0
classc 192.168.0.0-192.168.255.255 ---->         3                          1                   255.255.255.0
---> To version of address sechem  
-->IPV4-32 bit address 
-->IPV6-128 bit address  

#To assgin the ipaddress ,It two typesf
-->1.Ip address can be -Static ipaddress(munually address ) 
-->2.Ip address can be -dynamic address
(dhcp server)=Dynamic Host Configuration Protocol 
-->Static ipaddress :Address  are munually assgin by the admin these address  are fixed and don't change over time.
'->Dynamic address:Dynamic ip address are autometically assgin to be client who is request for an ip address  by "bhcp server" .these ip address   changes after the system reboot(shut down).
-->sub netmask is used  device the  ip address   into network postion and host positionc
-->Private is ip assgined for internal communication and pubilic is ip assgined external communication(internet).
-->what is ip address?
Ans:ip-internet protocol , which assgin to very computer to identify each one communicate in the network.
-->What is subnet mask?
Ans:subnet mask is used dived the ip address into network position and host position
                 or
Ans:subnet mask allowed the user to identify which part of an ip address is reserved for the network and which part reserved for hostid and network id.
--> what is loopback address? 
127.0.0.1 is the loopback address 
127.0.0.2 to 127.255.255.255 it also loop back addresses and is used for internal testing on local machines.
Ex: ping 127.0.0.1 --> To verify that tcp/ip (Transmission Control Protocol)/(Internet Protocol) properly install or not
Ex: ping 127.0.0.1 --> To verify that tcp/ip (Transmission Control Protocol)/(Internet Protocol) properly install or not
-->What is gateway?
Ans:A gateway is the network point that provides entrance into  another network.
--> Ping:(Packet Internet or Inter-Network Groper) 
*To check the connectivity.
Networking configuration methods
================================
Tools to configuration Interface(NIC)
1.nmtui
2.nmcli
3.nm-connection-editor and GNOME settings
4.Network files 
-->GNOME settings:
-->The network screen of the GNOME desktop  settings appliction  allows basic network management to be peformed.
To assgin Static ipaddress(munually address ) :
GNOME(GNU network object model Environment)[graphical mode]
click application select system tools next click settings click settings and click network.
-->To check available network interfaces(NICs)
$ifconfig
-->2.nmcli:Network manager  command line interfaces
->This is a command-line tool is useful where graphical ennvironment is not available and can also be used to create and edit connection from the command line.nmcli command can also be used to display network device status,create,edit,activate/diactivate,and delete network connections.
*If ifconfig not available we have install the munually package name (net-tools)
$ifconfig -a
$ethtool ens33 (To check network cable connected or not connected)
--> To show the status of all network interfaces (or)To list all the available physical network device status
$nmcli device status 
  or
$nmcli dev status 
  or 
$nmcli d s 
or
$nmcli device 
As we can see in the first column use a list of network device ,we have 1 network.
$nmcli device status 
ex: [root@ip-172-31-9-171 ~]# nmcli device status
DEVICE  TYPE      STATE      CONNECTION
eth0    ethernet  connected  System eth0
lo      loopback  unmanaged  --

-->Naming depends on the type of network card (If it is onbord,pci card ,etc).
-->In the last column we see our configuration files which used by our devices in order to connect  to the network.
$nmcli connection show --> list the active connections only.
ex:[root@ip-172-31-9-171 ~]# nmcli connection show
NAME         UUID                                  TYPE      DEVICE
System eth0  5fb06bd0-0bb0-7ffb-45f1-d6edd65f3e03  ethernet  eth0
$nmcli con show 
$nmcli c s
--> To list all the available device and its details
$nmcli device show
-->To print device list with fileds IP4.ADDRESS,IP4.GATEWAY
$nmcli -f IP4.ADDRESS,IP4.GATEWAY device show eth0
ex:[root@ip-172-31-9-171 ~]# nmcli -f IP4.ADDRESS,IP4.GATEWAY device show eth0
IP4.ADDRESS[1]:                         172.31.9.171/20
IP4.GATEWAY:                            172.31.0.1
-->To delete the connection in server
$nmcli connection delete  eth0 
-->Add a new connection 
$nmcli connection add type ethernet con-name office ifname ens33 ipv4.address 192.168.10.1/24 ipv4.gateway 192.168.10.254 ipv4 192.168.10.100 ipv4.method manual autoconnect yes
$ ls /etc/sysconfig/network-scripts/
$cat /etc/sysconfig/network-scripts/office
create a another connection 
$nmcli connection add con-name myhome type ethernet ifname ens33 ipv4.address 172.16.21.247/16 ipv4.gateway 172.16.21.1 ipv4.dns "8.8.8.8 8.8.4.4" ipv4.method manual connection.autoconnect yes
$nmcli connection show
$nmcli connection up myhome
$nmcli connection show
$nmcli connection delete <connection name>
Ex:
$nmcli connection delete myhome 
-->create new connection  and assgin the dynamic ip address
$nmcli con add con-name  myhome type ethernet ipv4.method auto autoconnect yes
$nmcli con con up home
$nmcli con show


24-12-22(4-5)
Profile where is store in linux server 
->To list our network device 
$nmcli device show 
->In the last column we see our configuration  file which is used by our device in order to connect to the network.
->We call these files also as "connection  profile".We find them in 
$cd /etc/sysconfig/network-script   directory
$ ip a  or $ ip address  show 
$ls /etc/sysconfig/network-script 
$cd /etc/sysconfig/network-script 
$ll
$cat eth0
1.ONBOOT = yes 
->If it is value "yes" it means,that on boot our computer will read this profile and try to assgin it to its device 
TYPE
====
 We have erthernet type here,we could have wifi,team,bond and other.
DEVICE
======
->The name of the network device which is accociated with this profile
BOOTPROTO
=========
->If it has value "dhcp" then our connection profile takes dynamic ip from  dhcp server,if it has value "none" then it takes no dyanimc IP and probably When assgin a static IP.
PREFIX
======
->The subnet mask (24/255.255.255.0)
->GATEWAY,the gateway ip.
DNS1,DNS2:- Two dns server ,we want to use 
1.To verify the dns IP ?
$cd /etc/resov.conf
2.To verify the default gateway ?
$route -n
   or
$netstat -nr


To activate and deactivate the network interfacess
$ifdown <connection name>Ex:$ifdown office
$ifup <connection name>Ex:$ifup office
       or
$nmcli connection up <connction name>Ex:$nmcli c$onnection up office
$nmcli connection down <connction name>Ex:$nmcli connection down office	   

$nmcli connection show office |grep -i gateway 
$ nmcli device show  |grep -i gateway
$route -n
note:In case modification we need to connection configuration we can do this by edit the configuration ifcfg-office
--> so we need to reload the configuration $nmcli  connection reload ifconfig-office  
$nmcli connection reload
-->network manager has be in informed about this 
$nmcli connection up office
-->One lan card down&&onther lan card
$ nmcli connection down office && nmcli connection up myhome
-->To set the gateway 
$nmcli  connection modify office ipv4.gateway 192.168.10.254
$route -n
$nmcli connction reload 
$nmcli connection up office
$cat /etc/resolv.conf
To add the addition ip
$nmcli connection modify office +ipv4.dns 8.8.4.4
$nmcli connection reload
To set the muiltiple dns server ipaddress 
$nmcli connction modify  office ipv4.dns "8.8.8.8 8.8.4.4 1.1.1.1"
$nmcli  connection modify  office  ipv4.address 192.168.10.100/24 ipv4.gateway 192.168.10.251 ipv4.dns "8.8.8.8 8.8.4.4" ipv.method manual connection.autoconnect yes
$nmcli connection reload office
method of beagin muliple networkcost per prefromence and load balanceing and redundancy reasons
NTC teaming or bonding  or bridging 
To allow faillover and higher throughput.
grom rehel 7 teaming or link aggregation
 
-->There are some  runner (modes) for configuring network teaming like.
1.roundrobin: pokect are sequentially transmitted/receive though each interface
roundrobin  -fault tolerance -no --> if any NIC goes down your complete team will down.
            -load balancing -yes--> both NIC active.
2.Active backup:  one NIC active while onther NIC is sleep(stand by).If the active NIC goes down ,Another NIC becomes active .
                -fault tolerance - yes 			 
                -load balancing - no -> At any time only one NIC is active 
3.Load balancer :Both NIC are active few package goes to via one NIC, few package goes ot onther via.
                :If one NIC goes down stiall we have another NIC provied the connectivity. 				
				-fault tolerance - yes 			 
                -load balancing - yes
4.broad cast :transmitte the data all NIC(same data will transforted throuh two NIC  )

fallodnce:if one of the under lyning physical NIC is failed, the server dedective folt condinstion then autometically moves  traffic  another  NIC in team.
-->adding the master team connction
$nmcli connection add type  team con-name  team0 ifname team0 config '{"runner":{"name":"activebacup"}}'
we have created active backup team interface that is called team0. 
Ex:
 [root@thulasi ~]# nmcli connection add type  team con-name  team0 ifname team0 config '{"runner":{"name":"activebacup"}}'
Connection 'team0' (9fa0cdf7-c5fa-4042-ba43-ccdceff0c1e2) successfully added.
-->check the newly created master team connections 
 $nmcli connection show
-->adding fisrt slave team connection into master device 
$nmcli connection add type team-selves con-name team0-selave ifname ens33 master team0  (connectioname=ens33)
-->adding second selves team connection into master device
$nmcli connection add type team-selves con-name team0-selave2 ifname ens37 master team0 (connectioname=ens37)
Now assgin the ipaddress on the master team0
$nmcli connection modify team0 ipv4.ipaddress 192.168.10.100/24 ipv4.gateway 192.168.10.1 ipv4.dns "8.8.8.8 8.8.4.4" ipv4.method manual connection.autoconnect yes
$nmcli connection reload  
$nmcli connection up team0
-->check the status of teaming configuration. 
$teamdctl team0 state
$ cd /etc/sysconfig/network-scripts 
$ll or $ ls 
-->Testing network teaming.
$teamdctl team0 state 

$nmcli device disconnect ens33
$nmcli device connect ens33
	
 
########## IP  Address ######
==>Subnetting <==  
---> To dived a larger network into smaller subnetwork
---> To do this we have to convert the hostbits(0's) into networkbits (1's)  
---> subnetting can be done in waves 
 1.Based on the requirement of the subnets  
 2.Based on the requirement of the host
 
 
 only create empty profile 
 $nmcli connection add con-name eth0 type ethernet ifname eth0
 
* ########### To check the users secondary group  information#######
$cat /etc/group
---> etc/passwd files fields
 1.username
 2.x-refers the password information from shadow file 
 3.user id 
 4.primary group id
 5.comment
 6.home directory 
 7.user shell
 
  To assgin the password for  user 
$passwd "username"
To check user password information or age information
$cat /etc/shadow
---> etc/shadow file fields
1.username
2.users encrypeted password
3.password last modified date
4.minimum days required to password change
5.maxmum days required to password change
6.warning days before the password expiry
7.inactive days login  after the password expiry
8.user account expiry date
9.future use
password atributes of users 
$ passwd -S <username>
To lock the password of user
$passwd -l <username>
To unlock the password for user name
$ passwd -u <username>
To remove the password the user 
$passwd -d <username>
How to  assgin the temporary password
$passwd -f
To 
chage -m 10 -m 20 8   <username>
==>$ more /etc/login .defs
the user add command default values  or located in following files
$ cat /etc/default/useradd
The  user account  password details information
$chage -l <username>
To change the expiry date
$chage -E 03/12/2022 -I 9 <username>

######EGrep############# 
(EGrep)-Extended global regular expression print
To search a multiple strings in a  given files
$egrep -n 'thulasi|dhan|ayyapa' /etc/passwd
you can search the partten from multiple files and multiple strings   
$ egrep 'thulasi|dhan|ayyapa' /etc/passwd /etc/group
                                                              
#####  fgerp: fix strings grep 
$fgrep -n  'thulasi 
>dhan
>ayyapa' /etc/passwd

commented and uncommented lines
$grep ^[#] <file-name> ---> only display the commented
$grep ^[^#] <file-name> ---> only display the uncommented  
TO count the number of lines in a files
$grep -n ^ <file-name>
$grep -c ".*" /etc/passwd
NOTE :
 -c, --count               print only a count of matching lines per FILE
 -n, --line-number         print line number with output lines
 
 
########## instalization file#####################
normal user $
$pwd
/home/ec2-user
$ls -al
$vim .bash_profile
--->Once you login in the system very frist file ".bash_profile" will be executed and here in these file (.bash_profile) you see ,this .bash_profile you look for .
--->When ever root user login  system .bash_profile.
--->First executed .bash_profile and in that file it will look for .bashrc,so first  excuted .bashrc and then it will excuted the rest part of .bash_profile

################copy files and directories##########
-->To copy the content of one file to another file
$ cp  -v <source path> <destination path>
-->Copy the multiple files at the same time into same directory

########## To create a backup copy of file before we edit it to due this we have to uses option -i  ###########
$ sed -i.bak 's/root/danger/g' <file-name>  
Ex:
sed -i.bak 's/root/danger/g' root1
Note:
 This will create a backup copy of the file with extension'.bak'. You can also use other extension if you like.
Ex:
[root@ip-10-10-1-214 1]# sed -i.backup 's/danger/root/g' root1
[root@ip-10-10-1-214 1]# ll
total 12
-rw-r--r-- 1 root root 1451 Dec  6 04:03 root1
-rw-r--r-- 1 root root 1451 Dec  6 03:58 root1.backup
-rw-r--r-- 1 root root 1459 Dec  6 03:50 root1.bak
-->Add a line after/before the matched pattern
Ex:
[root@ip-10-10-1-214 1]# sed '/adm/a "welcome linux"' root1.backup
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
"welcome linux"
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin

$ sed '/^$/d' <file-name>
$ cat -n /etc/passwd | sed -n '12,15p'
 Ex:
 [root@ip-10-10-1-214 1]# cat -n /etc/passwd | sed -n '12,15p'
    12  ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
    13  nobody:x:99:99:Nobody:/:/sbin/nologin
    14  systemd-network:x:192:192:systemd Network Management:/:/sbin/nologin
    15  dbus:x:81:81:System message bus:/:/sbin/nologin
	
#############permits the excustion of multiple commands in sequence################################
--->Also perimts excustion based on the success and failure of prvious command.
->no of symbol  for multiple excustion  
1. ;
2. &&
3. ||

#####    ;    ########
 1. ;
$ls -l ; df -Tht /var ; du -sh /root
$ls-l ; df -Tht /var ; du -sh /root
 In the above command these  runs first command,then second commands with out regards of the first excuted
 
###### &&  #############(and)
 $ls -l && df -Tht /var && du -sh /root && grep  thulasi /etc/passwd
 $ls-l && df -Tht /var && du -sh /root && grep  thulasi /etc/passwd
-->if frist command successfuly run then second command runs.
--> if frist command not excute then second command not run.

############ || ################ (OR)
$ls -l || df -Tht /var || du -sh /root
 -->This runs second commands ,if frist commands  fails.
 
#####words count ##############
 --> We can use "wc" command to count number of lines,words, characters present in the given files 
 $ wc <file-name>
Ex :
 4    19  101
 |     |    | 
lines word characters(letter)
---> In computer 1characters(letter)=1byte   
Ex--> Thulasi is 7 byte
$wc -l <file-name>  --> to print the number of lines.
$wc -w <file-name>  --> To print only no of words.   
$wc -c <file-name>  --> To print only no of characters(letter).
$wc -lw <file-name> --> To print lines and  words .
$wc -L  <file-name> --> To print the number characters in longest line.
$wc -l <file-name> <file-name> -->we can use wc command for multiple files

###########rmdir##############
*$rmdir(only remove the directories)
-->rmdir command is used to remove the empty directory.that is directory without any sub-directory or files.
$rmdir 
--->To delete nested empty  directory 
$rmdir -pv 1/2/3 --> 1,2,3 this is empty directory
*if any ofthe directory not empty than we get error message
$rmdir -v 1/2/3 1/2 1
$rmdir .data
-->"rm" command is used removeing the files and directories and recursively deleting all the  sub-directory 
$rm <files or directory>


########### cp : copy the files and directories  #############
To copy the content of one file on ther file
$cp file1
* It  copies entire directory tree but permissions or ont preserved,links or not copied.
$touch ~/dir1/file{1..4}.txt 
$cp -Rv dir1 /root/thulasi/
*-v : If you want to know what happen during the copying file,we can use  -v option.
$ls -ld -->To show  the file property  
*preserve time and date information when making a copy
$cp -prvf dir1 /home/thulasi
$cp -rvf /home/thulasi  /files/ram
$cp  -rvf /home/thulasi/. ~/ files/ram
##copy the directories:
when we copy directory we will use a -r option but we can also use a -a option.
$ln -s file1.txt -->softlink file            
$cp -avf ~/dir1 /home/ram  --> this will create  an exact copy of files and directories including symbolic links if any.(copy the entire directory tree including permissions and links)
$                                                                                                                    
###########compression utilities ################3
$gzip 
$which gzip
$mkdir <compression >
$seq 10000000 > file_name 
$ll
$ls -lh
$gzip file_name
ex: file_name.gz
$gzip -c file_name thulasi
$gzip -v -c  thulasi
$gzip - l file_name --> full detials
$bzip2 <file_name> ---> better than the gzip
$zip thulasi.zip  file_name
$bzip2 -c -v file_name
$xz file_name

#########dicompression####
$gunzip
$which gunzip
$gunzip or $gzip -d 
$bunzip2 
$unzip thulasi.zip 
-->To see the content .bz2 excstion of file 
$bzcat file_name.bz2 |less

###########xargs#############
xarg :the xargs command is used when we combine it with other command. 
we use |to pass the out xagrs command.
$echo "file1.txt file2.txt file3.txt" | xargs touch
this command create the file1.txt file2.txt file3.txt.
$echo "a1 b1 c1" | xargs -t touch
$cat >> file1.txt --> add some data  
$find  . - name a1 | xargs -tP rm -->single file removebmzrdKvizs#f5a
$find .-name "*.txt*" | xargs -tP rm -->multiple file remove
$echo "a b c d"| xagrs -n 2 -->we have take 2 valus for one time
$echo /home/thulasi/file_name /home/thulasi/dir1/ram.txt | xagrs -t -n 1 cp -v /root/thulasi/123.txt -->one argument per command  line and to the cp command.

#####mv :commamd  rename and move (cut and paste) ##########
mv :mv command is used to move the extisting file or directory  from one location to on ther localtion  it is also used to rename the file or directory.
-->when useing the mv command it delete the orginal file or directory.
syntax :<source><destination>
$touch images{1..9}.jpg
$mv images1.jpg images2.jpg  /home/thulasi/dir1 
$mv image1.jpg  thulasi ---> <old name><newname>
-->you must first specify the source file name and the destination directory.
$mv dir1 dir2 --> If the exist  then the dir1 directory is renamed as dir2.
-->prompt before overwriting
$mv dir2 /home/thulasi/dir2
-->not prompt before overwriting
$mv -n .file1.jpg  dir2/file.txt 
-->backup files (To backup a file in an exsiting destination files )
$mv -b .file.jpg dir2/file.txt
-->force overwriting
$mv -f .file.jpg dir2/file.txt

############################To manage the software in linux 2 utilities are  used ######################
1.RPM-Redhat package manager
2.YUM-yellow dog update,modfied

1.################RPM#########################

rpm is a  most populur open sources tool used for software management for installing,uninstalling(removeing),verifying,querying and listing and updateing the software packages.
->It works with .rpm files.
->Rpm package are create by redhat and also used by centos,Fedora,SUSE.
->rpm keep  the information of all the install packages under  /var/lib/rpm database directory.
->The rpm log message will be stored in  /var/log/yum.log  files
->the Draw back of the rpm cannot resolve the dependency,It means if you want to install the any software package first we need to install the dependency packages.
->To install the packages (first mount the dbd)
$lsblk
$mount /dev/sr0   /media
$cd /media 
$ll |wc -l 
To check the package is available or not in our packages folder (in our disk) 
TO check signature of the package:
==================================
To check pgp  signature of the package before installing on your system. 
NOT OK missing keys :

->difficulty software providers digitally sign rpm packages using GPG keys.
->redhat digitally signs all the package when it releases. 
$rpm --checksig  rpm-python-4.11.3-45.el7.x86_64.rpm
                     or
$rpm -K rpm-python-4.11.3-45.el7.x86_64.rpm
-> we have import the GPG key.
key location(path)
$ls /media 
   or 
$ ls /etc/pki/rpm-gpg/
To import the key
$rpm --/media/RPM-GPG-KEY-redhat-*
->now verfiy the signature
next go to package  folder,now we check and key is import are not .
$rpm -K <rpm packagename>
verify the pgp key,And Remove the pgp 
->first verify pgp key
$rpm -qa gpg-pubkey

$rpm -qi gpg-pubkey-fd43ld5l-4ae0493b
TO remove the key
$rpm -e --allmatches  gpg-pubkey-fd43ld5l-4ae0493b 
To check the dependency of rpm packages before install 
-To verify the dependency packages its show below command
$rpm -qpR (package) 
Ex:$rpm -qpR rpm-python-4.11.3-45.el7.x86_64.rpm
-q --qurey 
-p --package 
-R --dependency
To install the rpm packages
$rpm -ivh (packagename)
Ex:
$ rpm -ivh rpm-python-4.11.3-45.el7.x86_64.rpm
-i --install
-v --verbose for display
-h --hash   -   print hash marks as package installs
note:
->Install packages are stored in -- $cd /usr/share/doc

(python-4.11.3-45.el7.x86_64.rpm 
packeage-major version-minor version-patches-bugfixes-release-architecture)
-->$blkid the blkid command displays available attributes such as its universally unique identifier (UUID), file system type (TYPE), or volume label (LABEL).
$blkid 
/dev/sr0 :uuid
->Here our DVD block devices /dev/sr0 and its TYPE is iso9660 
$cd /media/
$mkdir Rhel7.8Dvd
$ll
$pwd
$mount /dev/sr0 /media/Rhel7.8Dvd
note:this only tempory mounting,if we restart system its unmount.

->1.I am useing UUID for permanent mount
->2.per mounting the we have to add to enter in /etc/fstab file. 
$cat /etc/fstab
$vim /etc/fstab 
$mount -a -> will mount all the enter is placed in /etc/fstab file.
To unmount the file system 
$cd
$umount /media/Rhel7.8Dvd
$cd  /media/Rhel7.8Dvd
$ll
$mount -a
##########
To check the a paticular package install or not.
$rpm -qa |grep(packagename) 
      or 
$rpm -q (packagename) 
      or
$rpm -qa (packagename)
     

To list(check)all installed packages in our system .
$rpm -qa 
     or
$rpmquery -qa
-q -qurey        
-a -all
To see  the pages viwe on packages
$rpm -qa | less
->*86_64.rpm --->64 bit package and can be install on 64 bit O/S only.
->*86.rpm --->32 bit package and can be install on 32 bit or 64 bit O/S only.
->noarch.rpm --->no-architecture and can be install on either 32 bit or 64 bit O/S.
To count  how many package already install in our system.
$rmp -qa |wc -l
To check the package consistency.
$rpm -ivh --test (packagename)
->If status showes 100% then the package is good condistion or consistency,
To list the last install packages. 
$rpm -qa --last  
To install package with out dependency 
$rpm -ivh (packagename) --nodeps 
Note:
the above command porcefully install the package by igonering dependency errors but if those dependency files are missing the progarm wont want untial you install them.
$finger -->finger command is show the user details.
To remove or uninstall packages.
$rpm -evh (packagename) --nodeps
To qurey file that belong to which rpm package.
which ifconfig ->
rpm -qf /sbin/ifconfig -> it is showing package name 
$rpm -uvh (packagename)- U --upgrade-This  upgrades  or  installs the package currently installed to a newer
                         version.  This is the same as install, except all other  version(s)  of
                          the package are removed after the new package is installed.
$rpm -Fvh (packagename)- F--freshen- This  will upgrade packages, but only ones for which an earlier version
                        is installed
To viwe all file  installed paticular rpm packages (after install)
$rpm -ql (packagename)					
To view all file  installed paticular rpm packages (before install)
$rpm -qpl (packagename)
To view the details the paticular information  
$rpm -qi (packagename)
Qurey the configuration file of installed package.(after installed)
$rpm -qc (packagename)
To list the all the document file (after installed )  
$rpm -qd (packagename)

###############install the rpm package to resolve dependencies#############################
 yum install local ./python27-python-pip-7.1.0-2.el7.noarch.rpm

############ premanent mounting  ###############
$ll /mnt
$mount -t iso 9660 -o loop rhel-server-7.8-*86_64-dvd.iso /mnt
$df -Th
To permnently mount the  .iso file 
$vim /etc/fstab
/root/rhel-server-7.8-*86_64-dvd.iso /mnt iso9660  loop 0 0
:wq!
note:
/root/rhel-server-7.8-*86_64-dvd.iso --> path of the ios file 
/mnt -->mount point 
iso9660 --> file type 
loop --> option 
0 -->Backup Operation
0 -->File System Check Order

$mount -a
#####
2. #######To configure  the local yum repository  ###############
#YUM-yellow dog update modfied
--> yum command access the repository where the package are available and can install ,update,remove,and qurey the package .
To configure  the local yum repository useing dvd iso 
=====================================================
step1:
$mkdir /media/Rhel7.8Dvd
$mount /dev/sr0  /media/Rhel7.8Dvd
click $blkid 
next copy is type of UUID(UUID="2022-32-3-292-00")
$vim /etc/fstab
1.paste UUID
2.path 
3.iso9660
4.default
5.0
6.0
:wq!
$ mounnt -a
$ df -Th 
$ ls /media/Rhel7.8Dvd
step2:
->/etc/yum.repos.d :- Is the directory which contains the yum repository configuration files.
->In  /etc/yum.repos.d  directory we have create yum repository configuration file,that file must be  .repo extension .
Ex: local.repo
-> repository should created with yum group information.
$cd /media/Rhel7.8Dvd
$cd 
$vim /etc/yum.repos.d/loacal.repo 
1.[localrepos]
2.name=red hat linux 7.9
3.baseurl=file:///media/Rhel7.8Dvd
4.enabled=1		
5.gpgcheck=1
6.gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
:wq!
$yum clean all 
##List the all enabled repositories
$yum repolist all 
##To list the all enabled/disabled repositories
$yum repolist 
To list the group of packages
$yum groups list 
  or
$yum grouplist
To list package dependencies
$yum deplist <package name>   Ex:yum deplist httpd
To install the yum pacakges 
$yum install httpd 
To verify the pacakge installed or not
$yum list installed <pacakge name>    ex:$yum list installed httpd
To installed packages in our  system 
$yum list installed 
To list the available packages to be installed
$yum list available 
To list  all installed and  not installed 
$yum list all 
To search a paticular package is available
$yum search <package name>   ex:yum search httpd 
To  display  the information/details about pacakge
$yum info <package name >  ex:yum info httpd
To remove the package 
$yum remove <pacakge> ex:yum remove httpd
To remove packages dependencies also
$yum autoremove <package >  ex:yum autoremove httpd
###configuration yum repository ###
$mkdir /root/Rhel7.8_package
$ll /root/Rhel7.8_package
$lsblk
$mount  dev/sr0 /media/Rhel7.8Dvd
$cd /media/Rhel7.8Dvd
$ls
$cd pacakges
$cp -rvf * /root/Rhel7.8_package 
$ls /root/Rhel7.8_package
$cd /media/Rhel7.8_package
$ls
$cd repodata
we need to  (-r--r--r--  3dff................................-comps-server.x86_64.xml)--> it is menting the groups  fille .
To create "createrepo"  
$createrepo -vg  /media/Rhel7.8Dvd/repodata/3dff................................-comps-server.x86_64.xml /root/Rhel7.8_package

configure the system to use repository present at /root/rhel7.8_package
$vim /etc/yum.repos.d/local.repo
1.[local.repos]
2.name=red hat linux 7.9
3.baseurl=file:///root/rhel7.8_package
4.enabled=1
5.gpgcheck=1
6.gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
:wq!

$yum clean all
$yum repolist all 
$yum groups list
$yum groups install "basic web servers"

#########################################################
Create an Apache(network-repository ) YUM repository on Red had Enterprise linux7.8
$mount /dev/sr0 /mnt
$cd /mnt
$ls
We neeed a package called "createrepo"
If installed os if you did a minimal installation we my need to install the dependencies first after the create a repo package.
$rpm -ivh libxdml2
$rpm -ivh deltarpm
$rpm -ivh python-deltarpm
$rpm -ivh createrepo
create the directory for the repository
$mkdir /Rhel7.8_package 
$ll /Rhel7.8_package 
copy the all the rpm packages  
$cp -vrf /mnt/p ackages/* /Rhel7.8_package 
$ll /Rhel7.8_package
$createrepo -vg /mnt/repodata/3dff................................-comps-server.x86_64.xml /Rhel7.8_package   
ls /Rhel7.8_package/repodata   
 create the repository file  under  /etc/yum.repos.d/
 vim /etc/yum.repos.d/server.repo 
1.[thulasi server]
2.name=red hat linux 7.9
3.baseurl=http:///Rhel7.8_package 
4.enabled=1
5.pgpcheck=1
6.gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
:wq!
$yum clean all
$yum repolist all
$yum grouplist
###To install the paticular pacakge from specific repository
(To install the httpd (Apache) package using YUM)
$yum install httpd 
$yum install --enablerepo=(repo id ) httpd   Ex:yum install --enablerepo=rhel7.8_serverrepo httpd 
#configure Apache to auto-start at boot
#Once Apache(httpd) is installed,start  and enable the "httpd" service to auto-start at boot and verify its status.
$systemctl status httpd
$systemctl start  httpd  or $service httpd start 
$systemctl enable httpd 
$systemctl status httpd  or $service httpd status
$ps -ef |grep httpd  
#To configure the firewall to allow the httpd traffic -port-80
$firewall-cmd --add-port=80/tcp --permanent Or $firewall-cmd --add-service=http --permanent
$firewall-cmd  reload 
$firewall-cmd --list-ports
$firewall-cmd --list-services
To configure Apache , open the configuration file.
$vim /etc/httpd/conf/httpd.conf
1./Document 
2.Document Root "/var/www/html"
3.#Document Root "/var/www/html"
4.Document Root "/Rhel7.8_package "
next
#add by thulasi
5.<Directory "/Rhel7.8_package ">
    AllowOverride None
    # Allow open access:
    Require all  
</Directory>
#complete by thulasi
:wq!
$httpd -t --> to testing the  httpd file configure 
$systemctl restart httpd
$systemctl status httpd 
$mv /etc/httpd/conf.d/welcome.conf /
To check your ip in chrome
(its showing error "Forbidden" 
you dont have permission to access/on this server.)
1.#To check the selinux modes. 
$vim /etc/selinux/conf 
1:SELINUX=enforcing 
    remove the enforcing.Give the enforcing place permissive
2.SELINUX=permissive
:wq!

temporary label
#1#To verify the label  temporary label:  

[root@thulasi ~]# ls -ldZ /var/www/html/
drwxr-xr-x. 2 root root system_u:object_r:httpd_sys_content_t:s0 6 Jul 22 11:51 /var/www/html/
to change the lablel
$chcon -R -t httpd_sys_content_t /Rhel7.8_package
If you use restorecon chagane reload  
restorecon -v /Rhel7.8_package 
#2#to change the label context permanent:
$semanage fcontext -a -t  httpd_sys_content_t  "/Rhel7.8_packages(/.*)?"

#Changes are stored in the policy of your selinux in the above file 
$cd /etc/selinux/targeted/contexts/files
  
################################################################### 
##To install  group of package using yum 
##
To list the available gropus 
$yum groups list 
    or
$yum grouplist
##To see the total number of groups
$yum groups summary
before we prossed  install a group ,we can give the group id 
$yum grouplist ids
To know the group information 
$yum group info (ids)   
Ex:yum group info (network-server)
To install a group of package                                    
$yum group install "RPM Development Tools"
To remove a group of package 
$yum group remove "RPM Development Tools"
To check a particular package is installed or not .
$yum list <packagename>
To install a packages locally from a folder 
$yum localinstall  <pacakgename>
To check the package information
$yum info <packagename>


##############EPEL=Extra packages for Enterprise Linux##############<18-5-22>
##Repository configuration 
->Epel additional rpm for rhel,centos,fedora etc.
->Epel created and maintained by fedora community and epel package are free (open source) open the chrome browser"centos.pkgs.org " 
after click search bar "epel" next click here"Enterprise Linux 7 " next click here "EPEL x86_64 Official" and click this link "epel-release-7-14.noarch.rpm".
Binary Package:	https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-14.noarch.rpm 
$wget https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-14.noarch.rpm 
$ll
$rpm -ivh  epel-release 
   or
$yum install https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-14.noarch.rpm 
To verify the below path
$cd /etc/yum.repos.d/   
$ll
$yum clean all
$yum repolist all 
To list the Epel packages 
$yum --disablerepo="*"  --enablerepo="epel" list available
To list all repository packages 
$yum all 
To search the pacakge
$yum  search figlet 
  or
$yum --disablerepo="*"  --enablerepo="epel" list available |grep -i figlet
Getting the package information
$yum --enablerepo=epel info figlet 

$yum --enablerepo="epel" list available  httpd
Installing package from epel repository
$yum --enablerepo=epel install htop 
    or 
$yum install htop 
###########
$yum install figlet  

##############################
##To mount the pendrive 

$lsblk
$lsblk -fp
$mount -t <filesystemname>  /dev/sdb1 /mnt
$df -h
$cd /mnt
$ll
##########
$lsblk
$lsblk -fp
$mount -t ntfs /dev/sdb1 /mnt
mount:unknow filesystem type 'ntfs'
$yum insatll 
#####To mount the pendrive exfat
$lsblk
$lsblk -fp 
$mount -t exfat /dev/sdb1 /mnt
mount:unknow filesystem type 'exfat'
to reslove this 
go to chrome browser type https://li.nux.ro/download/nux/dextop/el7/ click enter  
after search this nux-dextop  its showes and copy the http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm

$wget http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm --no-check-certificate
$yum install nux-dextop-release-0-5.el7.nux.noarch.rpm
$ll /etc/yum.repos.d/
$mount -t exfat /dev/sdb1 /mnt 
$yum install exfat-utils fuse-exfat
$mount -t exfat /dev/sdb1 /mnt 
$ll
$touch thulasi{1..3}
$mv thulasi* /mnt/

#######################################################
###create the yum repository using Red Hat subscription-manger[online]
#To know subscription-manger activate or not
$subscription-manger list
we need to go to two site
1.Customer portal
go and search this site (www.redhat.com) 
click loing-> Register now-> file your detailes->click create my account->go verify your gmail->complete
Next go to  this site (www.redhat.com) click
Go croser click developers ->login ->click i have -> submit -> go and check your gmail -> click link 
Next login->click your profile ->click subscription->click system ->
________________________________________________________________________________________________________________
$cd /etc/yum.repos.d/
$ll
$mkdir /allrepos/
$ll
$mv /allrepos/ redhat.repo 
$cat redhat.repo 
Register a system to a red hat account
$subscription-manger register                       (give redhat register your name)
         or
$subscription-manger register --username=yourusername --password=yourpassword
$cd /etc/yum.repos.d/
$ll
$cat redhat.repo
$subscription-manger list
To view the available subscriptions
$subscription-manger list --available
*copy the pool ID
$subscription-manger attach --pool=(pool id )
          or
Auto-attch a subscription	
$subscription-manger attach --auto
$subscription-manger list 
$cat redhat.repo
$yum clean all
$yum repolist all

$yum list kernel
To check for available pacakge updates	
$yum check-update kernel
To update the pacakge on our system
$yum update (packagename) 
$yum update httpd 
$yum list httpd
To unregister manager
$subscription-manger unregister

##########################################
#create local repository in Rhel8 using DVD
Note:In Rhel8 segregate the two type  repositories 
    1.BaseOS is OS related packages . 
    2.APPStream is Application related packages. 

$mount /dev/sr0 /mnt
$cd /mnt
$ll
$umount /mnt
$cd /mnt
$ll
$cd AppStream 
$ls
$cd ..
$cd BaseOS
$ls
$cd ..
$cd /etc/yum.repos.d/
$vim Rhel8local.repo
[BaseOS]
name=Rhel8 BaseOS
baseurl=file:///mnt/BaseOS
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release


[AppStream]
name=Rhel8 App Stream
baseurl=file:///mnt/Appstream
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release 
:wq!
$yum clean all or ($dnf clean all) -> only Rhel8 using
$yum repolist all

->In BaseOS and AppStream Directories contains repodata and packages Directories.
####################################################################
#create Network repository-using Nginx(httpd/80)
$cat /etc/yum.repo.d/Rhel8local.repo
$yum search nginx
$yum list nginx
$yum info nginx 
$yum install nginx 
Nginx storeing the path  
$cd /usr/share/nginx/html
ll
To start the service  nginx
$systemctl start nginx
To enable the service nginx
$systemctl enable nginx
To check a nginx status 
$systemctl status nginx
$cd /mnt
$ls
$cp -rvf BaseOS /usr/share/nginx/html 
$cp -rvf AppStream  /usr/share/nginx/html 
$cd /usr/share/nginx/html 
$ll



$yum install createrepo_c yum untils
$cd /mnt/BaseOS/repodata
$ll
$pwd
$cd /mnt/APPStream/repodata
$ll /usr/share/ngnix/html
$cd 
$createrepo_c -vg /mnt/BaseOS/repodata/de9eb..................................8dba4-comps-BaseOS.x86_64.xml /usr/share/ngnix/html/BaseOS
$createrepo_c -vg /mnt/AppStrem/repodata/aa1d.................................54b-comps-AppStream.86_64.xml /usr/share/ngnix/html/AppStream
$vim /etc/yum.repo.d/rhel8local.repo
remove the old data add new data

[BaseOS]
name=Rhel8 BaseOS
baseurl=file:///usr/share/ngnix/html/BaseOS
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release


[AppStream]
name=Rhel8 App Stream
baseurl=file:///usr/share/ngnix/html/AppStream
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release 
:wq!
$yum clean all
$yum repolist all


Open the chrome browser type linux server 
its showing these type error  (403 Forbidden)
how resolve the issue you can go in the below path
vim /etc/nginx.conf
go to 42 line check  
42 root    /usr/share/ngnix/html
47 location /{
   autoindex on;
   autoindex_exact_size off;
}
:wq!

$ nginx -s reload
systemctl reload nginx
cd /usr/share/nginx/html
ls
ls AppStream/
vim /etc/yum.repos.d/rhel8local.repo 

[BaseOS]
name=Rhel8 BaseOS
baseurl=http://172.16.21.14/BaseOS
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release


[AppStream]
name=Rhel8 App Stream
baseurl=http://172.16.21.14/AppStream
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release 
:wq!
yum clean all
yum repolist all



scp -rv /etc/yum.repo.d/rhel8local.repo thulasi@12.1.2.2:/etc/yum.repos.d/
cd /etc/yum.repo.d/rhel8local.repo 
yum clean all
yum repolist all
Ex: yum install  vsftpd 
yum history
yum history info (id) ->yum history info  
yum history undo 10 -> undo 
yum history red

#################################################
#Configuring YUM/client using NFS in RHEL 7/8
mkdir /nfs_packages
mount /dev/sr0 /mnt
df -h
ll /mnt
cp -rvf  /mnt/* /nfs_packages
ll /nfs_packages
vim /etc yum.repo.d/nfs.repo

[Rhel7.9repo]
name=Rhel7.9
baseurl=file:///nfs_packages
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release 
:wq!
yum clean all
yum repolist all
#To insatll the nfs service
yum  install nfs*

vim /etc/exports
/nfs_packages *(ro sync,root_squash)
:wq!
systemctl start nfs-server
systemctl enable nfs-server
systemctl status nfs-server
$exportfs -arv
To show the export list
To check client side:-
$showmount -e localhost 
  
mkdir /nfs_client
mount 172.16.21.11:/nfs_packages /nfs_client 
df -Th |grep /nfs_client
cd /nfs_client  
ll
vim /etc/export

permanent mounting:- 
vim /etc/fstab
source                         mount point       Filesystem type        Options     Dump  pass Num
172.16.21.11:/nfs_packages      /nfs_client          nfs                 _netdev      0      0 
:wq 

vim /etc/yum.repos.d/nfs.repo
[Rhel7.8]
name=RHEL7.8
baseurl=file:///nfs_packages
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release 
:wq!
yum clean all
yum repolist all


###############################################################################
#Copy only file attributes
$cat > file7.txt
Welcome thuasi in linux
ctrl+d
$ll
$cp --attributes-only file7.txt -vp  /root
Note:-1.This option will only copy a file name and its atributes without coping any data.
2.The copied file will have 0 bytes files size.This is because the content of file is not being copied.  
#create backup file of each copied file 
$mkdir /home/thulasi/office
$ll ~/
$touch ~/office/file{1..4}.txt
$ll ~/office/
$touch ~/Document/file{1..4}.txt
$ll ~/Document/
$cp --backup=simple -v ~/Document/*.txt ~/office
$ls ~/office
Note:-1.When the destination directory alredy have the same file name,by default cp command will overwrite the same file in the destination directory.
2.--backup=simple option ,cp command will make a backup of each exiting destination file. 
3.and its create backup file whichis is add by a tilde sign(~) at the end of the file.
#Remove the destination before the copy
$ll ~/Document/
$ll ~/office/
$cp --remove-destination ~/Document/*.txt -v ~/office
$ll ~/office
$mkdir -pv ~/Pictures_backup/data && touch ~/Pictures_backup/data/pic{1..4}.jpg 
$cp -avf ~/Pictures_backup/data/*.jpg ~/pictures
#To copy  only files and subdirectories but not the source directory ,use the -T option 
$cp rvf ~/pictures_backup/ ~/pictures 
$ll ~/pictures 
$cp -RTvf ~/pictures/_backup/ ~/pictures
copy the all file and directory  from the present working  directory 
$cp -rvf * ~/pictures 

###############################################################################################################################
#####GREP command
$tail -f /var/log/messages-->to monitor the realtime logfiles.
[GREP -Global Regular Expression Print]
-> This command is used search for string in specified file.When its find a string it print the result.
->When give string is matched its  prints the entire line.
$grep root /etc/passwd
Show the line number vail displaying the output.
$grep -n root /etc/passwd
To print the matching line with in the muiltiple file.
$grep -n thulasi /etc/passwd /etc/group
Print the line if starting string match,For this use a character(^) symbol 
$grep -n '^thulasi' /etc/passwd 
Print the line if end string match,For this use a dollar ($) means search for given string end of the line.
$grep -n 'bash$' /etc/passwd 
(--> ^ and $ are anchor tags)
Ignore the case sensitive print the line given string. 
$grep -ni thulasi /etc/passwd
To print the lines except excluding the given string.
$grep -v thulasi  /etc/passwd
Print the line exact given string whole word
$grep -w thulasi /etc/passwd
To display the 'N' line after the match string  
$grep -n  -A2 thulasi /etc/passwd
To display the 'N' line before the match string
$grep -n -B2 thulasi /etc/passwd 
To display the 'N' line after  AND before the match string
$grep -n -A2 -B2 thulasi /etc/passwd
To display the 'N' line around the match(before and after)
$grep -n -C2 thulasi /etc/passwd


########################################### DHCP ####################################################
 
DHCP Reservation : A reservation ensures that a DHCP clinet is always assgined the same IP Address  with in a scope .
$vim /etc/dhcp/dhcp.conf 
hostclinet1 {
hardware ethernet fe80::7988:22bf:7ee4:86e3%10;(mack address)
fixed-address 192.168.10.255;
}
:wq!
$systemctl restart dhcpd


dhpclient

######################################
(fully-qualified domain name (FQDN)  )
ssh thulasi
You can also confirm this by checking the ssh log at /var/log/secure file
$tail -f /etc/log/secure
Normal user excute
$ssh -key-gen -t rsa
$ls -al 
$ls  -al .ssh/
$ssh -copy-id  thulasi
$ssh 10.2.246.23
 
####Install the xRdp server to connect centos/redhat machine from windows remoteDesktop connection.
#To install the xrdp server packeage from Epel repository .
go search chrome browser  "centos.pkgs.org"
next searchbar u search "epel-release" ->centos7->click Epelx86_64-> Binary packages link copy that link-> yum install (before copyed link) 
$yum (install before link)
$ll /etc/yum.repos.d/
$yum repolist all 
$yum install --enablerepo= epel
$yum install xrdp 
$systemctl start xrdp
$systemctl status xrdp
$systemctl enable xrdp
$firewall-cmd --add-port=3389/tcp --permanent
$firewall-cmd --reload 
#connect to windows machine with RDP from linux machine (Remote Desktop protocol)
windows+R ->
$yum install freerdp
linux machine to windows machine
$xfreerdp -g 800x6000 -u Administrator 10.4.2.65
Y
password:
 
##################################################################################################
#configuring central user management with Kerberos and openLdap and NFS
->LADP=can serve as a complete identify management solution for an organization.It can be provide authentication and
authorization services for users.In fact, the services provided by the Network Information service (NIS) can be completely replaced by LDAP.
->LDAP and kerberos to gether great combination for us.Kerberos is used to manage authentication,while LDAP is used for 
holding information about the accounts .
->LDAP is not a single sign-on .Users must always munually enter username/password while with kerberos they do 
this again and again .
->kerberos port no :80
-> configuration kerberos server
$mount /dev/sr0 /mnt 
$yum install krb5-server 
configuration file 
$vim /etc/krb5.conf
:%s/example.com/cnt.local 
:%s/EXAMPLE>COM/CNT.LOCAL 
9  [libdefaults]
16 default_realm =CNT.LOCAL 
19 [realms]
20 CNT.LOCAL = {
21 kdc = server1.cnt.local 
22 admin_server = server1.cnt.local 
23 }
24
25 [domain_realm]
26 .cnt.local = CNT.LOCAL 
27 cnt.local = CNT.LOCAL
:wq!
$vim  /var/kerberos/krb5kdc/kdc.conf
[realms] 
CNT.LOCAL = {
:wq!
$vim /var/kerberos/krb5kdc/kadm5.acl
*/admin@CNT.LOCAL 
:wq!
Now create the kerberos database 
$kdb5_util create -s -r CNT.LOCAL   (r -- realm name 
                                     s -- create) 
$systemctl enable kadmin.service 
$systemctl enable krb5kdc.service 
$systemctl start kadmin
$systemctl start krb5kdc 
$systemctl status krb5kdc
$systemctl status kadmin
$netstat -nutlp | grep -i 88 
$firewall-cmd  --get-service  |grep kerberos 									
$firewall-cmd  --permanent  --add-service=kerberos
$firewall-cmd --reload 
Next#Create user principal for admin user 
$kadmin.local 
kadmin.local : addprinc root/admin
kadmin.local:   
} 
###################################################################################
###########User and group administrator#############################
-> User and groups used control the access and resource 
Types of users :-
There are three types of user accounts available in linux system. 
1.Root account (super user or root user),root user id (uid=0)and group id (gid=0) and home directory is /root  and shell is /bin/bash .
-> Is the most powerful user is automatically create during the os installation he has the full control hole system , We can do any administrator work and can access  any service.
-> This account is intened for the system administration.
2.system user /service accounts :-   
->Service accounts are the  user, these account are created when applications or software packages are installed .
->These acoounts used by the  services  form the process and excute the functions for example if we install the Apache(httpd )
it will create the user apache along with the  installation of package.
-> If we install the vsftpd  package then we will see ftp user account will be created. 
1 TO 999 --- (system user/service account)
|      |
uid   gid 
Ex: ftp,ssh,apache,e.t.c.
3.Normal user account :-
->Normal users are create by the root user .
->Only the root user account has the premistions  add or remove the normal user accounts.
->During the install one regular user is created .
->After installation of OS we can create the many regular account user has we need .
-> We can give more privileges your regular account.
1000 To 6000 ---(Normal user)
  |       |
  uid    gid
  
#####################
ID -> The id command will give you your user id,primary group id ,and a list of groups that you belong to.also get SELinux context information.
$id 
uid=0(root) gid=0(root) groups=0(root),10(wheel)
To show the user id 
$id thulasi
uid=2037(thulasi) gid=2037(thulasi) groups=2037(thulasi)
-> When the create user without specify or using any option with "useradd command " default user settings are applied to user account.
->Default user settings are applied from two files:-
1./etc/default/useradd (file)-Default values for user account creation - like shell .bash_logout, .bash_profile,  ...etc...,
Ex: 
cat /etc/default/useradd - configuration
# useradd defaults file
GROUP=100
HOME=/home
INACTIVE=-1
EXPIRE=
SHELL=/bin/bash
SKEL=/etc/skel
CREATE_MAIL_SPOOL=yes

2./etc/login.defs (file)
--> default about shadow-utils components ,password control ,UIDs ,GIDs etc.
These command adds enter in user mangement files.
 /etc/passwd  --> It contains the user information 
 /etc/shadow  --> These file stores the password encrypted users accounts and information about the password agen.only readable by root user 
 /etc/group   --> It store the group information  
 /etc/gshadow -->these file is only readable by root user 

->By default useradd command create the user account with blank password 
->A user account with blank password is consider as locked account.
->A locked account cant be used for login.
->In order to unlock the user account we have must to set password using the "passwd" command .
->And this useradd command create the home directory for that user with the same name under the /home/<username> and copies is initial configuration file (user environmental files )from default sleleton directory '/etc/skel' into the users home directory.
->The /etc/skel/ directory contains some (usually hidden) files that contain profile settings,like .bash_profile ,.bash_logout,.bashrc ,...etc.,

#To disable/hidde  the  user name list on gnome login screen  and displaying test banner:-
$cd /etc/dconf/db/gdm.d
$vim 01-custom-gdm-settings 
[org/gnome/login-screen]
disable-user-list=true
banner-message-enable=true
banner-message-text='welcome to Linux '
:wq!
update the dconf 
$dconf update 
$systemctl restart gdm	

##############################
To assgin the password to a specific user only root can assgin other users.
$passwd <username>
Ex:$passwd thulasi
Now we will verfiy default user setting form below three files.
$less /etc/passwd |grep thulasi
[1]# less /etc/passwd |grep thulasi 
thulasi:x:2037:2037::/home/thulasi:/bin/bash
Each line contain muiltiple fields (7) with each fields sapareted by coloumn (:)
1.thulasi         -->user account name 
2.x               -->password . an x in the fields indicates passwords are stored in the  "/etc/shadow" 
3.2037 			  -->UserID Number (UID)
4.2037   		  -->Primarygroup ID number(GID) , Tyically this number matches the UID Number.
5.::              -->GECOS field,tyically used for a description or comment like users full name ,Designation  
                      General electric  comprehensive operating system and renamed "GCOS".
6./home/thulasi   --> Path to the user 's 'home directory. 
7./bin/bash       -->Path to the User's 'default shell .

password 
[2]$less /etc/shadow |grep thulasi
thulasi:$6$HhSlrMSo$tdxUdUa3.un9j0MgN2uAGpcAwubjtu2NId.b/8xIbmjytLIJTg1OmvJ4Zs2/9D/A8ipOODgqDcH7XI2pRYjEx.:19314:0:99999:7:::
1.thulasi -->User account name 
2.$6$Hh   -->Password,The $ in front of the password identifies the password is an encrypeted entry.
3.19314   -->The represent date of password change,the date of most recent password change measured in the number of days since jan 19
4.0       -->Minmum password age ,the minimun no of days must wait before changing the password 
5.99999   -->Maxmum password age ,Set the number of days a password can be used .
6.7       -->password changing warning,this means that user will be warned before user express. 
7.        -->gress logins ,password inactive periode .the number of day the user can login without chaganing the password after, the account is will be disable  
8.        --> account is disabled
9.        -->not used 
groups
[3]$ less /etc/group |grep thulasi 
thulasi:x:2037:
1.thulasi -->user primary group name 
2.x       -->group password,this fields an x  group password are contained in the /etc/gshadow file 
3.2037    -->group id 
4.        -->group list 

Create the user with the description(comment) :-
$useradd -c "linux Admin" thulasi 
->chfn -change finger
$chfn thulasi 
$grep thulasi /etc/passwd 
$usermod -c "linux admin" thulasi
# $gredep thulasi /etc/passwd
To change the comment field for user thulasi
$usermod -c "db admin" thulasi  -->to modify user account information  (update or chagane) 
$grep thulasi /etc/passwd

$chfn Options
$chfn -f  <dominfullname> <username> 
Ex: $chfn -f mfteam thulasi 
Usage:
 chfn [options] [username]

Options:
 -f, --full-name <full-name>  real name
 -o, --office <office>        office number
 -p, --office-phone <phone>   office phone number
 -h, --home-phone <phone>     home phone number

 -u, --help     display this help and exit
 -v, --version  output version information and exit
 
 
#->By default by user command create  home directory  in /home directory.If we want to specify the user home directory in other location we have to option "(-b and -d )" 
-> If we use -b option the only specify the path of base directory 
->If we use -d option ,we specify both the path of base directory and the name of the users home directory 
$useradd -d /hrthuasi/thulasi1
$ll /hrthulasi
$ll -a /hrthuasi
$su - thulasi1
###create the user with out home directory :-
-> To create user without a home directory use the -M option 
$useradd -M punith  
$ll  /home 
If required create the home directory for the user in fewcher,for this create the home directory and assgin the premistions and change owner and group premistions and copy the files from /etc/skel directory to the user home directory .
$mkdir /home/punith
$ll /home/punith 
$cp -v /etc/skel/.* /home/punith/
$cp -Rv /etc/skel/.mozilla/ /home/punith/
$ll -a /home/punith/
$ll -d /home/punith/
$chown -R punith:punith /home/punith
$ll -d /home/punith/
$ll -a /home/punith/
$chmod 700 /home/punith/
[To open another gui console
$gmdflexiserver]
    or
##To create user with non-default home directory:-
To create non-default home directory
$mkdir -p /jay/private
to create non-default home directory /jay/private 
$useradd -d /jay/private jay 
$cp -v /etc/skel/.* /jay/private/
$cp -R /etc/skel/.mozilla/ /jay/private/
$ll -a /jay/private/
to set user and group owner as jay on this directory 
$chown -R jay:jay /jay/private
$ll /jay
$ll -a /jay/private/
$chmod 700 /jay/private/
$ ll  /jay
$passwd jay 
$su - jay
$pwd 
$grep jay /etc/passwd
#Creating a user with specific user ID 
$useradd -u UID <username>
ex: useradd  -u 5555 krishna 
to verfiythe user id 
$id krishna
#Creating a user with specific Group ID 
->When create a new user,the default behavior of the useradd command  is - It create a group with the same name as the username and GID as UID .
->The '-g' option allows you to create a user with a specific primary group.
->you can specify either  the group name or the GID number.The group name or GID must already exist.
To create a group 
$groupadd DB 
$grep DB /etc/group
$useradd -g <groupname> <username>
Ex: useradd -g  DB  vinod 
$grep -i vinod /etc/passwd
$id vinod

##Rename the user account and with home directory :-
syntax :$usermod -l <newname> <oldname>
$usermod -l <newusername> -d <homedirectory path> -m <old username>
$usermod -l ayyapa  -d /home/ayyapa  -m sai
$grep ayyapa /etc/passwd
->renames the sai account to ayyapa, renames the home directory  and moves the old home directory containes to the new location.
To modify the  shell of ayyapa
$usermod -s /bin/sh ayyapa  
$grep ayyapa /etc/passwd
#To lock the user account
$usermod -L <usernmae>
$usermod -L ayyapa
       or 
$passwd -l ayyapa 	   
To verfiy the ayyapa account 
$grep ayyapa /etc/shadow
->this command $usermod -L <usernmae>  adding a  ! symbol  before the encrypeted password of the etc/shadow file .
To check the status of the user account 
$passwd -S <username>
$passwd -S ayyapa
To unlock the user account 
 $usermod -U <username>
 $usermod -U ayyapa 
    or 
 $passwd -u ayyapa
 $passwd -S ayyapa 
 $grep ayyapa /etc/shadow
To disable or remove from the user account 
$passwd -d  ayyapa 
$passwd -S ayyapa 
To remove the user account from the system 
$userdel <username>
$userdel dhanapal 
$grep -i dhanapal /etc/passwd 
->this command delete the dhanapal account but leave the dhanapal home directory in the system.
To removes the both the user account and the home directory.
$userdel -r <username> 
$uderdel -r ram 
To assgin a user to primary group .
$usermod -g DB thulasi
->for user thulasi assgin the  primary group member ship for usergroup thulasi  to the  DB group.
Adding a user secondry group  
$usermod -G dhanapal,postgres thulasi 
$tail /etc/group

$usermod -aG  ram,ayyapa thulasi 
$tail /etc/group

#############################################

Create a group already existing group id 
$groupadd -o -g 2000 thulasi   
$grep thulasi  /etc/group

->modfiy the properties of the adjusting group 
$groupmod 
$group -g 2001 thulasi 
To chagane the existing group name
$group -n <new groupname>  <old group name>
ex:$group -n ram  thulasi 
To delete the group  
$groupdel thulasi 
*Adding multiple user or singel user group 
To add singel user  to the group.
$gpasswd -a <new user> <group name>
ex:$gpasswd -a thulasi  ram 
To add multiple user to the group.(old user also removed)
$gpasswd -M  <new users>      <group name> 
ex:$gpasswd -M  dhana,naveen,viond   ram
Note:overwritten group member (old member removed of the 'ram' group  and newly member added)
Remove user from the group 
gpasswd -d  <new users>  <group name>   
gpasswd -d  naveen ram 
To check a has a group administrator 
$gpasswd  -A dhana  ram 

To list member of the group 
$groupmems -l -g ram 
To add the group 
$groupmems -a jay -g  ram 
to delete the user in group 
$groupmems -d jay -g  ram 
To remove the all user  in group 
$groupmems -p -g ram 

###############Create user with custom  group (primary group)
To verfiy the user name and group id.
$id -gn thulasi 
$id -g thulasi
Change user Login shell (when create a user)
$useradd -s /bin/sh raju
$tial -1 /etc/passwd 
->By default,the user's ' login shell is set to the /bin/bash which is specifiedin the /etc/default/useradd  file. 
Creating a user with an expiry date. 
->this is useful temporary accounts.
$useradd -e 2023-02-25  thulasi
To verfiy the user account expiry  date use the "chage" command.
$chage -l thulasi 
Ex:
$chage -l thulasi
Last password change                                    : Nov 18, 2022
Password expires                                        : never
Password inactive                                       : never
Account expires                                         : never
Minimum number of days between password change          : 0
Maximum number of days between password change          : 99999
Number of days of warning before password expires       : 7

#
Add the new user to the group during create new users(secondry groups or supplymentary group):-
$groupadd admin
$groupadd developers
$groupadd hr

$useradd -g db -G admin,developers,hr ramu   {(db)-is primary group and (admin,developers,hr)-secondry group}
$id ramu 
GROUPS:-
->print the group belongs to groups 
$groups ramu 

create the user without own atributes.
$useradd -m -d /salesdept/vani  -u 1020 -g 1116  -G developers,admin,hr -s /bin/bash -c "linuxadmin"  vani
$groups vani
$grep vani /etc/passwd 


changing the default useradd value.
-> the default useradd option can be viewed and changed using the '-D' option,or by munually editing the values in the /etc/default/useradd file.
$useradd -D 

To view the current default options.
$useradd -D 
If you want to change the default login shell from /bin/bash  to /bin/sh 
$useradd -D -s /bin/sh
$useradd -D |grep -i shell 

To change the default home directory location for  all new users.
$useradd -D -b /salesdept
$useradd -D |grep -i home 

######################chown ############
chown ->this command is used change the owner and group of the file and directory .
Syntax:
$chown <owner_name> <dir/file name>
this an admin command, root user only can chage the owner ship of file and directory.
$chown thulasi   file.txt 

To change the group owner of file or directory.
$chown :thulasi file.txt 

To change a both  owner and group of file or directory. 
$chown thulasi:thulasi file.txt 

To change the at a time file or directory owner and group premistions  
$chown thulasi:db file[1-6].txt 
     or 
$chown thulasi:db file*

To create a softlink  file .
$ln -s file_name  filesl

Change owner and group of a softlink file.
$chown thulasi:dhanapal filesl
->when chown command applied softlink to change the owner as well the group but not changes applied on the softlink file but orginal file (file_name)files owner and group changed. 

Useing chown command to forcefully change the owner and group of symbolic  file use the "-h" option. 
$chown -h thulasi:db  filesl  

copy owner and group setting file to from a file to another.
$chown --reference=file.txt  filename 

change owner and group only if a file owned by a particular user /group .
$chown --from=dhnapal thulasi filename 

To change the userowner  and groupowner of the directory.
$chown -Rv thulasi:db dirname 

To create the softlink directory 
$ln -s dir lndir 

To change the owner and group and symbolic  link directory . 
$chown -R -h thulasi:db lndir


$chown -R -H thulasi:db lndir 

####################################
###########chgrp#############
To change groupowner ship of the file and directory.
$chgrp <groupname> <filename or directory>
$chgrp db  file.txt 

To recursively change groupowner ship files and subfolders or directory.
$chgrp -Rc db <directory>

copy the group setting from one folder to another folder .
$chgrp -R reference=<one directoryname> <another directoryname>
$chgrp -R reference=dir1 dir3 
$ll -d dir3/	

###########################################
##########premistions ##################
premistions on applied on user level(owner), group level,others level.
->premistions set on any file or directories by using to methods.
1.absolute method (numeric mode or octal mode) - numbers 4,2,1.
2.symbolic mode (UGO) - u -user(owner) g-(group) o-(others).
access modes - r w x = 4 2 1. 

permission                        on a file                    on a directory 
- - - - - - - - - - - - - - - - - - - - -- - - - - -- - - --  - - - -- - - -- - - - - - - - - - -
r(4)(read)                 read file contents (cat)        read directory contents (ls)

w(2) (write)              change file content (vim)        create file/directories in (touch/mkdir)

x(1) (execute)            execute the file (.sh files)       enter the directory (cd)

EX:
$ls -l userlist 
-rw-r--r--   1 root root 7 Oct 31 12:30 userlist

positions                                 characters                        functions 
- - - - - - -- - -- - - - - -- - - - - - - - - - -  - - - - - - - --- -- - - - - - -- --  -- - - 
1                                            -/d/l                     this is a regular file/directory/link file. 

2-4                                          rw-                       permissions for user owner. 

5-7                                          r-w                       permissions for the group owner. 

8-10                                         r--                       permissions for others.



#################umask###############
umask - (user file creation mask)
->Is a value that decide the default permission on the file/directory when is created.
->When we create any file/directory , they get the default premistions as stored in umask.
To check the default mask of value 
$umask  
[root@server01 ~]# umask
0022
->For a file by the default it has no excute permissiion ,so the maximum full permission  for the file at the time of creation can be 666,
where has a directory can have full permissions 777


->The full permission for the file - 666
minus the the umask                - 022
                                    -----
the default permission for file      644  (rw-,r--,r--)
                                    -----
									
the full permission for the directory - 777									
minus the the umask                   - 022									
									   -----
the default permission for directory    755 (rwx,r-x,r-x)
                                       -----									


Default umask value normal user -002
the default permission for file is 666-002=664 (rw-,rw-,r--)
the default permission for directory 777-002=775 (rwx,rwx,r-x)
------------------------------------------------------------------
To change the umask value temproy 
$umask -027 = 777-027=750 - for directory (rwxr-x---)
              666-027=640 - for file (rw-r-----)
------------------------------------------------------------------
to change the umask value permanent    
$cd /home/thulasi  or cd /etc/profile 
$l.
$vim .bashrc
go to last line add

umask 027 
:wq!
$umask 
$source .bashrc 
  
###########permissions groups ##########s
owner - u 
group - g 
all other user - o 
all user (owner+group+all other users) - a

permission types :-
-----------------
read - r
write - w 
excute - x
 
operators :-
---------
+ ------->add the permissions 
- ------->remove the permissions 
= ------->replacing the existing permissions

#chmod (symbolic method )
->these cammand is used to change the access rides to files and directories (change the permission files and directories ).

to add the other owner  permission  change
$chmod o+w <filename> 
$ll <filename>
to remove the other owner permission changed 
$chmod o-w <file name >
$ll <filename>
to old permission removed new permission adding 
$chmod o=w <filename>
$ll <file name >

$chmod ugo-rw filename 
$chmod ugo+x filename 
$chmod ugo=rwx filename 
$chmod a=rwx filename                                         
 
$chmod o=wx <directoryname >
$mkdir /xyz 
$touch /xyz/{1..4}.txt
$ls -ld /xyz 
$chgrp username /xyz 
$ls -ld /xyz 
$chown thulasi:username /xyz
$ls -ld /xyz 
$chmod 770 /xyz 
$ls -ld /xyz
ctrl+alt+f2
ctrl+alt+f1 
 
#########Advanced permissions or special permissions#############

 ->They special permission  are:
1. SUID(set user id )
2.SGID(set group id)
3.Sticky bit 
 
 
They are two methods to apply the special permission 
1.Symbolic  method 
2.Numeric method 


symbolic method 
---------------------
           Apply       Remove    syntax 
          -------------------------------
SUID       u+s          u-s      chmod u+s              chmod u-s 
SGID       g+s          g-s      chmod g+s              chmod g-s
sticky bit  +t           -t 	 chmod 0+t or chmod +t  chmod  -t 	  

Numeric method
-----------------------------------------
SUID       (4)    chmod 4755    chmod 755 
SGID       (2)    chmod 2755    chmod 755
sticky bit (1)    chmod 1755    chmod 755

suid -> It allows the user to execute a program with the permission of its owner. 
-----

$which passwd
$ls -l /bin/passwd 
ex:$ls -l /bin/passwd
-rwsr-xr-x 1 root root 27856 Aug 12  2019 /bin/passwd
$chmod u-s /bin/passwd 
$ls -l /bin/passwd 
$chmod u+s /bin/passwd 
  or 
$chmod 4755 /bin/passwd   


##sgid
->set group id can be used directories to make sure that all files inside the directory are owned by the group owner of the directory.
-> The setgid bit is displayed at the same location as the X
-> The setgid bit is displayed at the same location as the X permission for group owner. 

##sticky
->You can set the sticky bit on a directory to prevent users form removing files that they do not own as user owner (it is very useful in share environment).
->It protects the data from other user when all users having full access permission on the directory .

$mkdir dirname                              
$ls -ld  /dirname 
$chmod 1777 /dirname  (or) $chmod +t /dirname 
$ls -ld /dirname
$chmod 1777 /dirname 
$ls -ld /dirname 

#ACL - (Access control list) 
->It is mainly used for assign permission for any particular user or any group .
they are two type of ACL 
1.access acl 
2.default acl 

->An access acl  is the  associate with the specpic file or directory.
->A default acl can only the associate with a directory.
->If any create file and directory in default acl assgin folder default acl automatically applied on that file and directory .
->To verify the  acl enable or not in our system 
ex:
$ cat /boot/config-3.10.0-1160.81.1.el7.x86_64 |grep -i acl
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_FS_POSIX_ACL=y
CONFIG_GENERIC_ACL=y
 
->ls -l command we only give the information  that acl as implemented on file or not,
>If implemented indicates + symbol  at end of the file and directory permission  
$getfacl : getfacl command will give complete detail  about the acl.  
$getfacl <file or directory name >
Ex:
[$getfacl logs
 #file: logs
 #owner: root
 #group: root
   user::rwx
   group::r-x
   other::r-x]
   
$setfac: setfacl command sets the acl for a file and directories.
->use the -m option to add or modfiy the acl on file and directory.
$setfacl -m u:<username>:rwx /root/file2.txt     
$getfacl /root/file2.txt 

#
$setfacl -m g:<groupuser name>:rw /root/file.txt 
$ls -l /root/file.txt 
$getfacl /root/file.txt 
to verfiy another user 
$su - thulasi          
$cd /root
$ll
$cat >> file.txt 
$cat file.txt

$setfacl -m u:username:rw,g:<groupuser name>:rw /root/file.txt 
$getfacl /root/file.txt  


$setfacl -m o: :rw  /root/file2.txt 
$getfacl /root/file2.txt


#To remove the acl  
$setfacl -x u:<username>: /root/file2.txt 
$getfacl /root/file2.txt

$setfacl -x g:<groupuser name>: /root/file.txt 
$getfacl /root/file.txt
$getfacl /root/file.txt

$setfacl -x o: :--- /root/file2.txt 
$getfacl /root/file2.txt
#To all remove the completely acl  files 
$setfacl -b /root/file2.txt 
$ls -l /root/file.txt 


##recursively access control list:
->We can acl recursively to directory structure with option " -R " 
->use the (X) with recursion  option so that file excustion permission  non set and directory gets the excute permission.
->X:use the rwx to directory ,for file its gives the "rw" permission 
->X gives only excustion permission to the directory not for the file.
$setfacl -R -m u:username:rX <dirname>
#create directory and files and sub-directory  and apply the recursively acl for the directory 
$mkdir /dir1 ;touch /dir1/file{1..5}.txt 
$mkdir /dir1/dir2 ;touch /dir1/dir2/{a..d}.txt 
$ll /dire1;ll /dir1/dir2
$setfacl -Rm u:<username>:rwX,g:<db>:rX /dir1
$getfact /dir1             

To  remove the complete remove acl in directory 
$setfacl -Rb /dir1
$getfact /dir
#copy the acl of file one and apply to the file two 
$touch file1.txt file2.txt 
$ll
$getfacl file1.txt 
$setfacl -m u:<username>:rw,g:<db>:rw  file1.txt 
$getfacl file1.txt 

$setfacl -Rb /dir1
$ll /dir1
note:no apply defaut acl on existing file and directory .

##ACL MASK### to temporary acl mask
acl mask 
$mkdir /dir12
$touch /dir12/file1.txt 
$echo file is create for testing >> /dir12/file1.txt
$cat /dir12/file1.txt
$setfacl -m u:<username>:rw,g:<db>:rw  /dir12/file1.txt
$getfacl /dir12/file1.txt
$su - urename 
$cd /dir12/file1.txt
$ll
$vim /dir12/file1.txt
$logout

$setfacl -m m::rw /dir12/file1.txt
$getfact /dir12/file1.txt

##########################################################################################################
###########configuring password-less Authentication (SSH key -based Authentication) ######################
->Configure SSH server to allow login only using public / private keys.
->So go to client machine and generate private and public key pair. 
->copy the public key to  server and copy the private key to client.
->server will use this public key to encrypt the trafic sent to the client side,only the client who having valid private key able to decypt trafic and access will be allowed.
#configure the client for password less root authentication using the passphrase access
$vim /etc/ssh/sshd_config
$systemctl restart sshd 

go to clinet side   as root user:-
$ssh-keygen :- this utility is used to create the public/privates.
               this utility is used to create the public/private key pair.
$ssh-keygen -t rsa
$ssh-copy-id  <hostname>
   or           
$ssh-copy-id  -i id_ras.pub  root@ip 
yes
next verfiy the your side 
$ls -al /root/.ssh/
$cat /root/.ssh/authorized_key  (its a public key )

next go to client side
ssh -i .ssh/id_ras root@hostname 
#If don't want type  passphrase again and again
cesathe passphrase
$cd /root/.ssh
$ssh-agent /bin/bash
$ssh-add
$ssh 10.2.2.2 


############################################
ssh-agent :use ssh-agent to automate inputing passphrase on SSH key pair authentication .
#to run ssh-agent 
$ eval $(ssh-agent)
#to add the passphrase
$ssh-add 
#to verify 
$ssh-add  -l 
try to connect with out inputting passphrase
$ssh username@ip 
#to stop ssh agent 
->SSh agent process running remains running till you logout system 
$ssh-agent -k 
   or 
$eval $(ssh-agent -k)

after genrating the key pair on client server
$su - thulasi
  
$mkdir  .ssh
$ls -al .ssh/

$scp /root/.ssh/id_ras.pub  username@ip:/.ssh/pub_key  

##################################################################################################
########Troubleshooting of booting relate issue #############
#initramfs file missing ('kernal panic' message display)
$cd /boot
$ll
$mv initramfs-3.10.0-1160.81.1.el7.x86_64.img  initram
->now boot the machine in resk mode select the kernal  press "e". 
->go to linux16 th word line, go to end  
#systemd.unit=rescue.target
#ctrl+x
note:-
If we use this way if required the  initramfs file


method (2):-
1.boot the machine with help of rhel7.9 dvd 
2.click power and its showing "Power on to Firmware" click enter
3.to boot  change the boot  priority  first boot device on the dvd second "hard Drive" next press F10 
4.next select the "Troubleshooting" enter  
5.next click down arrow select "Rescue a Red Hat Enterprise Linux system" press enter 
6."please make a selection from the above : 1" press enter 
7."Please press <return> to get a shell." press enter 
  sh 
   
 skip
 
 
 
 
 
 
 #######################################################################################
 ######Network repository - using FTP ############
$mount /dev/sr0 /mnt
$cd /mnt
$ll
$cd packages                   (minimum instalization)
$rpm -ivh createrepo 
$rpm -ivh python 
$rpm -ivh yum-......el7 norach 
ftp port number =21,20

to install the ftp package 
$rpm -ivh vsftd*
$cd /mnt/package/
$cp rvf *  /var/ftp/pub/  
          or 
$cp -rvf /mnt
$ls 
$cp -rvf package /var/ftp/pub
$createrepo -vg  /mnt/repodata/3df9................................-comps-server.x86_64.xml /var/ftp/pub/pacakges/        (group of packages menting)
$cd /var/ftp/pub/pacakges/
$ls -l |grep '^d'
$cd repodata 
$ll 
$rpm -qc vsftd pd   -->it is showing vsftd configuration file .
$vim /etc/vsftd/vsftd.conf
#annonymous_enable=YES
remove the # symbol 
annonymous_enable=YES
:wq!
$systemctl status vsftpd 
$systemctl start vsftpd 
$systemctl enable vsftpd 
allow the port  in server 
$firewall-cmd --add-port=21/tcp --permanent 
$firewall-cmd --add-port=20/tcp --premanent	
$firewall-cmd reload 

vim /etc/yum.repos.d/ftp.repo
[Rhel7.9_ftp]
name=Red hat 
baseurl=file:///var/ftp/pub/packages
enabled=1
gpgchek=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
:wq!
$yum clean all
$yum repolist all
$yum grouplist all

$scp -rv  /etc/yum.repos.d/ftp.repo thulasi@10.1.1.1:/etc/yum.repos.d/

#To setup the yum clinet(ip 10.1.1.1) 
to verfiy the clinet server 
$cat /etc/yum.repos.d/
$yum clean all 
$yum repolist all 
#################################################################################################