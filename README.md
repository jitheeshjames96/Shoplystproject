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

2. 🧩 Upload Code to S3

aws s3 cp Project/ s3://my-cfn-bucket/Project/ --recursive
update the compute.yaml userdata section with your s3 url
And update parameter values in env.json file inside config folder.

---

3. ☁️ Deploy the Master Stack

aws cloudformation create-stack \
  --stack-name ShoplystInfra \
  --template-url https://my-cfn-bucket.s3.amazonaws.com/Project/master.yaml \
  --parameters file://Project/parameters.json \
  --capabilities CAPABILITY_NAMED_IAM


---

4. 🔄 Delete Stack

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

🛠️ To-Do / Improvements

[ ] Add logging/monitoring using CloudWatch

[ ] Add optional Bastion setup for database debugging

[ ] CI/CD pipeline integration (e.g., CodePipeline, Git Actions)


---

## ✅ Best Practices Followed

- Modular CloudFormation templates
- Private subnets for compute and database
- NAT Gateway for secure outbound traffic
- IAM role with minimal permissions for EC2
- Secrets stored in AWS Secrets Manager
- Auto Scaling + ALB setup for HA

---

👤 Author

Jitheesh James
