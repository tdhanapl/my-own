############Sed command###########
##https://www.geeksforgeeks.org/sed-command-linux-set-2/
##https://www.geeksforgeeks.org/sed-command-in-linux-unix-with-examples/

#SED is Stand for  stream editor. with help of sed command we can perform these type of operations like
1. Search  and line print
2. Find and replace(substitution)
3. deletion line
4. Insertion anything before the line number. 
5. Appending anything after the line number.
##sed command works on the line numbers
###deatils of using sed with option
Sr.No.	Range & 				Description
1		p   					Prints the line
2		d   					Deletes the line
3		s/pattern1/pattern2/  	Substitutes the first occurrence of pattern1 with pattern2
4		'4,10d'					Lines starting from the 4th till the 10th are deleted
5		'10,4d'					Only 10th line is deleted, because the sed does not work in reverse direction
6		'4,+5d'					This matches line 4 in the file, deletes that line, continues to delete the next five lines, and then ceases its deletion and prints the rest
7		'2,5!d'					This deletes everything except starting from 2nd till 5th line
8		'1~3d'					This deletes the first line, steps over the next three lines, and then deletes the fourth line. Sed continues to apply this pattern until the end of the file.
9		'2~2d'					This tells sed to delete the second line, step over the next line, delete the next line, and repeat until the end of the file is reached
10		'4,10p'					Lines starting from 4th till 10th are printed
11		'4,d'					This generates the syntax error
12		',10d'					This would also generate syntax error
Note:-
While using the p action, you should use the -n option to avoid repetition of line printing


##syntax 
$ sed <action or option > filename
		or
$ <command name> | sed <action or option > filename
##To see file content use this commands
$ cat, more, less, head, tail
##To print the 1st line in file
$ sed -n '1p' <filename>
##To print the 1st  and 5th line in file
$ sed -n '1p;5p' <filename>
$ sed -n '1p;5p' sudoers
##To print the last  line in file
$ sed -n '$p' <filename>
$ sed -n '$p' sudoers
##To print from 1st  to 5th line in file
$ sed -n '1,5p' sudoers
##To print from 1st and last line in file
$ sed -n '1p;$p' <filename>
Note:-
     1. ;--> means and(1 and 4) line 
	 2. ,--> means from <somenumber> to <somenumber> line
	 3. $--> means last line
	 4. !-->means exculde the given line and display remaining 
##To print the line number randomly 
$ sed -n '1,3p;5p;7,9p;13,$p' <filename>
$ sed -n '1,3p;5p;7,9p;13,$p'  sudoers
###############Search and replace the string############
Notes:-
1.On the Screen replace and dsiplay
2.After the replace in original file.
Syntax:-
$ sed 's/searching word/replace word/' <filename>

##Temparory find, replace and display word in all line of  the filename
$ cat  sudoers  | grep dhana| sed 's/mahesh.shetty/dhanapal.ikt/g'  | grep dhanapal.ikt
## Temparory find, replace and display word in particular lines from 2 to 10 of  the filename
$ cat  dhana | grep sai | sed '4,9s/sai/saikumar/gI'  | grep saikumar
	 -g ---global replacement
	 -i or I --- for case senstive letter
##Temparory  comment in paticular line in the file
$ sed '3s/^/#/g' dhana
	 -g ---global replacement
## Temparory  comment in all lines in the file
$ sed 's/^/#/g' dhana
##To chanage the first line only[specific word & line]
$sed '1s/root/admin/' user.txt
##permanently to replace a word or comment or uncomment in the all  lines of the file.
$ sed  -i 's/^/#/g'  dhana
#permanently comment in paticular line in the file
$ sed  -i '3s/^/#/g' dhana
##Repalcing from 'nth' ocurrence to all occurrence in a line  of the file.
$ sed 's/root/Admin/2g' user.txt
##Repalcing string on a range of lines of the file
$ cat  dhana | grep sai | sed -i '4,9s/sai/saikumar/gI'  | grep saikumar
##Repalcing the nth occurance of a pattern in a file 
$ sed 's/root/admin/2' <filename>
Note:- by default the sed command repalces the first occurrence of the pattern in each line and it wont replace the second third...occurrence in the line.
##Repalcing on a lines which matches a pattern
$ sed '/nologin/ s/sbin/bin/' user.txt
##multiple pattern strings
$ cat user.txt | sed 's/root/admin/g; s/shutdown/reboot/gi'  
##To add a line after string 
$sed '/root/a "Welcome to cn technologies"' user.txt
##To add a line after  5 lines given a string
$ sed '5a "welcome to cn technologies"' user.txt
##Add line before a matche
$ sed '/ftp/i Welcome to cn technologies'  user.txt
$ sed '3i welcome to cn technologies' user.txt
##To chanage a line[replace]
$ sed 'ftp/c  welcome to cn technologies' user.txt
##To change a line in to particular line
$ sed '3c welcome to cn technologies' user.txt
##To space into one line to another line[blank line]
$ sed  G users.txt
	 G---Block lines
##Two blank lines insert
$ sed 'G;G' user.txt
##To 
##To add the comment in the line number
$ sed '7s/^/#' selinux.txt 
$ sed '7s/^/#' selinux.txt
##To uncomment i
##To delete the all blank lines for the file
$ sed '/^$/d' user.txt
##To delete the particular line in the file.
$ sed -i '5,7d' <filename>
##To delete all blank lines 
$ sed -i  '/^$/d' <filename>
$ sed -i  '/^$/d' <filename>
##To Delete a last line
$ sed '$d' filename.txt
##To Delete pattern matching line
$ sed '/pattern/d' filename.txt
$ sed '/abc/d' filename.txt
##Insert one blank line after each line   
$ sed G filename.txt
##Delete blank lines and insert one blank line after each line  
$ sed '/^$/d;G' filename.txt
## Delete blank Lines  
$ sed '/^$/d' filename.txt
##Delete empty lines or those begins with “#”   
$ sed -i '/^#/d;/^$/d' a.txt
##Print the line with ftp word 
$ sed -n 'ftp/p' filename.txt

##########
1.To Delete a particular line say n in this example
Syntax:
$ sed 'nd' filename.txt
Example:
$ sed '5d' filename.txt
2. To Delete a last line
Syntax:
$ sed '$d' filename.txt
3. To Delete line from range x to y

Syntax:
$ sed 'x,yd' filename.txt
Example:
$ sed '3,6d' filename.txt
4. To Delete from nth to last line

Syntax:
$ sed 'nth,$d' filename.txt
Example:
$ sed '12,$d' filename.txt
5. To Delete pattern matching line
Syntax:
$ sed '/pattern/d' filename.txt
Example:
$ sed '/abc/d' filename.txt



