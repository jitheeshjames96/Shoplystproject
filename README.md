# Shoplystproject#

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
