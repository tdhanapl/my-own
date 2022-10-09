###########Disable the root##############
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