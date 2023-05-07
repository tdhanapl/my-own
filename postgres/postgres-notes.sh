## What is database?.
database is used to store, manipulate and retrieve the data.
##Relationl database
Relationl database  means relation between one or more tables
##SQl(Structured Query Langauage) is a programming language and manage data held in a relational database. 
store data in tables and it contain columns and rows. 
## what is postgres ?
PostgreSQL is powerful, open source object-relational database. object-relational database management system

## Connect to the postgres database 
$ psql
psql (14.7)
Type "help" for help.
postgres=#
##help
postgres=# help
You are using psql, the command-line interface to PostgreSQL.
Type:  \copyright for distribution terms
       \h for help with SQL commands
       \? for help with psql commands
       \g or terminate with semicolon to execute query
       \q to quit
##To exit or quit from database
postgres=# \q
## FIND DATA DIRECTORY LOCATION 

DATA_DIRECTORY - > Specifies the directory to use for data storage.
postgres=# show data_directory;
     data_directory
------------------------
 /var/lib/pgsql/14/data
(1 row)

##Find location of postgres conf files
postgres=# show config_file;
              config_file
----------------------------------------
 /var/lib/pgsql/14/data/postgresql.conf
(1 row)
postgres=# show hba_file;
              hba_file
------------------------------------
 /var/lib/pgsql/14/data/pg_hba.conf
(1 row)
postgres=# show ident_file;
              ident_file
--------------------------------------
 /var/lib/pgsql/14/data/pg_ident.conf
(1 row)
##List of user roles 
test=# \du
                                   List of roles
 Role name |                         Attributes                         | Member of
-----------+------------------------------------------------------------+-----------
 dhana     | Create DB                                                  | {}
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 
 NOTE: \du command output includes both user and roles(custom created roles only).
postgres users are bydefault role, but roles are not bydefault user.
##To check database version 
postgres=# select version ();
        or 
postgres=# show server_version; 
                                                 version
----------------------------------------------------------------------------------------------------------
 PostgreSQL 14.7 on x86_64-pc-linux-gnu, compiled by gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2), 64-bit
(1 row)
### Check archive status
postgres=# select name,setting from pg_settings where name like 'archive%';
          name           |  setting
-------------------------+------------
 archive_cleanup_command |
 archive_command         | (disabled)
 archive_mode            | off
 archive_timeout         | 0
(4 rows)

##To list of database
postgres=# \l
                                  List of databases
   Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
-----------+----------+----------+-------------+-------------+-----------------------
 postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
(3 rows)
##View existing connection limit setting:( datconnlimit )
test=# select datname,datallowconn,datconnlimit from pg_database where datname='postgres';
-[ RECORD 1 ]+---------
datname      | postgres
datallowconn | t
datconnlimit | -1           -- >Means unlimited connections allowed
##To restrict all the connections to db
 test_dev=# alter database test connection limit 0;
ALTER DATABASE
NOTE - > Even if connection limit is set to 0 , the superuser will be able to connect to database.

## create a database
postgres=# CREATE DATABASE test;
CREATE DATABASE

##to check new database created or not 
postgres=# \l 
                                  List of databases
   Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
-----------+----------+----------+-------------+-------------+-----------------------
 postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
 test      | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |

            or
postgres=# select datname from pg_database;
  datname
-----------
 postgres
 template1
 template0
 test
(4 rows)
##To check databse size 
postgres=# \l+
                                                                    List of databases
   Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges   |  Size   | Tablespace |                Description
-----------+----------+----------+-------------+-------------+-----------------------+---------+------------+--------------------------------------------
 postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |                       | 8681 kB | pg_default | default administrative connection database
 template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +| 8425 kB | pg_default | unmodifiable empty database
           |          |          |             |             | postgres=CTc/postgres |         |            |
 template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +| 8577 kB | pg_default | default template for new databases
           |          |          |             |             | postgres=CTc/postgres |         |            |
 test      | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =Tc/postgres         +| 8641 kB | pg_default |
           |          |          |             |             | postgres=CTc/postgres+|         |            |
           |          |          |             |             | dhana=CTc/postgres    |         |            |
(4 rows)

## To connect database
postgres=# \c test
You are now connected to database "test" as user "postgres".

## swicth between database 
test=# \c postgres
You are now connected to database "postgres" as user "postgres".
# create a table 
##syntax 
create table table_name ( 
    Column name +  data type + constarints if any
    )

test=# create table person (
    id INT,
    first_name VARCHAR(50),
    lats_name VARCHAR(50),
    gender VARCHAR(7),
    date_of_birth DATE
);
CREATE TABLE
##To list the tables
CREATE TABLE
test=# \d
         List of relations
 Schema |  Name  | Type  |  Owner
--------+--------+-------+----------
 public | person | table | postgres
(1 row)

#### list the table with size 
test=# \d+
                                          List of relations
 Schema |     Name     |   Type   |  Owner   | Persistence | Access method |    Size    | Description
