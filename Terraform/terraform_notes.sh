##Prerequisites terraform
To follow this tutorial you will need:
1. The Terraform CLI (1.2.0+) installed.
2. The AWS CLI installed.
3. AWS account and associated credentials that allow you to create resources.
##good content  url
https://medium.com/appgambit/provisioning-a-jenkins-server-on-aws-with-terraform-bf04a6a6ef7f
https://medium.com/@awsyadav/automating-ecs-ec2-type-deployments-with-terraform-569863c60e69

##Installation of terraform in linux of rhel/centos
$ sudo yum install -y yum-utils
$ sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
$ sudo yum -y install terraform

##Installed the AWS CLI.
$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
$ unzip awscliv2.zip
$ ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
#set environment variable
$ vim /etc/profile.d/aws.sh
#!/bin/bash
export PATH=$PATH:/usr/local/bin/
:wq!
$ bash
$ aws --version

##AWS account and associated credentials that allow you to create resources.
#To create your access key ID and secret access key
1.Open the IAM console at https://console.aws.amazon.com/iam/.
2. On the navigation menu, choose Users.
3.Choose your IAM user name (not the check box).
4.Open the Security credentials tab, and then choose Create access key.
5.To see the new access key, choose Show. Your credentials resemble the following:
6.Access key ID: AKIAIOSFODNN7EXAMPLE
7.Secret access key: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
8.To download the key pair, choose Download .csv file. Store the .csv file with keys in a secure location.

##Write configuration
The set of files used to describe infrastructure in Terraform is known as a Terraform configuration. You will write your first configuration to define a single AWS EC2 instance.
Each Terraform configuration must be in its own working directory. 
Create a directory for your configuration.
$ mkdir learn-terraform-aws-instance
$ cd learn-terraform-aws-instance
$ touch main.tf

