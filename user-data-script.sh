#!/bin/bash
echo "Started UserData script" > /tmp/userdata-status.txt
dnf install -y nginx && echo "Nginx installed" >> /tmp/userdata-status.txt
systemctl start nginx && echo "Nginx started" >> /tmp/userdata-status.txt
systemctl enable nginx && echo "Nginx enabled" >> /tmp/userdata-status.txt

aws s3 cp s3://codebuildjitheesh/Project/scripts/index.html /usr/share/nginx/html/index.html && echo "Index.html file updated to nginx location" >> /tmp/userdata-status.txt

systemctl status nginx > /var/log/nginx-status.log

systemctl restart nginx
