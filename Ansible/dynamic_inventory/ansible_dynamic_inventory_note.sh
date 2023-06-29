##########Ansible dynamic inventory#######
##Required package for dynamic inentory 
$ sudo yum install ansible-core python-pip python-devel 
## Now we need install boto and boto3
$ pip install boto

$ pip install boto3 
## install aws modules 
$ ansible-galaxy collection install amazon.aws

