######cat command#########
#If you need to remove the extrablank lines, use the following syntax:
$ cat -s file
#Line numbers
The cat command -n flag prefixes a line number to each line. Consider this example:
$ cat lines.txt
line
line
line
$ cat -n lines.txt
 1 line
 2 line
 3 line
