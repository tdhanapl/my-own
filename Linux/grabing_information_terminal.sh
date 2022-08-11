########Grabbing information about the terminal##########
While writing command-line shell scripts, we often need to manipulate information about the current terminal, such as the number of columns, rows, cursor positions, masked password fields, and so on. 
This recipe helps in collecting and manipulating terminal settings.
#Getting ready
The tput and stty commands are utilities used for terminal manipulations.
Here are some capabilities of the tput command:
#Return the number of columns and rows in a terminal:
$ tput cols
$ tput lines
#Return the current terminal name:
$ tput longname
#Move the cursor to a 100,100 position:
$ tput cup 100 100
#Set the terminal background color:
$ tput setb n
#The value of O can be a value in the range of 0 to 7
Set the terminal foreground color:
$ tput setf n
#The value of O can be a value in the range of 0 to 7
Some commands including the common color ls  may reset the foreground and background color.
#Perform start and end underlining:
$ tput smul
$ tput rmul
#To delete from the cursor to the end of the line, use the following command:
$ tput ed
A script should not display the characters while entering a password. The
following example demonstrates disabling character echo with the stty
command:
 #!/bin/sh
 #Filename: password.sh
 echo -e "Enter password: "
 # disable echo before reading password
 stty -echo
 read password
 # re-enable echo
 stty echo
 echo
 echo Password read.
The -echo option in the preceding command disables the output to the terminal, whereas echo enables output