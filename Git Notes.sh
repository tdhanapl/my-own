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
$ git config --global user.email "dhanapal703278@gmail.com"
##To check username and gmail information
$ git config --list
###git configuration file
#It is present in 3 level
1.user level
2.system level
3.gobal level
##To change normal file to repository file 
$ mkdir test-git
$ cd test-git
$ git init .
	--we need enter that particular folder then initalize it.
##How to know current directory is repository or not
#go that folder then ll -al
	--here dispaly .git folder
##To check current branch 
##To verfiy new url
$ git remote -v
##To check current status od repository
$ git status
	--here dispaly file in untrack
##To commit file to staging area or index area 
$ git add * or .
	--it commit all file to index area
$ git add file1
	-- it commit particular  file1 to index area
## To commit file from staging area to local repository
$ git commit -m "this fist commit"
##To push to our  git hub
$ git push --all 	