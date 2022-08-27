1)Top Command After Specific repetition:  With below command top command will automatically exit after 10 number of repetition.
$ top -n 10
options:-
PID 	Process ID
USER 	Owner of the process ie., which user executed that process
PR 		Dynamic Priority
NI 		Nice value, also known as base value
VIRT 	Virtual size of the task includes the size of processes executable binary
RES 	The size of RAM currently consumed by the task and not included the swap portion
SHR 	Shared memory area by two or more tasks
S 		Task Status
% CPU 	The % of CPU time dedicated to run the task and it is dynamically changed
% MEM 	The % of memory currently consumed by the task
TIME+ 	The total CPU time the task has been used since it started. + sign means it is displayed with hundredth of a second granularity. 
By default, TIME/TIME+ does not account the CPU time used by the tasks dead children
2) Display Specific User Process
$ top -u paras
3) Highlight Running Process in Top: Press ‘z‘ option in running top command will display running process in color which may help you to identified running process easily Z
4) Shows Absolute Path of Processes: Press ‘c‘ option in running top command, it will display absolute path of running pro Z 
5) Kill running process: You can kill a process after finding PID of process by pressing ‘k‘ option in running top command without exiting from top window as shown below. 
6) Sort by CPU Utilisation: Press (Shift+P) to sort processes as per CPU utilization. 
7) Shows top command syntax:
$ top -h 
8) Batch Mode : Send output from top to file or any other programs.
$ top -b
9) Secure Mode : Use top in Secure mode.
$ top -s
10) Command Line : The below command starts top with last closed state.
$ top -c
11) Delay time : It tells delay time between screen updates.
$ top -d seconds.tenths
###To known the cpu usage percentage only  with top command 
$ top -b -n 2 -d1 | grep -i "cpu(s)" | tail -n1 | awk '{print $2}'  | awk -F . '{print $1}'
	options:
	-F fs        --field-separator=fs
Ex:-
	 awk -F: '{ print $1 }' /etc/passwd
