#!/bin/bash
setenforce 0 
yum install httpd -y #helps you to install the https services
systemctl enable httpd #helps you to run the https services
echo "hi Team welcome to apache service" > /var/www/html/index.html 
systemctl restart httpd #helps you restart the https services 
getenforce # To Enforce the changes
