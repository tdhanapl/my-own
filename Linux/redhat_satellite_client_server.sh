######configure  redhat satellite client server###
##To configure a Red Hat Satellite client server, follow these steps:
1. Install the Red Hat Satellite client package on the server:
$ yum install katello-ca-consumer-[Satellite-FQDN]-[ORG-ID]-1.0-1.noarch.rpm
Replace [Satellite-FQDN] with the fully qualified domain name of your Satellite server and [ORG-ID] with your organization ID.

2.Register the client server with the Satellite server:
$ subscription-manager register --org=[ORG-ID] --activationkey=[ACTIVATION-KEY]
Replace [ORG-ID] with your organization ID and [ACTIVATION-KEY] with the activation key provided by the Satellite server.

3.Enable the required repositories on the client server:
$ subscription-manager repos --enable=[REPO-ID1],[REPO-ID2],...
Replace [REPO-ID1], [REPO-ID2], etc., with the repository IDs you want to enable.

4.Verify the registration status:
$ subscription-manager identity
This command should display information about the registered system.

5.Install the necessary packages and updates:
# yum update
This will ensure that the client server has the latest packages and updates from the Satellite server.

6.Configure the client to use the Satellite server for package installations and updates. Edit the /etc/yum.repos.d/redhat.repo file and update the baseurl parameter to point to your Satellite server:
baseurl=https://[Satellite-FQDN]/pulp/repos/[REPO-ID]/content/dist/rhel/server/7/7Server/$basearch/os
Replace [Satellite-FQDN] with the fully qualified domain name of your Satellite server and [REPO-ID] with the repository ID you want to use.
#Restart the httpd service:
$ systemctl restart httpd
Test the client-server connectivity by running the following command:
$ yum repolist
You should see a list of enabled repositories from the Satellite server.

###url
https://www.linuxsysadmins.com/register-a-linux-client-with-foreman/