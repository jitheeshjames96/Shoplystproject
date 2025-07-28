# Shoplystproject

🏗️ Local Project Structure

├── master.yaml
├── vpc.yaml
├── security.yaml
├── compute.yaml
├── rds.yaml
└── README.md



---


## Overview
This repository provides a modular, nested‑stack CloudFormation setup to deploy:
- Custom VPC with public/private subnets
- ALB + Auto Scaling EC2 instances running Nginx
- Private RDS (MySQL) database

## Deployment Steps

### 1. Initialize GitHub Repository
```bash
git init
git add .
git commit -m "Shopalyst project"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/aws-iac-webapp-demo.git
git push -u origin main


### 2. Upload To S3

Create an S3 bucket (e.g., codebuildjitheesh) and upload:

master. yaml
vpc.yaml
security.yaml
compute.yaml
rds.yaml

### 3. Update master.yaml (optional) or it can be manually enter via parameters while deploying stack via console

Replace each TemplateURL: with the correct S3 URL:

TemplateURL: https://s3.amazonaws.com/codebuildjitheesh/vpc.yaml

### 4. Deploy Master Stack via Console

Go to AWS CloudFormation → Create stack → Upload https://s3.amazonaws.com/codebuildjitheesh/Projec/master.yaml) → Create stack

Or via AWS CLI: Then update each template url with correct values for each nested stack


aws cloudformaton create-stack \
  --stack-name webapp-master \
  --template-body file://master.yaml \
  --capabilities CAPABILITY_NAMED_IAM


### 5. Cleanup

Delete the shopalyst-stack deletes all nested resources automatically.
