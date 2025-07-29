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

# Create schema and data
mysql -h "$DBEndpoint" -u"$DBUSER" -p"$DBPASS" <<EOF
CREATE DATABASE IF NOT EXISTS shopalystdb;
USE shopalystdb;
CREATE TABLE IF NOT EXISTS products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  price DECIMAL(10,2),
  category VARCHAR(50)
);
INSERT INTO products (name, price, category) VALUES
  ('Apple iPhone 15', 799.99, 'Electronics'),
  ('Samsung Galaxy S24', 749.00, 'Electronics'),
  ('MacBook Air M3', 1299.50, 'Computers');
EOF

echo "MySQL Connected" > /tmp/rds-bootstrap-status.txt
