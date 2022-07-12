##Prerequisites
To follow this tutorial you will need:
1. The Terraform CLI (1.2.0+) installed.
2. The AWS CLI installed.
3. AWS account and associated credentials that allow you to create resources.

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

Open main.tf in your text editor, paste in the configuration below, and save the file.
$ vim main.tf
provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
:wq
Note:-
Hard-coded credentials are not recommended in any Terraform configuration and risks secret leakage should this file ever be committed to a public version control system.
## set credentials in Environment Variables
Credentials can be provided by using the AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and optionally AWS_SESSION_TOKEN environment variables. The region can be set using the AWS_REGION or AWS_DEFAULT_REGION environment variables.
For example:
provider "aws" {}
$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="asecretkey"
$ export AWS_REGION="us-west-2"
$ terraform plan

##Initialize the project.
$ terraform init

##Format and validate the configuration.
Format your configuration. Terraform will print out the names of the files it modified, if any. In this case, your configuration file was already formatted correctly, so Terraform wont return any file names.
$ terraform fmt
Validate your configuration. The example configuration provided above is valid, so Terraform will return a success message.
$ terraform validate
Success! The configuration is valid.

##Create infrastructure
Apply the configuration now with the terraform apply command. Terraform will print output similar to what is shown below. We have truncated some of the output to save space.
$ terraform apply

##Inspect state
When you applied your configuration, Terraform wrote data into a file called terraform.tfstate. Terraform stores the IDs and properties of the resources it manages in this file, so that it can update or destroy those resources going forward.
The Terraform state file is the only way Terraform can track which resources it manages, and often contains sensitive information, so you must store your state file securely and restrict access to only trusted team members who need to manage your infrastructure. In production, we recommend storing your state remotely with Terraform Cloud or Terraform Enterprise. Terraform also supports several other remote backends you can use to store and manage your state.
Inspect the current state using terraform show.
$ terraform show