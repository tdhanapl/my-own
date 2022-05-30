#########git #
##VCS
=============
1.Track the changes
2.Coleberative Development
3.Revert the changes
4.Who and When changes are made

Types of VCS
=====
1.Local VCS
2.Centralized VCS ----subversion
3.Distributed VCS ----Gitlab, github, Bitbucket
#########git command####
#To check git vsersion
$ git --vsersion
##Add the our username and gamil to git 
$ git config --global user.name "dhanapal"
$ git config --globall user.email "dhanapal703278@gmail.com"
##To check username and gmail information
$ git config --list
###git configuration file
#It is present in 3 level
1.user level
2.system level
##To change normal file to repository file 
$ mkdir test-git
$ cd test-git
$ git init .
	--we need enter that particular folder then initalize it.
##How to know current directory is repository or not
#go that folder then ll -al
	--here dispaly .git folder

