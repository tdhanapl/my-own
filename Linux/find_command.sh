##########Finding files and file listing########
##Search based on name or regular expression match
$ find /home/slynux -name '*.txt' -print
#The find command has an option -iname (ignore case), which is similar to -name, but it matches filenames regardless of case.
#Consider the following example:
$ ls
example.txt EXAMPLE.txt file.txt
$ find . -iname "example*" -print
./example.txt
./EXAMPLE.txt
#The find command supports logical operations with the selection options. The -a and -and options perform a logical AND, while the -o  and -or option perform a logical OR.
$ ls
new.txt some.jpg text.pdf stuff.png
$ find . \( -name '*.txt' -o -name '*.pdf' \) -print
./text.pdf
./new.txt
The previous command will print all the .txt and .pdf files, since the find command matches both .txt and .pdf G files. \(and \) are used to treat -name "*.txt" -o -name "*.pdf" as a single unit

##########Searching based on file type###################
#The find command filters the file search with the -type option. 
Using -type, we can tell the find command to match only files of a specified type.
List only directories including descendants:
$ find . -type d -print
List only regular files as follows:
$ find . -type f -print
List only symbolic links as follows:
$ find . -type l -print
##The following table shows the types and argumentsfind recognizes:
#File_type      			Type argument
Regular file				f
Symbolic link				l
Directory					d
Character_special			c
Block device 				b
Socket 						s
FIFO 						b

###############Searching by file timestamp######
Unix/Linux filesystems have three types of timestamp on each file. They are as follows:
1.Access time (atime): The timestamp when the file was last accessed
2.Modification time (mtime): The timestamp when the file was last modified
3.Change time (ctime): The timestamp when the metadata for a file (such as permissions or ownership) was last modified.
#Consider the following example:
Print files that were accessed within the last seven days:
$ find . -type f -atime -7 -print
Print files that have an access time exactly seven days old:
$ find . -type f -atime 7 -print
Print files that have an access time older than seven days:
$ find . -type f -atime +7 -print
The -mtime  parameter will search for files based on the modification time; -ctime searches based on the change time.
The -atime, -mtime, and -ctime use time measured in days. 
The find command also supports options that measure in minutes. T
hese are as follows:
-amin (access time)
-mmin (modification time)
-cmin (change time)
#To print all the files that have an access time older than seven minutes, use the following
command:
$ find . -type f -amin +7 -print
###############Searching based on file size#############
Based on the file sizes of the files, a search can be performed:
# Files having size greater than 2 kilobytes
$ find . -type f -size +2k
# Files having size less than 2 kilobytes
$ find . -type f -size -2k
# Files having size 2 kilobytes
$ find . -type f -size 2k
Instead of k, we can use these different size units:
b: 512 byte blocks
c: Bytes
w: Two-byte words
k: Kilobytes (1,024 bytes)
M: Megabytes (1,024 kilobytes)
G: Gigabytes (1,024 megabytes)
##Deleting based on file matches
The find commands -delete flag removes files that are matched instead of displaying them. 
Remove the .swap files from the current directory:
$ find . -type f -name "*.swp" -del
##excute command with find
# find . -type f -user root -exec chown  -Rv ec2-user:ec2-user {} \;
$ Note:-
1.The command is terminated with \;.
The semicolon must be escaped or it will be grabbed by your command shell as the end of the find command instead of the end of the chown command.
2. The find  command uses an open/close curly brace pair {} to represent the filename. 
Each time find identifies a file it will replace the {} with the filename and change the ownership of the file.
For example, if thefindcommand finds two files with the root owner it will change both so theyre owned by ec2-user:
3. We cannot use multiple commands along with the -exec parameter.
It accepts only a single command, but we can use a trick.
Write multiple commands in a shell script (for example, commands.sh) and use it with -exec as follows:
-exec ./commands.sh {} \;
The -exec parameter can be coupled with printf to produce joutput. Consider this example:
$ find . -type f -name "*.txt" -exec printf "Text file: %s\n" {} \;
Config file: /etc/openvpn/easy-rsa/openssl-1.0.0.cnf
Config file: /etc/my.cnf