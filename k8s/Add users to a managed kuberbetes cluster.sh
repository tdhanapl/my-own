######Add users to a managed kuberbetes cluster###
##Generate private key
$ openssl genrsa -out vikas.key 2048
##Generate the csr
$ openssl req -new -key vikas.key -out vikas.csr -subj "/CN=vikas/O=development" 

[ec2-user@ip-10-10-1-173 ~]$ ll
total 12
-rw-r--r--. 1 ec2-user ec2-user  187 May  2 19:21 csr.yaml
-rw-r--r--. 1 ec2-user ec2-user  915 May  2 19:16 vikas.csr
-rw-------. 1 ec2-user ec2-user 1704 May  2 19:13 vikas.key

[ec2-user@ip-10-10-1-173 ~]$ cat csr.yaml
apiversion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: vikas
spec:
  request:
  signername: kunernetes.io/kube-apiserver-client
  usages:
    - client auth

##create csr certificates
$ kubectl create -f csr.yaml

##now check for csr
$ kubectl  get certificatesigningrequests vikas
Note: here it will show pending csr

##now we need approve the csr
$ kubectl  certificate approve vikas or <csr certificate name>

##after approve csr now check for csr 
$ kubectl  get certificatesigningrequests vikas -oyaml

##now we need the this certificate to authenticate kuberbetes apiserver
$ echo LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ2F6Q0NBVk1DQVFBd0pqRU9NQXdHQTFVRUF3d0ZkbWxyWVhNeEZEQVNCZ05WQkFvTUMyUmxkbVZzYjNCdApaVzUwTUlJQklqQU5CZ2txaGtpRzl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUF5M0JyUjl5K09IdjU4MzdWCm4wV1dYdHBxcVhqRTQ4TFNVS0N2TU9xVmJiNkd4WUU5eTJWQXFUT3ZaUGZlZG85YldUTXlCWTkzN0xIWVFCdTMKSXladW8vaWduUUY0bjh3UHpiZzZSSWpzN0dqQ3FUOXNUbk1HdThtQUZkQUlLUDFUU2ZWbkpWYnB5UlBZZ1NXTgpVM3A4Vm1PN1dsZnpYYVdWQ1gyVmE0NHhaVm45RHpNQkc2dVBLbUdITVNENDBhbVpWUzJRVXcyakZ6Q1RsTlUxCjFYNGdvdUE3aWFudzZpZThvUnBZejN2Umd3eVlHd3RXUUYrL1h3MFFKS0pvQjE3SHBRWkN4ZFZuZjcxK3VjV2cKZmxXcElRSTZmQ1Bpb2ZBNSswVkdIMXdEc05qcDBiREdYbkpCVW9uZkVCczlqOWJOUG9OYmVrc0l5M2R6TVN1VwpOenA0YndJREFRQUJvQUF3RFFZSktvWklodmNOQVFFTEJRQURnZ0VCQUlualhxR21IczJrYjhzWWpBSjVkOWFICkUvaEt2Q0M2eFIzc2RXeGwxOW5manZ4MDUrMk1EVWVlRG96WndmVS93SWV4alhnb1hQdWtZNzQrU2xtcUliV04KeE9Obnd2WTlYa2pNL1hyb2xNYTdGMzVnRTEweEU4bjhDVnpIR3VqQnFiVUFhNVZoMjZRYnhOQWluNnBVT0habApKMXJvY3JnMkJocjB1R3JIZUlWa0hobzF0c1lUZE5aVXE4RXl5d1IxeHAyS1V3cXVpNndScjNFYkdPbzd5M0ExCis2aEhpTGJ3TnUvTVlyMUQ4WG5JNk5FblJrQkUyelM2ZnZvamdkWFpFZTFCNWFyY2lVc2gyMFBxNkZqNDFTYUcKaElzRVJkckNHNU1mMHhrd2h5dG1USkpTNVkxcTRaRG16ejQyVVM1S203STFLU3gweDAvQnlkZjVVaG14aVVnPQotLS0tLUVORCBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0K | base64 -d > vikas.crt

$ ll
total 16
-rw-r--r--. 1 ec2-user ec2-user 1408 May  2 19:25 csr.yaml
-rw-r--r--. 1 ec2-user ec2-user  915 May  2 19:43 vikas.crt
-rw-r--r--. 1 ec2-user ec2-user  915 May  2 19:16 vikas.csr
-rw-------. 1 ec2-user ec2-user 1704 May  2 19:13 vikas.key
[ec2-user@ip-10-10-1-173 ~]$ cat vikas.crt
-----BEGIN CERTIFICATE REQUEST-----
MIICazCCAVMCAQAwJjEOMAwGA1UEAwwFdmlrYXMxFDASBgNVBAoMC2RldmVsb3Bt
ZW50MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAy3BrR9y+OHv5837V
n0WWXtpqqXjE48LSUKCvMOqVbb6GxYE9y2VAqTOvZPfedo9bWTMyBY937LHYQBu3
IyZuo/ignQF4n8wPzbg6RIjs7GjCqT9sTnMGu8mAFdAIKP1TSfVnJVbpyRPYgSWN
U3p8VmO7WlfzXaWVCX2Va44xZVn9DzMBG6uPKmGHMSD40amZVS2QUw2jFzCTlNU1
1X4gouA7ianw6ie8oRpYz3vRgwyYGwtWQF+/Xw0QJKJoB17HpQZCxdVnf71+ucWg
flWpIQI6fCPiofA5+0VGH1wDsNjp0bDGXnJBUonfEBs9j9bNPoNbeksIy3dzMSuW
Nzp4bwIDAQABoAAwDQYJKoZIhvcNAQELBQADggEBAInjXqGmHs2kb8sYjAJ5d9aH
E/hKvCC6xR3sdWxl19nfjvx05+2MDUeeDozZwfU/wIexjXgoXPukY74+SlmqIbWN
xONnwvY9XkjM/XrolMa7F35gE10xE8n8CVzHGujBqbUAa5Vh26QbxNAin6pUOHZl
J1rocrg2Bhr0uGrHeIVkHho1tsYTdNZUq8EyywR1xp2KUwqui6wRr3EbGOo7y3A1
+6hHiLbwNu/MYr1D8XnI6NEnRkBE2zS6fvojgdXZEe1B5arciUsh20Pq6Fj41SaG
hIsERdrCG5Mf0xkwhytmTJJS5Y1q4ZDmzz42US5Km7I1KSx0x0/Bydf5UhmxiUg=
-----END CERTIFICATE REQUEST-----

