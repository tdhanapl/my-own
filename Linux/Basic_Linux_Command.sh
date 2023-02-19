######## Type of user in linux srever ##########
1.Normal user
Ex:
ec2-user:x:1000:1000:Cloud User:/home/ec2-user:/bin/bash
postgres:x:1001:1001::/home/postgres:/bin/bash
dhanapal:x:1005:1005::/home/dhanapal:/bin/bash
2.Root user
Ex:
root:x:0:0:root:/root:/bin/bash
3.Systemuser
Ex:
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
##########To path of normal user home directory######
$cd /home/<username>
Ex:
cd /home/thulasi

###############To check all running process######################
To see every process on the system using standard syntax:
$ ps -ef
 	or
$ ps -e
          
To see every process on the system using BSD syntax:
note:
Berkeley Software Distribution (BSD)
$ ps ax
	or
$ ps axu
$ ps -ef |grep <PID or process name>
#####To know the which is file or directory######
d--->if it is start "d" means it is directory
- --> if it is start "-"means it is file
l --> if it is start "l" means it is  link file

#############To check a IP Address  in Linux server #########
$ ifconfig 
	or
$ ip a
	or 
$ hostname -i

$ ip a |grep inet 
########### To check RAM or Memory size in Linux server###########
$ free -h
	or
$ cat /proc/meminfo

########## To check cpu core in  Linux server###########
$ lscpu
	or 
$ cat /proc/cpuinfo

########## To check kernel version in  Linux server###########
$ uname -a
	or 
$ uname -r

########## To check linux os type with version in  Linux server###########
$ cat /etc/os-release
	or 
$ cat /etc/redhat-release

############ To create a user in redhat Linux server###########
$ useradd <username>

######TO create a user in ubuntu linux  server  ################
$ adduser <username>

########## To assgin the password for created user in Linux server#######
$ passwd <username>
	
######### To check user account information or user details  in Linux server###########
$ cat /etc/passwd
my passwd is thulasi
$ cat /etc/passwd |grep root
#######To provide sudo access to the normal user ###########
$ vim /etc/sudoers
dhanapal        ALL=(ALL)       ALL
:wq!

########To check user password information in Linux server######
$ cat /etc/shadow

##########To delet a user in  Linux server###########
$ userdel <username>

########To list the files or folder in  Linux server###########
$ ls -lrth
	or 
$ ll -lrth
 Note:-
    ls  means listing sortly
    ll means long listing
#######To check file system size or  mount points in  Linux server###########
$ df -h
Note:-
   df  means disk free 
$ df -h |grep /
#######To check current working  directory in  server###################
$ pwd 
    
######To delete the file or directory in server###################
$ rm -rvf <file or directory(means folder)>
Note
rm means remove the file or directory

############To switch user with root privigiliesin server###################
$ sudo -i or sudo su -

##########To switch from one user to another user in server########################
$ su - <username>

########### TO switch from  one server to another server###########
$ ssh <username >@ipadderss 
ex:
$ ssh thulasi@ipadderss
password: 
$ hostname -i
Note:
To check ipadderss of the current server

###### To copy file or directory from  one server to another server###########
$ scp -rv <soures path of file or directory>   <username@ipaddress:userhome directory>

Ex:
$ scp -rv    patch_precheck.sh thulasi@100.20.247.8:/home/thulasi/

########To dispaly or read file in Linux server######
$ cat <filename>
	 
$ cat thulasi
#######sysmbol indication of users#################
$------>normal user
#------>root user

###########To signout  or logout from the server###################
$ exit
	or 
$ ctrl + d

######To clear screen or diplay###########
$ clear 
	or 
$ ctlr + l

##### To insert in the file###################
$ i

####### To write and save the file###################
$ :wq

#######To quite from the file###################
$ :q

####### To write from the file###################
$ :w

######## To set the number from the file###################
$ :set nu
    or
$ :su no	

####### To last of the line goes to cursor #######
$ shift+G
######
undo --->u

####### To first line goes on the cursor ############
$ g or  1+shift+G

########## To check all file or directory size  in paticular path server###################
$ du -sh *

########## To check total size of total directory in paticular path of  server####################
$ du -sh

############ To rename   file or directory in server###################
$ mv <old file name or old directory name> <old file name or old directory name>

