#########################################Git ################################
##VCS(version control systems)
1.Track the changes
2.Coleberative Development
3.Revert the changes
4.Who and When changes are made

##Types of VCS
1.Local VCS
2.Centralized VCS ----subversion
3.Distributed VCS ----Gitlab, Github, Bitbucket

## security on branches rules
https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/defining-the-mergeability-of-pull-requests/managing-a-branch-protection-rule

##git branching strages
master(production code which is  stable)
					|______________ 
					               |
							 development(pre-poduction code)
                                   |___________ 
								               |
											 feature(when we are assign with new feature to add-on then we  create branch from development branch) 
												|___________
															|
									#not using #release(it support to release preparation  new  production release) 
														     |___________
																		 |
																		hot-fix/bug-fix  (it is just patch  to production release, we create branch from master branch)	
                 
#########git commands####
#To check git vsersion
$ git --version
x.X.X
major.minor.hostfix

##Add the our username and gamil to git 
$ git config --global user.name "dhanapal"
$ git config --global user.email "dhanapal@gmail.com"

##To check username and email information
$ git config --list

##git configuration file
#It is present in 3 level
1.user level
2.system level
3.gobal level

##To change normal file to repository file 
$ mkdir test-git
$ cd test-git
$ git init .
	--we need enter in that particular folder then initalize it.

##How to know current directory is repository or not
#go that folder then ll -al
	--here dispaly .git folder

##To check current branch 
$ git branch 
##To verfiy remote  url of the repository 
$ git remote -v
#
#To check current status of  repository
$ git status
	--here dispaly file in untrack

##To commit file from working area to staging area or index area 
$ git add * or .
	--it commit all file to index area
$ git add file1
	-- it commit particular  file1 to index area
#
# To commit file from staging area to local repository
$ git commit -m "this fist commit"

##To push to our  git hub
$ git push --all
	or 
$ git push origin main

##To push particular file to remote repository
$ git push origin main file1

##To know how many commit we did
$ git  log	
	or 
$ git log --oneline  -->
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

##what is Branch
To provide isolate enviroment  for developer to build the source code

## To create branch 
$ git branch feature1
$ git branch feature2

##To swtich to another branch
$ git checkout  feature1

## To create branch and checkout at a time.
$ git checkout -b feature2
#To check branch status
$ git status

##To merge from feature1 branch to main branch
$ git merge feature1  main
##To delete branch
$ git branch -d feature1
$ touch newfile
$ git add *5
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
note: 
-D or --delete --force
##To push from local repository to remote repository of feature3 branch (github)
$ git  branch feature3
$ vim file1.txt
this  branch feature3
:wq
$ git add *
$ git commit -m "create feature3"
$ git push origin feature3 ##feature3=branch name
##To check remote(github) branch
$ git branch -r 

##To delete remote repository branch
$ git push origin -d feature3

##To merge from feature3 branch to main branch
$ git branch
* main-->we present in main branch
 feature3
$ git merge feature3 
-->we are merge from feature3 to main branch. 
Note:-
1.when you merge one branch to another branch Sometime merge conflict will occur.
 we  resolve the issue in two ways 1. manually and 2.git mergetool (tool)
2.I want merge all my changes from feature3 to main branch but in company we will not merge directly.
Before merge our code we need get code reviewed  or requried approval by our team lead or manager then only  we can merge our code from feature3 to main branch.

##when conflict occur then we can use  mergetool	 
$ git mergetool

##To rebase from feature3 branch to main branch
$ git branch
* main-->we present in main branch
 feature3
$ git rebase feature3 
-->we are merge feature3 to main 
$ git status 
-->After rebase here history or commit id will not create.

## To merge the particular	commit id from one branch to another branch
By using cheerypick we can merge the particular commit id from one branch to another branch
$ git cheerypick <commit id>
##To revert the last commit in github from cli
$ git revert HEAD
$ git push
now you check in github that it changed to previous commit.
## To recover the delete file in git 
Case 1:-
##you delete file but didn't commit(staging area) then follow below command.
$ git checkout -- delete.txt
	or 
