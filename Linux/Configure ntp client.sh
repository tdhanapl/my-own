###configure own  ntp client with our ntp server in linux##
To configure your own NTP (Network Time Protocol) client to sync with your NTP server in Linux, follow these steps:
1.Install NTP client:
Ensure that the NTP client software is installed on your Linux system. The package name may vary depending on the Linux distribution you are using. For example, on Ubuntu or Debian, you can install the NTP client using the following command:
$ sudo apt-get install ntp
2. Locate the NTP configuration file:
The NTP client configuration file is typically located at /etc/ntp.conf. Open the file using a text editor with root privileges.

3. Configure the NTP server:
In the configuration file, locate the section that defines the NTP servers to synchronize with. You will typically find lines starting with "server". Comment out or remove any existing server entries and add the following line to specify your NTP server's IP address or hostname:
$vim /etc/ntp.conf 
server your-ntp-server
Replace your-ntp-server with the IP address or hostname of your NTP server.

4. Save and close the configuration file.

5. Restart the NTP service:
Restart the NTP service for the changes to take effect. The command to restart the service may vary based on your Linux distribution. For example, on Ubuntu or Debian, you can use the following command:
$ sudo systemctl restart ntp

6. Verify synchronization:
After restarting the NTP service, wait for a few minutes and then check the synchronization status with your NTP server. Use the following command to view the NTP status:
$ ntpq -p
The output will show the list of NTP servers being synchronized with. Look for the line that corresponds to your NTP server. If the refid column displays your NTP server's IP address or hostname and the st column shows a value of "2" or lower, it means that your NTP client is successfully synchronizing with the server.

That's it! Your Linux system should now be synchronized with your own NTP server. It will automatically adjust the system time to match the time provided by the NTP server, ensuring accurate timekeeping.