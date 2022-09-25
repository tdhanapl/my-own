################################Chanage of Run level######################
Systemd is a modern init system for Linux: a system and service manager which is compatible with the popular SysV init system and LSB init scripts. It was intended to overcome the shortcomings of SysV init as explained in the following article.
The Story Behind ‘init’ and ‘systemd’: Why ‘init’ Needed to be Replaced with ‘systemd’ in Linux
On Unix-like systems such as Linux, the current operating state of the operating system is known as a runlevel; it defines what system services are running. Under popular init systems like SysV init, runlevels are identified by numbers. However, in systemd runlevels are referred to as targets.
In this article, we will explain how to change runlevels (targets) with systemd. Before we move any further, let’s briefly under the relationship between runlevels numbers and targets.
Run level 0 is matched by poweroff.target (and runlevel0.target is a symbolic link to poweroff.target).
Run level 1 is matched by rescue.target (and runlevel1.target is a symbolic link to rescue.target).
Run level 3 is emulated by multi-user.target (and runlevel3.target is a symbolic link to multi-user.target).
Run level 5 is emulated by graphical.target (and runlevel5.target is a symbolic link to graphical.target).
Run level 6 is emulated by reboot.target (and runlevel6.target is a symbolic link to reboot.target).
Emergency is matched by emergency.target.
How to View Current target (run level) in Systemd
When the system boots, by default systemd activates the default.target unit. It’s main work is to activate services and other units by pulling them in via dependencies.
#To view the default target, type the command below.
$ systemctl get-default 
graphical.target
#To set the default target, run the command below.
$ systemctl set-default multi-user.target  
#How to Change the target (runlevel) in Systemd
While the system is running, you can switch the target (run level), meaning only services as well as units defined under that target will now run on the system.
#To switch to runlevel 3, run the following command.
$ systemctl isolate multi-user.target 
#To change the system to runlevel 5, type the command below.
$ systemctl isolate graphical.target
