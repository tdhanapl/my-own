###################################################postgres database ################################################
#######installation of postgres########
# Install the repository RPM:
sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm

# Disable the built-in PostgreSQL module:
sudo dnf -qy module disable postgresql

# Install PostgreSQL:
sudo dnf install -y postgresql14-server

# Optionally initialize the database and enable automatic start:
sudo /usr/pgsql-14/bin/postgresql-14-setup initdb
sudo systemctl enable postgresql-14
sudo systemctl start postgresql-14
sudo systemctl status postgresql-14
#################3Connect to PostgreSQL Database on Linux, Windows########
Connect to PostgreSQL from the command line
Running the PostgreSQL interactive terminal program, called psql, which allows you to interactively enter, edit, and execute SQL commands. At the time of installing postgres to your operating system, it creates an "initial DB" and starts the postgres server domain running. Typically initdb creates a table named "postgres" owned by user "current logged in user name"

At the command line in your operating system, type the following command.

Debian based systems like Ubuntu :
Connect/login as root -

user@user-pc:~$ sudo -i -u postgres
postgres@user-pc:~$ psql
psql (9.3.5, server 9.3.6)
Type "help" for help.
Redhat based systems like Centos / Fedora :
Connect/login as root -

user@user-pc:~$ su - postgres
user@user-pc:~$ psql
psql (9.3.6)  
Type "help" for help.
Windows :
In windows, current user doesn't matter

C:\Program Files\PostgreSQL\9.4\bin>psql -U postgres
Password for user postgres:
psql (9.4.1)
Type "help" for help.

postgres=#
After accessing a PostgreSQL database, you can run SQL queries and more. Here are some common psql commands

To view help for psql commands, type \?.
To view help for SQL commands, type \h.
To view information about the current database connection, type \conninfo.
To list the database's tables and their respective owners, type \dt.
To list all of the tables, views, and sequences in the database, type \z.
To exit the psql program, type \q.
What is psql?

psql is a terminal-based front-end to PostgreSQL. It enables you to type in queries interactively, sent them to PostgreSQL, and see the query results.

psql [option...] [dbname [username]]
Option	Description
-a
--echo-all	Print all nonempty input lines to standard output as they are read. This is equivalent to setting the variable ECHO to all.
-A
--no-align	Switches to unaligned output mode.
-c command
--command=command	Specifies that psql is to execute one command string, command, and then exit. This is useful in shell scripts. Start-up files (psqlrc and ~/.psqlrc) are ignored with this option.
-d dbname
--dbname=dbname	Secifies the name of the database to connect to. This is equivalent to specifying dbname as the first non-option argument on the command line.
-e
--echo-queries	Copy all SQL commands sent to the server to standard output as well. This is equivalent to setting the variable ECHO to queries.
-E
--echo-hidden	Use the file filename as the source of commands instead of reading commands interactively. After the file is processed, psql terminates. 
This is in many ways equivalent to the meta-command \i.
-F separator
--field-separator=separator	Use separator as the field separator for unaligned output. This is equivalent to \pset fieldsep or \f.
-h hostname
--host=hostname	Specifies the host name of the machine on which the server is running. If the value begins with a slash, it is used as the directory 
for the Unix-domain socket.
-H
--html	Turn on HTML tabular output. This is equivalent to \pset format html or the \H command.
-l
--list	List all available databases, then exit. Other non-connection options are ignored. This is similar to the meta-command \list.
-L filename
--log-file=filename	Write all query output into file filename, in addition to the normal output destination.
-n
--no-readline	Do not use Readline for line editing and do not use the command history. This can be useful to turn off tab expansion when cutting and pasting.
-o filename
--output=filename	Put all query output into file filename. This is equivalent to the command \o.
-p port
--port=port	Specifies the TCP port or the local Unix-domain socket file extension on which the server is listening for connections. Defaults to the value of 
the PGPORT environment variable or, if not set, to the port specified at compile time, usually 5432.
-P assignment
--pset=assignment	Specifies printing options, in the style of \pset. Note that here you have to separate name and value with an equal sign instead of space. 
For example, to set the output format to LaTeX, you could write -P format=latex.
-q
--quiet	Specifies that psql should do its work quietly. By default, it prints welcome messages and various informational output. If this option is used, none
 of this happens. This is useful with the -c option. This is equivalent to setting the variable QUIET to on.
-R separator
--record-separator=separator	Use separator as the record separator for unaligned output.
-S
--single-line	Runs in single-line mode where a newline terminates an SQL command, as a semicolon does.
-t
--tuples-only	Turnoff printing of column names and result row count footers, etc.
-T table_options
--table-attr=table_options	Specifies options to be placed within the HTML table tag. See \pset for details.
-U username
--username=username	Connect to the database as the user username instead of the default. (You must have permission to do so, of course.)
-v assignment
--set=assignment
--variable=assignment	Perform a variable assignment, like the \set meta-command. Note that you must separate name and value if any, by an equal
 sign on the command line.
-V
--version	Print the psql version and exit.
-w
--no-password	Never issue a password prompt. If the server requires password authentication and a password is not available by other means such 
as a .pgpass file, the connection attempt will fail. This option can be useful in batch jobs and scripts where no user is present to enter a password.
-W
--password	Force psql to prompt for a password before connecting to a database.
-x
--expanded	Turn on the expanded table formatting mode.
-X,
--no-psqlrc	Do not read the start-up file.
-z
--field-separator-zero	Set the field separator for unaligned output to a zero byte.
-0
--record-separator-zero	Set the record separator for unaligned output to a zero byte. This is useful for interfacing, for example, with xargs -0.
-1
--single-transaction	When psql executes a script with the -f option, adding this option wraps BEGIN/COMMIT around the script to execute it as a single
 transaction. This ensures that either all the commands complete successfully, or no changes are applied.
-?
--help	Show help about psql command line arguments and exit.
Connect to PostgreSQL database using pgAdmin GUI application

You can also connect to PostgreSQL database using pgAdmin GUI application. Connect to the database at localhost:5432 using the user name postgres and the 
password supplied.

postgresql pgadminIII
Clicking on pgAdmin III following screen will come:

postgresql pgadminIII part2
Now, double click on PostgreSQL 9.4 under the "Servers Groups". pgAdmin will ask you for a password. You have to supply the password for the postgres user 
for authentication.

postgresql-pgadminIII part3
Under the Database(s) on this server section, find the desired database and execute SQL queries:

postgresql-pgadminIII Part 4