$ git restore  delete.txt
Case 2:-
##you delete a file and commited the deletion 
$ git reset --hard HEAD~1
Note: 
1.Hard reset will delete file of the current commit and it go to previous commit stage. before take backup of current commited file.
2.create a new branch to perform the restoration, so you do not disturb your existing work
Case 3:- 
##You commited the deletion and then you did more commits.
$ git log --<filename>

##change or revert  from staging/index to  working directory  area of file.
$ git restore --staged file1.txt
Note:-Perviously it is in staging/index area after using above command it comes to working directory.
	  from here if you want Discard the change(currently it working directory) then you can do with this command "git restore 	<filename>"	
$ git restore 	<filename> or $ git checkout file1.txt
$ git restore file1.txt
Note:-After this it delete current modified in working directory of file.
##revert the chanage of files from local repository to staging area(reset ---soft)
If one file in local repository you want to that file from  local repository to staging area then use this command.
$ git reset --soft <commit id or latest commit>
#For latest commit 
$ git reset --soft HEAD~1
# revert with particular   commit id from local repository to staging area(reset ---soft)
$ git reset --soft 3f45
##revert the chanage of files from local repository to working directory(reset --mixed)
If one file in local repository you want to that file from  local repository to working area then use this command.
$ git reset --mixed <commit id or latest commit>
#For latest commit 
$ git reset --mixed HEAD~1
# revert with particular   commit id from local repository to working directory(reset --mixed)
$ git reset --mixed 3f45
##revert the chanage of files from local repository to delete the content of the particular commit and it will clean commit id history also(reset --hard)
$ git reset --hard <commit id or latest commit>
#For latest commit 
$ git reset --hard HEAD~1
# revert with particular   commit id from local repository to working directory(reset --hard)
$ git reset --hard 3f45
Note:
It will  move   files from local repository  to working area, remove the content  and  clean commit id also.

##Tagging the git
git tagging developer use this functionality to mark release point (v1.0, v1.1)
##adding tags before commit 
$ vim file1.txt
creating tagging
:wq!
$ git add *
$ git tag -a v1.0 -m "release the latest changes"
$ git commit -m "add tagging for git"
##To check git tag version
$ git tag
	--here dispaly version
#To know the tag full details
$ git show v1.0
#To push the tag to remote repository
$ git push origin v1.0
#To assgin tag for after commit or particular commit id 
$ git tag v1.5 <commit id>
$ git tag v1.5 3f45
#To push all tags to remote repository
$ git push origin --tags
#To delete the tag in our local repository
$ git tag -d v1.0
#To delete the all  tags in our local repository
$ git tag -d $(git tag -l)
#To delete the tags of remote repository
$ git  push origin -d v1.0
#To delete the all  tags of remote repository
$ git push origin -d $(git tag -l)

##git stash
stash meaning is store file(something) safely in a hidden place.
We can stashing  file if its in staging/index. If file is not in staging/index area then we can not stashing  file.
$ git stash save "add new file"
#To check stash  file list
$ git stash list
#Apply a Specific Stash
$ git stash apply stash@{0}
#Remove Stashed Changes
$ git statsh drop 
#Clear All Stashes
$ git statsh clear 

## git diff 
git diff command in Git is used to show the differences between different states of a Git repository.
#Compare Working Directory with Staging Area (Index)
$ git diff 
#Compare Staging Area (Index) with Last Commit
$ git diff --staged 
#Compare Two Commits
$ git diff  <commit-hash-1> <commit-hash-2>
#Compare a Commit with the Working Directory
$ git diff <commit-hash>
#Compare Branches
$ git diff <branch1> <branch2>
##To squash multiple commits into a single commit in Git?
 Use git rebase -i HEAD~n (where n is the number of commits to squash). In the interactive rebase, mark commits as "squash" to combine them into a single commit.
