############Sed command###########
##https://www.geeksforgeeks.org/sed-command-linux-set-2/
##https://www.geeksforgeeks.org/sed-command-in-linux-unix-with-examples/

#SED is Stand for  stream editor. with help of sed command we can perform these type of operations like
1. Search  and line print
2. Find and replace(substitution)
3. deletion line
4. Insertion anything before the line number. 
5. Appending anything after the line number.

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

##sed command works on the line numbers
$ syntax sed 'action' filename
##To see file content use this commands
$ cat, more, less, head, tail
##To print the 1st line in file
$ sed -n '1p' <filename>
##To print the 1st  and 5th line in file
$ sed -n '1p;5p' <filename>
$ sed -n '1p;5p' sudoers
##To print from 1st  to 5th line in file
$ sed -n '1,5p' sudoers
##To print from 1st and last line in file
$ sed -n '10p;$p' <filename>
Note:-
     1. ;--> means and(1 and 4) line 
	 2. ,--> means from <somenumber> to <somenumber> line
	 3. $--> means last line
##Temparory find, replace and display word in all line of  the filename
$ cat  sudoers  | grep dhana| sed 's/dhana/dhanapal.ikt/g'  | grep dhanapal.ikt
## Temparory find, replace and display word in particular lines from 2 to 10 of  the filename
$ cat  dhana | grep sai | sed '4,9s/sai/saikumar/gI'  | grep saikumar
##Temparory  comment in paticular line in the file
$ sed '3s/^/#/g' dhana
## Temparory  comment in all lines in the file
$ sed 's/^/#/g' dhana
##permanently to replace a word or comment or uncomment in the all  lines of the file.
$ sed  -i 's/^/#/g'  dhana
#permanently comment in paticular line in the file
$ sed  -i '3s/^/#/g' dhana
$ cat  dhana | grep sai | sed -i '4,9s/sai/saikumar/gI'  | grep saikumar
##To delete the particular line in the file.
$ sed -i '5,7d' <filename>
##To delete all blank lines 
$ sed -i  '/^$/d' <filename>
$ sed -i  '/^$/d' <filename>
##To Delete a last line
Syntax:
$ sed '$d' filename.txt
##To Delete pattern matching line
Syntax:
$ sed '/pattern/d' filename.txtghj
Example:
$ sed '/abc/d' filename.txt
##Insert one blank line after each line   
$ sed G filename.txt
##To insert two blank lines  
$ sed 'G;G' filname.txt
##Delete blank lines and insert one blank line after each line  
$ sed '/^$/d;G' filename.txt
## Delete blank Lines  
$ sed '/^$/d' filename.txt
##Delete empty lines or those begins with “#”   
$ sed -i '/^#/d;/^$/d' a.txt

