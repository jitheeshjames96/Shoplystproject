🏗️ Shoplyst AWS Infrastructure Deployment – CloudFormation Based

This project deploys a **secure, scalable, and modular AWS infrastructure** for a web application using AWS CloudFormation and S3. The deployment follows Infrastructure as Code (IaC) principles and aligns with AWS best practices.

---

## 📌 Key Features

- **Custom VPC** across 2 Availability Zones (high availability)
- Public and private subnets with correct routing (NAT & IGW)
- **Auto Scaling Group** of EC2 web servers behind an **Application Load Balancer**
- **Private RDS (MySQL)** with Multi-AZ setup and Secrets Manager integration
- Security Groups with least privilege
- Modular stack split by function (`vpc.yaml`, `compute.yaml`, `rds.yaml`, `security.yaml`, etc.)
- Parameterized deployment using `parameters.json`

---

## 📁 Folder Structure

```bash
Shoplystproject/
├── Project/
│   ├── config/                  # Nested stack YAML references
│   ├── scripts/                 # User-data scripts (Apache install, etc.)
│   ├── Documents/               # Diagrams, guides
│   ├── compute.yaml             # ASG + Launch Template + ALB
│   ├── vpc.yaml                 # VPC + Subnets + NAT + IGW + Routes
│   ├── rds.yaml                 # RDS DB + Secrets Manager reference
│   ├── security.yaml            # Security groups
│   ├── master.yaml              # Root stack referencing all modules
└── README.md
---

🚀 Deployment Guide

1. ✅ Prerequisites

AWS CLI configured with IAM permissions to deploy CloudFormation

S3 bucket to store templates (e.g., my-cfn-bucket)

Secrets Manager pre-provisioned (if not created via template)

Create a key pair for login to webapp if any issue happens with ssm.


---

2. 🔁 Clone the Repository

To get started, clone this repository and switch to the `Prod` branch:

```bash
git clone https://github.com/jitheeshjames96/Shoplystproject.git
cd Shoplystproject
git checkout Prod
cd Project

---

3. 🧩 Upload Code to S3

aws s3 cp Project/ s3://my-cfn-bucket/Project/ --recursive
update the compute.yaml userdata section with your s3 url
And update parameter values in env.json file inside config folder.

---

4. ☁️ Deploy the Master Stack

aws cloudformation create-stack \
  --stack-name ShoplystInfra \
  --template-url https://my-cfn-bucket.s3.amazonaws.com/Project/master.yaml \
  --parameters file://Project/parameters.json \
  --capabilities CAPABILITY_NAMED_IAM


---

5. 🔄 Delete Stack

aws cloudformation delete-stack --stack-name ShoplystInfra


---

📜 Outputs

Resource	Description

ALB DNS	Public endpoint of your application
RDS Endpoint	Internal DB access endpoint



---

🔒 Secrets Management

RDS credentials are securely stored in AWS Secrets Manager

rds.yaml references the ARN dynamically and passes it to RDS




---

💻💻💻💻💻💻




🚀 GitHub Actions Automation

The repository is fully automated using GitHub Actions:

### 🔄 `Deploy CloudFormation Stack`

- **Backs up** `Project/` folder from S3 to `Project_bkp_<timestamp>/`
- **Uploads** current repo’s `Project/` files to S3
- **Deploys** CloudFormation stack using `master.yaml`
- **Monitors** events from all nested stacks in real-time (tabular output)

### 🧹 `Delete CloudFormation Stack`

- Deletes the entire stack
- Shows **events** from the deleted parent + nested stacks (tabular format)

---

## 🔐 Required GitHub Secrets

These can be saved in git secrets, risky to do this but only authotized person can only see.

| Secret Name              | Purpose                         |
|--------------------------|----------------------------------|
| `AWS_ACCESS_KEY_ID`      | AWS access key for IAM user     |
| `AWS_SECRET_ACCESS_KEY`  | AWS secret access key           |

---

## 📦 S3 Structure

CloudFormation templates and scripts are uploaded to:

s3://codebuildjitheesh/Project/

Backup is created automatically as:

s3://codebuildjitheesh/Project_bkp_<YYYY-MM-DD-HHMM>/

---

## ⚙️ Parameters in `config/env.json`

```json
[
  {
    "ParameterKey": "WebBootstrap",
    "ParameterValue": "https://codebuildjitheesh.s3.ap-south-1.amazonaws.com/Project/scripts/user-data-script.sh"
  },
  {
    "ParameterKey": "DBBootstrap",
    "ParameterValue": "https://codebuildjitheesh.s3.ap-south-1.amazonaws.com/Project/scripts/bootstrap.sh"
  },
  ...
]

Update this file as needed per deployment.


---

▶️ Deploying from GitHub

1. Go to Actions > Deploy CloudFormation Stack


2. Click Run workflow


3. Enter:

stack: your stack name (e.g., shoplyst-stack)

environment: dev, prod, etc.



4. The workflow:

Backs up old S3 folder

Uploads new files

Deploys CloudFormation

Monitors events from parent + nested stacks





---

🧹 Deleting from GitHub

1. Go to Actions > Delete CloudFormation Stack


2. Enter same stack and environment


3. Deletes the stack and prints latest events




---

📊 Live Monitoring of Events

During deploy and delete workflows:

Events are shown for both parent and nested stacks

Output is printed in tabular format for readability

Status is continuously polled (until *_COMPLETE or *_FAILED)



---

💡 Future Enhancements


⏳ GitHub approval workflow for prod (via environments)

📣 Email/Slack alerts on deploy success/failure

📋 Parameter schema validation


---

## ✅ Best Practices Followed

- Modular CloudFormation templates
- Private subnets for compute and database
- NAT Gateway for secure outbound traffic
- IAM role with minimal permissions for EC2
- Secrets stored in AWS Secrets Manager
- Auto Scaling + ALB setup for HA

---


📚 References

🔹 Official AWS Documentation

AWS CloudFormation Overview

Using Nested Stacks in CloudFormation

CloudFormation Parameters & Outputs

Amazon EC2 Auto Scaling Groups

Application Load Balancer (ALB)

Amazon RDS Multi-AZ Deployments

IAM Roles for EC2 Instances

AWS Secrets Manager

AWS GitHub Action: Configure AWS Credentials

GitHub Actions Workflow Syntax



---

🔹 Community Blogs & Best Practices

AWS Well-Architected Framework

How to Structure Your CloudFormation Template Like a Pro

CI/CD with GitHub Actions and AWS CloudFormation



---

🔹 Developer Tools & Community Support

ChatGPT by OpenAI — for architectural brainstorming, automation scripting, and IaC troubleshooting.

Stack Overflow — for resolving specific CloudFormation, EC2, IAM, and GitHub Actions errors.

GitHub Discussions & Issues — for community-driven fixes, examples, and action support.

AWS re:Post — AWS’s official Q&A community platform.


---


👤 Author

Jitheesh James

📧 Contact

Maintained by Jitheesh James
📩 jitheeshjames27@gmail.com

