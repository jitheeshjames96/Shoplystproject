#!/bin/bash

# Update and install required tools for AL2023
dnf update -y
dnf install -y mysql jq aws-cli

# Input Parameters
SECRET_ARN=$1
RDS_ENDPOINT=$2

# Fetch secret values from AWS Secrets Manager
SECRET_JSON=$(aws secretsmanager get-secret-value --secret-id "$SECRET_ARN" --query SecretString --output text)
DBUSER=$(echo "$SECRET_JSON" | jq -r .username)
DBPASS=$(echo "$SECRET_JSON" | jq -r .password)

# Create schema and data
mysql -h "$RDS_ENDPOINT" -u"$DBUSER" -p"$DBPASS" <<EOF
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