#Open main.tf in your text editor, paste in the configuration below, and save the file.
$ vim main.tf
provider "aws" {
  region     = "ap-south-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
#resource "<provider>_<resource_type>" "name" {
Note:-Hard-coded credentials are not recommended in any Terraform configuration and risks secret leakage should this file ever be committed to a public version control system.

##Adding AWS credentials
# aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EdsdskXAMPLE 
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDEhdNG/bPxRfiCYEXAMPLEKEY
Default region name [None]: ap-south-1
Default output format [None]:
    or
## set credentials in the .aws configuration files
  
[root@ansible .aws]# vim credentials
[default]
aws_access_key_id =  AKIAIOSFODNNee7EXAMPLE 
aws_secret_access_key = wJalrXUtneeFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

:wq!
[root@ansible .aws]# vim  config
[default]
region = ap-south-1

:wq!

##Strings and Templates
##url for references of string and templates
https://www.terraform.io/language/expressions/strings

### variable types
1.string 
variable "ami_id" {
  type        =  string
  default     = "ami-06a0b4e3b7eb7a300"
}
#call string type varible in main.tf file
instance_type = var.ami_id#varibale type string

#2.list
variable "instance_type" {
  description = "ec2 instance_type"
  type        = list
  #default    = t2.micro
  default     = ["t2.micro","t2.small","t2.medium"]
}
#call list type varible in main.tf file
instance_type = var.instance_type[0] #varibale type list

#3.map
variable "ami_image_id" {
  type        = map
  default     = {
    redhat = "ami-06a0b4e3b7eb7a300"
    amazon = "ami-079b5e5b3971bd10d"
	  ubuntu = "ami-068257025f72f470d"
  }
}
#call map type varible  in main.tf file
instance_type = var.ami_image_id.redhat #varibale type = map

##Terraform visualing exexution plan
#Install graphviz.x86_64 package
This guide let you learn how to install graphviz.x86_64 package:
$ sudo dnf makecache
$ sudo dnf install graphviz.x86_64

#Uninstall / Remove graphviz.x86_64 package
Please follow the step by step instructions below to uninstall graphviz.x86_64 package:
$ sudo dnf remove graphviz.x86_64
sudo dnf autoremove

##To create the terraform plan graphviz
$ terraform graph -Tsvg > graph.svg

##Initialize the project.
$ terraform init

##Show changes required by the current configuration
$ terraform plan

##Check whether the configuration is valid
Format your configuration. Terraform will print out the names of the files it modified, if any. In this case, your configuration file was already formatted correctly, so Terraform wont return any file names.
$ terraform fmt

##Check whether the configuration is valid
$ terraform validate
Success! The configuration is valid.

##Create or update infrastructure
Apply the configuration now with the terraform apply command. Terraform will print output similar to what is shown below. We have truncated some of the output to save space.
$ terraform apply

##Create or update infrastructure with auto-approve 
#If we use "--auto-approve" it will not ask for yes or no prompt
$ terraform apply --auto-approve 
##Show output values from your root module
syntax:-
$ terraform [global options] output [options] [NAME]
options:-

  -state=path      Path to the state file to read. Defaults to
                   "terraform.tfstate".

  -no-color        If specified, output wont contain any color.

  -json            If specified, machine readable output will be
                   printed in JSON format.

  -raw             For value types that can be automatically
                   converted to a string, will print the raw
                   string directly, rather than a human-oriented
                   representation of the value.
$ terraform output
##print specific  output with
$ terraform output <name>
$ terraform output vpc_idl

##Update the state to match remote systems
$ terraform  refresh

##update the new change to terraform code
$ terraform apply -refresh-only

## Show the current state or a saved plan
 Inspect the current state using terraform show.
$ terraform show
## To chheck Workspace  management
$ terraform workspace list

##Key pair generating in terraform coded
#First we need generate the public key using ssh-keygen
$ ssh-keygen
$ cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9pXjkBHlAHEI62Y/3hqXSeSYelfPFL7mZg+296hZgG5LNVnP2DKfouA8wy3tX21RsaYJcPHNlwGSSv2QJVZoxtPdJbyDDxMagWkxuBr3HbXfvq43C9f/mR7ZOSRijVGUbOTb+oRR7xyZ9RI7+ohdDoQUOPYVLd+l0L/0WdHe4j/zCA4cetabq5LFEt8+nxDQ6Nm3kLscUK7N0y5BLiJYUjVroGAq/i+oBSTpxRum6DWF1xC4+1cFrO0ihvq+Q+R3C0y/OVe97/nUxXexftgkFIgZQ9A4sX/5f93nQPKqv+/BaVzbwAFhVrDEdz4ih/OL7XVoS8UsXRHiU51/rjFF0RtwDChcjow32SS0UgmbQhyx6Fd1ai7qF8iXtQXvHIxDrxScHj1XRhM6KeIfUGci6Xx8WEzoFVtGqp7XzAtHwSjNWu4fYZXJ+V+Z/f/bpEvOgtvT0Z1D1J8QtTHTTyoXNJiySv2j2SOS2M1K5D7w2z8svUGti3jzsURmE1T/SvPk= root@ansible.cntech.local
It will create the public and private key 
#Now in terraform  write code  for key pair
resoure "aws_key_pair" "terraform" {
  key_name = "terraform-key"
  public_key = <"here we need to add that public key">
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9pXjkBHlAHEI62Y/3hqXSeSYelfPFL7mZg+296hZgG5LNVnP2DKfouA8wy3tX21RsaYJcPHNlwGSSv2QJVZoxtPdJbyDDxMagWkxuBr3HbXfvq43C9f/mR7ZOSRijVGUbOTb+oRR7xyZ9RI7+ohdDoQUOPYVLd+l0L/0WdHe4j/zCA4cetabq5LFEt8+nxDQ6Nm3kLscUK7N0y5BLiJYUjVroGAq/i+oBSTpxRum6DWF1xC4+1cFrO0ihvq+Q+R3C0y/OVe97/nUxXexftgkFIgZQ9A4sX/5f93nQPKqv+/BaVzbwAFhVrDEdz4ih/OL7XVoS8UsXRHiU51/rjFF0RtwDChcjow32SS0UgmbQhyx6Fd1ai7qF8iXtQXvHIxDrxScHj1XRhM6KeIfUGci6Xx8WEzoFVtGqp7XzAtHwSjNWu4fYZXJ+V+Z/f/bpEvOgtvT0Z1D1J8QtTHTTyoXNJiySv2j2SOS2M1K5D7w2z8svUGti3jzsURmE1T/SvPk= root@ansible.cntech.local"
}
##Environment variables
$ Terraform loads variables in the following order, with later sources taking precedence over earlier ones:
1.Environment variables
2.The terraform.tfvars file, if present.
3.The terraform.tfvars.json file, if present.
4.Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
5.Any -var and -var-file options on the command line, in the order they are provided.
 (This includes variables set by a Terraform Cloud workspace.)

##terraform cloud login
#first generate the token in terraform cloud 
$ terraform login
	here paste the terraform token
# New to TFC? Follow these steps to instantly apply an example configuration:
$ git clone https://github.com/hashicorp/tfc-getting-started.git
$ cd tfc-getting-started
$ scripts/setup.sh
