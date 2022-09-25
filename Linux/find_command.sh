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
#### find command required the specific location.
$ find <location><options><file or directory> (to find the specific file or directory)
 The options are, -name -----> search files and directories
-prem -----> search for permissions
-size -----> search for sizes
-user -----> search for the owner
-uid -----> search for files/directories of uid)
-gid -----> search for files/directories of gid)
-group -----> search for group owner
-empty -----> search for empty files
-amin -----> search for access time
-mmin -----> " " 
-cmin -----> " "
-atime -----> search for access day (access day, minutes, hrs, ...etc)
-mtime -----> search for modify day (change the content)
-ctime -----> search for change day (permissions, .....etc)
Examples :
# find / -name <file name> (to search for file names in / directory)
# find / -name <file name> -type f (to find file names only)
# find / -name <directory name> -type d (to find directories with small letters only)
# find / -iname <file/directory name> -t d (to search for small or capital letter files/directories)
#find / -empty (to search empty files or directories)
# find / -empty -type f (to search for empty files only)
# find / -empty -type d (to search for empty directories only)
# find / -name " *.mp3" (to search for .mp3 files only)
# find / -size 10M (to search for exact 10M size file/directories)
# find / -size -10M (to search for less than 10M size files/directories)
# find / -size +10M (to search for greater than 10M size files/directories)
# find / -user student (to search for student user files/directories)
# find / -group student (to search for student group files/directories)
# find / -user student -not -group student (to search for student user files and not student 
group files)
# find / -user student -o -group student (to search for student user and student group 
files/directories)
# find / -uid <uid no.> (to search for files/directories which belongs to the user 
having the specified user id)
# find / -gid <gid no.> (to search for files/directories which belongs to the group 
 having the specified group id)
# find / -prem 755 (to search file/directories which are having the 
permissions 755)
# find / -prem -755 (to search file/directories which are having the 
permissions below 755 and also at least one match also)
# find / -mmin 20 (to search for files/directories which are modified within 20 minutes, 
 +20 ----> above 20 minutes and -20 -----> below 20 minutes)
# find / -mtime 2 (to search files/directories which are modified within 2 days)
# find / -name "*.mp3" -exec rm -rf { } \; (to search all .mp3 files and delete them)
# find / -name "*.mp3" -exec cp -a { } /ram \ ;(to search all mp3 files and copy them into /ram 
directory)
# find / -user student -exec cp -a { } /ram \; (to search student user's files and directories and 
 copy them into /ram directory)
# find / -nouser -exec mv -a { } /home/ram \; (to search files/directories which are not 
belongs to any user and move them into /home/ram directory)
# du -h / |sort -r |head -n 10 (to search 10 big size files in reverse order