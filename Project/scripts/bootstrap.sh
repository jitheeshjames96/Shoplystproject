#!/bin/bash

# Update and install required tools for AL2023
echo "Started DB script" > /tmp/rds-bootstrap-status.txt
dnf update -y && echo "Update triggered" >> /tmp/rds-bootstrap-status.txt 
sudo dnf install -y mariadb105 && echo "Mysql Installed" >> /tmp/rds-bootstrap-status.txt

# Input Parameters
DBSecretARN=$1
DBEndpoint=$2

# Fetch secret values from AWS Secrets Manager
SECRET_JSON=$(aws secretsmanager get-secret-value --secret-id "$DBSecretARN" --query SecretString --output text)
DBUSER=$(echo "$SECRET_JSON" | jq -r .username) 
DBPASS=$(echo "$SECRET_JSON" | jq -r .password)

echo "User : $DBUSER" > /tmp/rds-bootstrap-status.txt
echo "Password  : $DBPASS" > /tmp/rds-bootstrap-status.txt
echo "Fetched secret : $SECRET_JSON" > /tmp/rds-bootstrap-status.txt
# Create schema and data
mysql -h "$DBEndpoint" -u"$DBUSER" -p"$DBPASS"
echo "MySQL Connected" > /tmp/rds-bootstrap-status.txt