--------+--------------+----------+----------+-------------+---------------+------------+-------------
 public | data         | table    | postgres | permanent   | heap          | 8192 bytes |
 public | data_id_seq  | sequence | postgres | permanent   |               | 8192 bytes |
 public | dhana        | table    | postgres | permanent   | heap          | 8192 bytes |
 public | dhana_id_seq | sequence | postgres | permanent   |               | 8192 bytes |
(4 rows)

## create table with constraints
test=# create table data  (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(7) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(150) NOT NULL
);
Note:
If you using NOT NULL means in column and row must need fill.

##insert record into tables
test=#  INSERT INTO dhana (
    first_name,
    last_name,
    gender,
    date_of_birth,
    email)
    VALUES ('venky', 'k', 'Male', DATE '1999-11-09', 'venky@gmail.com');

## To check or list the create tables 
test=# \d+
                                          List of relations
 Schema |     Name     |   Type   |  Owner   | Persistence | Access method |    Size    | Description
--------+--------------+----------+----------+-------------+---------------+------------+-------------
 public | data         | table    | postgres | permanent   | heap          | 8192 bytes |
 public | data_id_seq  | sequence | postgres | permanent   |               | 8192 bytes |
 public | dhana        | table    | postgres | permanent   | heap          | 8192 bytes |
 public | dhana_id_seq | sequence | postgres | permanent   |               | 8192 bytes |
(4 rows)

##select particular columns  from table
postgres=#   select id, first_name, email from data;
 id  | first_name |               email
-----+------------+-----------------------------------
   1 | Jonell     | jrawlence0@whitehouse.gov
   2 | Esdras     | ejimpson1@nytimes.com

##select oder by from the table of particular columns
postgres=# select * from data order by last_name;
 id  | first_name |  last_name   |               email               |   gender
-----+------------+--------------+-----------------------------------+------------
  82 | Lurette    | Ackroyd      | lackroyd29@bravesites.com         | Female
  18 | Ailene     | Barnwell     | abarnwellh@yelp.com               | Female

##select unique from gender using distinct
postgres=# select distinct gender from data order by gender asc;
   gender
------------
 Agender
 Female
 Male
 Non-binary
 Polygender
(5 rows)

##select colum using  where condition                                                                                                                                                                                    where clause 
postgres=# select  * from data where last_name='Turl' and (gender='Male' or gender='Female');
 id | first_name | last_name |       email       | gender
----+------------+-----------+-------------------+--------
 66 | Elia       | Turl      | eturl1t@wiley.com | Male
(1 row)
postgres=# select * from data where gender='Male' and (id='99'  or id='90' or id='93');
 id | first_name | last_name  |            email             | gender
----+------------+------------+------------------------------+--------
 90 | Weidar     | OHartnedy | wohartnedy2h@walmart.com     | Male
 93 | Tull       | Isakowicz  | tisakowicz2k@apache.org      | Male
 99 | Griswold   | Cabera     | gcabera2q@washingtonpost.com | Male
(3 rows)
##List of schemas
test=# \dn+
                          List of schemas
  Name  |  Owner   |  Access privileges   |      Description
--------+----------+----------------------+------------------------
 public | postgres | postgres=UC/postgres+| standard public schema
        |          | =UC/postgres         |
(1 row)

##



















##To delete the database
postgres=# drop database test;
DROP DATABASE
##To delete the table 
test=# drop table person;
DROP TABLE
#Note: Never use in producation envoriment

##url for database command 
https://dbaclass.com/postgres-db-scripts/

##online complier of postges 
https://onecompiler.com/postgresql/

##Syntax help
1. CREATE
CREATE command is used to create a table, schema or an index.

Syntax:
         CREATE TABLE table_name (
                column1 datatype,
                column2 datatype,
                ....);
2. ALTER
ALTER command is used to add, modify or delete columns or constraints from the database table.

Syntax
ALTER TABLE Table_name ADD column_name datatype;
3. TRUNCATE:
TRUNCATE command is used to delete the data present in the table but this will not delete the table.

Syntax
TRUNCATE table table_name;
4. DROP
DROP command is used to delete the table along with its data.

Syntax
DROP TABLE table_name;
5. RENAME
RENAME command is used to rename the table name.

Syntax
ALTER TABLE table_name1 RENAME to new_table_name1; 
6. INSERT
INSERT Statement is used to insert new records into the database table.

Syntax
INSERT INTO table_name (column1, column2, column3, ...) VALUES (value1, value2, value3, ...);
7. SELECT
Select statement is used to select data from database tables.

Syntax:
SELECT column1, column2, ...
FROM table_name; 
8. UPDATE
UPDATE statement is used to modify the existing values of records present in the database table.

Syntax
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition; 
9. DELETE
DELETE statement is used to delete the existing records present in the database table.

Syntax
DELETE FROM table_name where condition;

