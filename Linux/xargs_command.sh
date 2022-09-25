#######xargs command######
xargs command is used when we combined with other command.
we use "(|)" pipe to pass the output to the "xargs" command
		or
xargs is a great command that reads streams of data from standard input, then generates and executes command lines; meaning it can take output of a command and passes it as argument of another command. If no command is specified, xargs executes echo by default.
You many also instruct it to read data from a file instead of stdin.
		or 
The xargs command supplies arguments to a target command by reformatting the data received through stdin.
By default, xargs will execute the echo command. 
In manyrespects, the xargs command is similar to the actions performed by the find commands -exec option:
xargs options:
-0 : input items are terminated by null character instead of white spaces
-a file : read items from file instead of standard input
–delimiter = delim : input items are terminated by a special character
-E eof-str : set the end of file string to eof-str
-I replace-str : replace occurrences of replace-str in the initial arguments with names read from standard input
-L max-lines : use at-most max-lines non-blank input lines per command line.
-p : prompt the user about whether to run each command line and read a line from terminal.
-r : If the standard input does not contain any nonblanks, do not run the command
-x : exit if the size is exceeded.
–help : print the summary of options to xargs and exit
–version : print the version no  of xargs and exit

##Converting multiple lines of input to a single-line output:
Xargs default echo command can be used to convert multiple-line input to single-line text, like this:
$ cat example.txt # Example file
 1 2 3 4 5 6
 7 8 9 10
 11 12
 $ cat example.txt | xargs
 1 2 3 4 5 6 7 8 9 10 11 12
##Converting single-line into multiple-line output:
The -n argument to echo limits the number of elements placed on each command line invocation. 
This recipe splits the input into multiple lines of N items each:
$ cat example.txt | xargs -n 3
 1 2 3
 4 5 6
 7 8 9
 10 11 12
##We can define the delimiter used to separate arguments. 
To specify a custom delimiter for input, use the -d option:
$ echo "split1Xsplit2Xsplit3Xsplit4" | xargs -d X
split1 split2 split3 split4
In the preceding code, stdin contains a string consisting of multiple X characters.
We define X to be the input delimiter with  the -d option.
#Using -n along with the previous command, we can split the input into multiple lines of two words each as follows:
$ echo "splitXsplitXsplitXsplit" | xargs -d X -n 2
split split
split split
##Using xargs with find
The xargs and find command can be combined to perform tasks. However, take care to combine them carefully. 
Consider this example:
$ find . -type f -name "*.txt" -print | xargs rm -f
##Use the print0 option of xargs to produce an output delimited by the null character ('\0'); you use find output as Xargs input.
This command will find and remove all .txt files and nothing else:
$ find . -type f -name "*.txt" -print0 | xargs -0 rm -f
##counting the number of lines of C code in a source code directory
At some point, most programmers need to count the Lines of Code (LOC) in their C program files The code for this task is as follows:
$ find source_code_dir_path -type f -name "*.c" -print0 | xargs -0 wc -l