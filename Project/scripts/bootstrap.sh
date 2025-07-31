#!/bin/bash

# Update and install required tools for AL2023
echo "Started DB script"
dnf update -y && echo "Update triggered"
sudo dnf install -y mariadb105 && echo "Mysql Installed"

# Input Parameters
DBSecretARN=$1
DBEndpoint=$2

echo "Secret Arn : $DBSecretARN"
echo "DBEndpoint : $DBEndpoint"

# Fetch secret values from AWS Secrets Manager
SECRET_JSON=$(aws secretsmanager get-secret-value --secret-id "$DBSecretARN" --query SecretString --output text)
DBUSER=$(echo "$SECRET_JSON" | jq -r .username) 
DBPASS=$(echo "$SECRET_JSON" | jq -r .password)

echo "User : $DBUSER"
echo "Password  : $DBPASS"
echo "Fetched secret : $SECRET_JSON"
# Create schema and data
mysql -h "$DBEndpoint" -u"$DBUSER" -p"$DBPASS"
echo "MySQL Connected"
