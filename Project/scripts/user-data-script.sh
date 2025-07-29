#!/bin/bash
echo "Started UserData script" > /tmp/userdata-status.txt
dnf install -y nginx && echo "Nginx installed" >> /tmp/userdata-status.txt
systemctl start nginx && echo "Nginx started" >> /tmp/userdata-status.txt
systemctl enable nginx && echo "Nginx enabled" >> /tmp/userdata-status.txt

aws s3 cp s3://codebuildjitheesh/Project/scripts/index.html /usr/share/nginx/html/index.html && echo "Index.html file updated to nginx location" >> /tmp/userdata-status.txt

systemctl status nginx > /var/log/nginx-status.log

systemctl restart nginx

: <<'COMMENT'
# Update and install required tools for AL2023
 echo "Started DB script" > /tmp/rds-bootstrap-status.txt
 dnf update -y && echo "Update triggered" >> /tmp/rds-bootstrap-status.txt 
 sudo dnf install -y mariadb105 && echo "Mysql Installed" >> /tmp/rds-bootstrap-status.txt

# # Input Parameters
 DBSecretARN=$1
 DBEndpoint=$2

# # Fetch secret values from AWS Secrets Manager
 SECRET_JSON=$(aws secretsmanager get-secret-value --secret-id "$DBSecretARN" --query SecretString --output text)
 DBUSER=$(echo "$SECRET_JSON" | jq -r .username) 
 DBPASS=$(echo "$SECRET_JSON" | jq -r .password)

 echo "User : $DBUSER" > /tmp/rds-bootstrap-status.txt
 echo "Password  : $DBPASS" > /tmp/rds-bootstrap-status.txt
 echo "Fetched secret : $SECRET_JSON" > /tmp/rds-bootstrap-status.txt

 # Create schema and data
 mysql -h "$DBEndpoint" -u"$DBUSER" -p"$DBPASS"
'COMMENT'


