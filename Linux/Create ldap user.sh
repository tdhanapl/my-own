######Create ldap user####
##On  ldap server side
1. Search for previous ldap user for syntax prompt 
$ ldapsearch -x cn=ldapuser1 -b dc=cntech, dc=local 
2. create file with ldif extensions
$ vim /newuser.ldif

dn: uid=ram,ou=users,dc=cntech,dc=local 
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: ram
cn: ram kumar
sn: kumar
givenName: John
userPassword: {crypt}x # set any enrypted password from /etc/shadow for this user and later we can change password 
loginShell: /bin/bash
uidNumber: 10000
gidNumber: 10000
homeDirectory: /home/ram
:wq

3. Now add the new ram user using the newuser.edit file to the ldap database.

$ ldapadd -x -W -D "cn=manager,dc=cntech,dc=local" -f /newuser.ldif
		enter ldappassword:XXX@67
		here dispaly user added

4. Now set the password for newly added ram  user
$ ldappasswd -s redhat@123 -W -D "cn=manager,dc=cntech,dc=local" -x "uid=ram,ou=users,dc=cntech,dc=local"

5. Verify the ldap search user id 
$ ldapsearch -x cn=ram -b dc=cntech, dc=local
	here dispaly the account details 

##on client server side 
$ getent passwd ram

$ getent passwd 


