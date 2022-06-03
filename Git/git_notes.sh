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
##To commit file from working area to staging area or index area 
$ git add * or .
	--it commit all file to index area
$ git add file1
	-- it commit particular  file1 to index area
## To commit file from staging area to local repository
$ git commit -m "this fist commit"
##To push to our  git hub
$ git push --all
	or 
$ git push origin main
##To push particular file to remote repository
$ git push origin main file1
##To know how many commit we did
$ git  log	
##To pull file from remote repository(github) to local repository
$ git pull origin main
	or 
$ git pull --all 	
	--git pull = git fetch+ git merge
It does two thing first fetch modified commit and merged into the previous file commit-1
##To fetch file from remote repository(github) to local repository
$ git fetch origin main
	or 
$ git fetch --all
It is only  fetch modified commit and  not merged into the previous file commit-1. We have to merged by command again the file
##To view current branch 
$ git status 
* main -->present working branch
  task
##what is Branch
To provide isolate enviroment  for developer to build the source code
## To create branch 
$ git branch feature1
$ git branch feature2
##To swtich to another branch
$ git checkout  feature1
##To merge from feature1 branch to main branch
$ git merge feature1  main
##To delete branch
$ git branch -d feature1
$ touch newfile
$ git add *
$ git commit -m "add file "
Note:-
     We can not delete the feature2 while  we working on same branch(feature2). 
	 if you want to delete the feature2 branch then swtich to another branch and try to delete the feature2 branch.
# swtich to main branch
$ git checkout main
#Now try delete the feature2
$ git 	delete -d feature2
Note:- 
 error= The branch not full merged, if  you are sure to delete it, then run "git branch -D feature2"
$ git branch -D feature2
##To push local repository to remote remote(github)
$ git  branch feature3
$ vim file1.txt
this  branch feature3
:wq
$ git add *
$ git commit -m "create feature3"
$ git push origin feature3 ##feature3=branch name
##To check remote(github) branch
$ git branch -r
##To merge from feature3 branch to main branch
$ git branch
* main-->we present in main branch
 feature3
$ git merge feature3 
-- we are merge feature3 to main feature3
Note:- I want merge all my changes from feature3 to main branch but in company we will not merge directly.
       Before merge our code we need get code reviewed  or requried approval by our team lead or manager then only  we can merge our code from feature3 to main branch.
$	   
      