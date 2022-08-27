########mysql###########
1. What is MySQL or MariaDB?
MySQL or MariaDB is a database software to create and maintain the databases.
Upto RHEL - 6 the database software is MySQL and from RHEL - 7 onwards the database software is 
MariaDB.
If we want to do any transactions or database operations, we have to open the mysql > or mariadb >
prompt. 
In MySQL or MariaDB all the database operation commands will end with a " ; " (semicolon).
2. What is the profile of MySQL or MariaDB?
Package : mysql* (in RHEL - 6) and mariadb* (in RHEL - 7)
Version : 5.0 (in RHEL - 6) and 5.5 (in RHEL - 7)
Deamons : mysqld (in RHEL - 6) and mariadb (in RHEL - 7)
Configuration file : /etc/my.cnf
Installation
Commands : mysql_secure_installation
3. How to configure MySQL or MariaDB?
(i) Install the MySQL or Mariadb software packages.
# yum groupinstall mysql* -y (to install 
MySQL in RHEL - 6)
# yum groupinstall mariadb* (to install 
Mariadb in RHEL - 7)
(ii) Restart the mysqld and mariadb deamons.
# service mysqld restart (to start the mysqld deamon in 
RHEL - 6)
# chkconfig mysqld on (to enable the mysqld deamon at next boot 
in RHEL - 6)
# systemctl restart mariadb (to start the mysqld 
deamon in RHEL - 7)
# systemctl enable mariadb (to enable the mysqld deamon at next 
boot in RHEL - 7)
(iii) Check the mysql port is listening or not.
# netstat -ntulp | grep mysql (it works in both 
RHEL - 6 & 7)
 Where n -----> network t -----> tcp protocol u -----> udp 
protocol
 l -----> listening or not and p -----> port number
(iv) If we want to configure the database as localhost ie., database will not be available to remote 
systems.
# vim /etc/my.cnf (open this file and go to 2nd line, create an empty line and type as 
below)
 skip-networking=1 (save 
and exit this file)
(v) Restart the mysqld and mariadb deamons.
# service mysqld restart (to start the mysqld deamon in 
RHEL - 6)
# chkconfig mysqld on (to enable the mysqld deamon at next 
boot in RHEL - 6)
# systemctl restart mariadb (to start the mysqld 
deamon in RHEL - 7)
# systemctl enable mariadb (to enable the mysqld deamon at next 
boot in RHEL - 7)
(vi) Install the database engine. (it works in both 
RHEL - 6 & 7)
# mysql_secure_installation
 Enter current root password : (here do not enter any passwords and just press 
the Enter Key)
 Set root password [y/n] : y
 Remove ananymous users [y/n] : y
 Disallow root login remotely [y/n] : y
 Remove test database and access to it [y/n] : y
 Reload the privilages tables now [y/n] : y
(vii) Login into the mysql server as a root user.
# mysql -u root -p (where u -----> user and p -----> 
using password)
 (we have to enter the password for root user)
(viii) See the default databases.
mysql > show databases; (in RHEL - 6)
mariadb > show databases; (in RHEL - 7)
(ix) Exit from the database by mysql > exit; (in RHEL - 6) and mariadb > exit; (in RHEL - 7)
4. How to create a database, create tables, enter the data into the tables and access that data?
(i) Login into the database server by # mysql -u root -p command.
(ii) Create the database and connect the databases.
mysql or mariadb > create database <database name>; (to create the 
database)
mysql or mariadb>show databases; (to see all the 
databases in the server)
mysql or mariadb > use <database name>; (to connect to the 
specified database)
(iii) Create a table, enter the data and query the data.
mysql or mariadb > create table <table name> (field name1 data type (size), 
 field name2 data type (size),
 field name3 data type (size));
Example : mysql or mariadb > create table mydetails (Name varchar (30), status varchar 
(10), 
 Address varchar (50), phone 
int (10));
(iv) See the structure of the table.
mysql or mariadb >describe<table name>; (to see the structure of the table)
Example : mysql or mariadb > describe mydetails;
(v) Insert or enter the data into the table.
mysql or mariadb > insert into mydetails values ("Raju", "Single", Hyderabad", 
9848750755);
(vi) Query the table to get the data.
mysql or mariadb >select * from mydetails; (to see all the 
records of the tables)
mysql or mariadb > select name, phone from mydetails; (to select the wanted data ie., 
filtering the data)
5. How to take a backup of the database, drop the database and restore the database using backup?
To take a backup or restore of the database first we should comeout from the database server and then 
take a backup or restore the backup.
(i) Exit the from the database server.
mysql or mariadb > exit;
(ii) Take a backup of the database.
# mysqldump -u root -p <database name>><file name with full path>
Example : # mysqldump -u root -p mydetails > /root/mydetails.bak
(iii) Delete the database from the database server.
mysql or mariadb >drop database <database name>;
Example : mysql or mariadb > drop database mydetails;
(iv) Restore the deleted database using the backup copy.
mysql or mariadb >exit;
# mysql -u root -p <database name><<backup file name with path>
Example : # mysql -u root -p mydetails < /root/mydetails.bak
6. How to create the user in the database and make the user to do transactions or operations?
(i) To create the user in the database first login to the database and then create the user.
mysql or mariadb > create user <user name>@<host name> identified by "<password>";
Example : mysql or mariadb > create user raju@localhost or server9.example.com 
identified by 
"raju123";
(ii) Make the user to do transactions on the database. (nothing but granting the permission)
mysql or mariadb > grant select, insert, update, delete on <database name>.* to <user 
name>; or 
mysql or mariadb > grant all on <database name> .* to <user name>;
Example : mysql or mariadb > grant select, insert, update, delete on mydetails .* to raju; 
or
 mysql or mariadb > grant all on mydetails .* to raju;
(where database . * means granting permissions on all the contents like tables, indexes, 
views, 
synonyms and others)
7. How to update the table in the database with new data?
mysql or mariadb > update <table name><field name>=<new value> where <primary key field 
name>="<value>";
Example : mysql or mariadb > update mydetails name="bangaram" where name='raju';
8. How to delete the table from the database?
mysql or mariadb > drop table <table name>;
Example : mysql or mariadb > drop table mydetails;
9. How to connect the remote database from our system?
# mysql -u root -h <host name> -p (here we have to enter the 
password)
Example : # mysql -u root -h server9.example.com -p
(If the database is configured as localhost database, then server will not allow remote database 
connections and Permission denied message will be displayed on the screen)
10. How to add mysqld service to IPtables and mariadb service to firewall?
In RHEL - 6 :
# iptables -A INPUT -i eth0 -p tcp -m tcp --deport 3306 -j ACCEPT
# iptables -A OUTPUT -i eth0 -p tcp -m tcp --deport 3306 -j ACCEPT
# service iptables save
# service iptables restart
# chkconfig iptables on
In RHEL - 7 :
# firewall-cmd --permanent --add-port=3306
# firewall-cmd --complete-reload