######To copy file or directory from one path to another path in  server###################
$ cp -rvf <source path> <destination path>
options:
 -v, --verbose                explain what is being done
 -f, --force                  if an existing destination file cannot be
                                 opened, remove it and try again (this option
                                 is ignored when the -n option is also used)
-R, -r, --recursive          copy directories recursively
EX:-
[root@terraform ~]# cp -rvf sucess.sh /tmp
'sucess.sh' -> '/tmp/sucess.sh'
########### To filter the  particular  word in server###################
$ cat /etc/passwd |grep root

########## To set hostname in server###################
[root@zemsmt01 ~]#
<username>@hostname
$ hostnamectl set-hostname <hostname>
$ bash
Note:
we need enter this "bash" command must and should to updated kernel

##### To check services status  in server###################
$ systemctl status <services name>

##### To start the services in server###################
$ systemctl start <services name>
 
#### To stop the services in server###################
$ systemctl stop <services name>
 
#### TO restart the services in server###################
$ systemctl restart <services name>

#########To check the network interface card/LAN card ######
$ nmcli device status
#######Difference between yum and rpm ##########
YUM:
YUM can install depedencies package automatically
we can install package with yum in any path 

RPM:
RPM can not  install depedencies package automatically
we can install package in that particular path only.

#### To install package using yum(yellowdog updater modifier)#######
$ yum install <package> 

EX:-
yum install telnet

####To remove package  using yum(yellowdog updater modifier)#######
$ yum remove <package>
EX:-
yum remove telnet

####To check all  serivces in server###################
$ systemctl list-unit-files

####To check active running serivces in server###################
$ systemctl --type=service --state=active
				
#####To dowload rpm package from internet  to linux server###########
$ wget http://mirror.centos.org/centos/7/os/x86_64/Packages/telnet-0.17-65.el7_8.x86_64.rpm
Note: 
The above links are we can find in this website(centos.pkg.org). Here we can download the rpm package

########### Install debian packeages############ubuntu servers
$ dpkg -i <packagename> 
EX:
$ dpkg -i cortex-7.8.0.74226.deb
Note:
If we want to install "debian" or rpm package we need to go that paticular path of debian or rpm package location

#####To insatll rpm packages#######
$ rpm -ivh <rpm package>

#####To check installed package in the server###################
$ rpm -qa 
$ rpm -qa |grep <package name>
EX:-
$ rpm -qa |grep -i basesystem-11-5.el8.noarch

########### To check server  uptime or how many server is running############
$ uptime
####To create tar File###############
Tar is used to bundle multiple file and directory as single file 
$ tar -cvf <tar_filename.tar> <source file and directories>
$ tar -cvf thulasi_folder.tar data
############ To extarcting  the tar file in the server######
$ tar -xvf  thulasi_folder.tar

#### To check ports opened ot not in server level#########
$ telnet localhost <port>
Ex:
  telnet <ipaddress> 25
###### To check listing or open ports in server #########
$ netstat -nutlp
#####a Linux terminal pager that shows a files contents one screen at a time##############
$ less
####used to view the text files in the command prompt, displaying one screen at a time in case the file is large########
$ more
######## 
$ gzip <file or directory>
$gunzip <file or directory>
########
$cat >> ram
Enter
$ctrl+d

$head -->the head command will output the first part of the file.
$tail -->the tail command will print the last part of the file.

$ last --> It is showing  lastlogin the server
$top -->top command is used to show the Linux processes. It provides a dynamic real-time view of the running system. Usually, this command shows the summary information of the system and the list of processes or threads which are currently managed by the Linux Kernel.

#######To run the shell scripts ########
$ sh < script file name> -->ex:shram.sh
       or
$ ./ < script file name> -->ex:./ram.sh
######## option  (-i) is case sensitive######
[root@ip-172-31-9-171 ~]# egrep -i 'chown|chmod' linux_commands
Ex:chown
   chmod
   Chmod
   Chown
########### Run  levels#################
Run levels is 7 types 
 
0-halt                          = init 0
1-singleuser mode               = init 1
2-multiuser mode,without NSF 	= init 2
3-full multiuser mode        	= init 3
4-unused                     	= init 4
5-GUI(Graphical User Interface) = init 5   
6-reboot                     	= init 6





  
  
  
  





