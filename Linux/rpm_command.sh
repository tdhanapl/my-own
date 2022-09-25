#################rpm command##############
# rpm <options><package name>
 The options are, -i -----> install 
-v -----> verbose
-h -----> progress in hash codes ( in % )
-qi -----> query information about the package
-ql -----> list all package related files.
-qd ----> query about the document of the package
-qc -----> displays the configuration files for that package
-qa -----> query on all installed packages
-V -----> (capital V) to verify the package for repair that package
-R -----> list all dependent packages
--force -----> install the package forcefully
--nodeps -----> install the package without dependency (do not check the 
dependencies)
--last -----> all installed packages with date and time
Other useful rpm commands :
# rpm -ivh <package name> (to install the package)
# rpm -qa (to list all installed packages)
# rpm -qa <package name> (to check whether the package is installed or not)
# rpm -qa |wc -l (to count how many packages already 
installed)
# rpm -qa --last | less (to check last installed packages)
# rpmquery -qa (to list all the installed packages)
# rpm -qa |grep -i <package name> (to check the specified package is installed or not)
# rpm -ivh --test <package name> (to check the package consistency)
* If the installation status shows 100%, then the package is in good condition or consistent. But while 
showing 
 the hash progress if it shows any error, then the package is in inconsistent state.
# rpm -ivh finger* (to install the finger package)
# rpm -qa finger (to check whether the package is installed 
or not)
# finger <user name> (to check whether the installed package is working 
or not)
# rpm -e <package name> (to erase or remove or uninstall the package)
# rpm -evv <package name> (to remove the package in verbose mode)
# rpm --test -ivh (to test the package before installing ie., whether the 
package 
is suitable or not)
# rpm -qi <package name> (to see the details or information on the installed 
package)
# rpm -ql <package name> (to list all package related files)
# rpm -qlc <package name> (to list all the configuration files of that package)
# rpm -qd <package name> (to list all the document files of that package)
# rpm -ivh <package name> --force (to install the package forcefully)
# rpm -qR <package name> (to list the dependencies of that package)
# rpm -qip <package full name> (to display the package information before 
installation)
# which <command name> (to display the location of that command)
# rpm -qf <location of the command> (to check the package name for that command)
# rpm -V <package name> (to verify that package, ie., 100% package is there or 
not, if any files missed in that package, those are displayed 
as a list) 
# rpm -ivh <package name> --replacepkgs (to replace the missed files in that package)
# rpm -qp --changelog <package name> (displays all the changed logs like lat time, when the 
package is 
installed, .....etc.,)
# rpm -qp --scripts <package name> (to see the package installation scripts)
# rpm -K <package full name> (to see the package key)
# rpm -Uvh <package name> (to update the package)
* Update is over write the old version of the package. If any problems in new package, we cannot solve 
those issues. So, the better one is install that package as a fresh one (not update option).
* Update will look first the package is available in that system or not. If it is available, it will update that 
package otherwise it will install as fresh package.
# rpm -qRp <package name> (to check the dependency packages of that package before 
install)
# rpm -ivh <package name> --nodeps (to install the package without dependent packages)