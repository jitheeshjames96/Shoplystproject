# Shoplystproject

🏗️ Local Project Structure

├── master.yaml
├── vpc.yaml
├── security.yaml
├── compute.yaml
├── rds.yaml
└── README.md
└── config/
        └── env.json
└── Documents/
        └── Shopalyst WebApp Doc
└── scripts
        └── index.html
        └── bootstrap.sh
        └── user-data-script.sh



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
git branch -M Prod
git remote add origin https://github.com/jitheeshjames96/Shoplystproject.git
git push -u origin Prod


### 2. Upload To S3

#Open cloudshell:

git clone https://github.com/jitheeshjames96/Shoplystproject.git

#ensure it is Prod Branch

cd Shoplystproject

### Update the compute.yaml file s3 location scripts in userdata with your location, then copy to s3

#Move Project Folder completely to your s3 bucket

aws s3 sync /home/cloudshell-user/Shoplystproject/Project/ s3://your-bucket-name/Project/


### 3. Update env.json file (optional) or it can be manually enter via parameters while deploying stack via console

#Replace each parameter values: with the correct data


### 4. Deploy Master Stack via Console

Go to AWS CloudFormation → Create stack → Upload https://your-bucket-name.s3.ap-south-1.amazonaws.com/Project/master.yaml ) → Create stack

Or via AWS CLI: Then update each template url with correct values for each nested stack


aws cloudformation create-stack \
  --stack-name ShopalystProject \
  --template-url https://codebuildjitheesh.s3.ap-south-1.amazonaws.com/Project/master.yaml \
  --parameters file://Project/config/env.json \
  --capabilities CAPABILITY_NAMED_IAM

Review the stack progress and completion. Verify the output from compute Stack and hit on the ELB DNS NAME to see the webpage.

### 5. Cleanup

Delete the shopalyst-stack deletes all nested resources automatically.



###Documentation:


Please refer this doc : https://github.com/jitheeshjames96/Shoplystproject/blob/Prod/Project/Documents/Shopalyst%20Demo%20Webapp.pdf

##References and courtesy :

* ChatGPT,

* OpenAI,

* AWS Documetation for cloudformation

   ** CloudFormation User Guide

   **Auto Scaling with ALB

   **Secret Manager Integration


* Forums, GitHub Repos, and AWS Blog Posts
