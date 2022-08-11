#####grep(global regular experssion print)########
It used to search for a strong of characters in a specified file, when it finds a match, it prints.
##To display the specified string in the file
$ grep root /etc/passwd
Note:
It display entire line when given string is matched
##Print line numbers with ouput line
grep llows you to print line numbers along with printed lines which makes it easy to know where the line is in the file
$ grep -in root /etc/passwd
	 -i, --ignore-case         ignore case distinctions
	 -n ---line-numbers		   print line number with output lines
##To display only that string in that file not whole the line of that file:
$ grep -ino root /etc/passwd
	 -n, --line-number         print line number with output lines
	 -o, --only-matching       show only the part of a line matching PATTERN
##Print only a match count of
$ grep -c root /etc/passwd
	 -c, --count               print only a count of selected lines per FILE
##To print only the line with matching whole word
$ grep -nw root /etc/passwd

##To display the two or more mutiple specified word in the file
$ grep -niw -e 'root' -e 'kamal' -e 'dhanapal' /etc/passwd
	 -e, --regexp=PATTERN      use PATTERN for matching
	or 
$ grep -inE 'root|kamal|dhanapal' /etc/passwd
	 -E, --extended-regexp     PATTERN is an extended regular expression
##To display the string except  the matching string lines
$ grep -iEnv 'root|kamal|dhanapal' /etc/passwd
	 -v, --invert-match        select non-matching lines
##Print number of lines after match string
$ grep -in -A2  root /etc/passwd
     -A, --after-context=NUM   print NUM lines of trailing context
	 -A2, --word after 2 lines
	 -A3, --word after 3 lines
	 -An, --word after n lines
##Print number of lines before 
$ grep -B3 root /etc/passwd
	 -B, --before-context=NUM  print NUM lines of leading context
	 -B2, --word before 2 lines
	 -B3, --word before 3 lines
	 -Bn, --word before n lines
##Print number of lines after, before match string
$ grep -n -A3 -B3 root /etc/passwd
$ grep -ni -C3 root /etc/passwd
     -C, --context=NUM         print NUM lines of output context
     -NUM                      same as --context=NUM
##To display the line which is starting with specified string or word 
$ grep -ni root /etc/passwd
$ grep -ni '^root' /etc/passwd
##To display given string at the end of the line 
$ grep -i 'bash$' /etc/passwd
##To display a given string using a paticular file
$ vi user.txt
ftp
user1
kamal
:wq!
$ grep -nw -f user.txt /etc/passwd  
	 -f, --file=FILE           obtain PATTERN from FILE
##Search the given string from all the files(only files) in a directory 
$ grep -il book *.txt
##To search or diplay the recursev file in the string
$ grep -n  -R -i skel /etc/default/.*
	 -r, --recursive           like --directories=recurse
     -R, --dereference-recursive
                            likewise, but follow all symlinks
		 --include=FILE_PATTERN
                            search only files that match FILE_PATTERN
         --exclude=FILE_PATTERN
                            skip files and directories matching FILE_PATTERN
         --exclude-from=FILE   skip files matching any file pattern from FILE
         --exclude-dir=PATTERN directories that match PATTERN will be skipped
##Egrep(extended global regular experssion print###
$egrep -n 'root|bash' /etc/passwd
	or
$grep -E  -n 'root|bash|bin' /etc/passwd
Note: instead of using "-e" option grep -e 'root' -e 'bash' /etc/passwd
->"egrep" is equal to the "grep -E"
	 