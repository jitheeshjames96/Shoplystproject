🚀 Shopalyst WebApp Infrastructure (AWS CloudFormation)

This project automates the deployment of a scalable, secure web application infrastructure on AWS using CloudFormation (IaC). It includes:

VPC with public/private subnets across two AZs

Auto Scaling EC2 web servers (private)

Internet-facing ALB (public)

Secure Multi-AZ RDS (MySQL)

Secrets Manager for DB credentials

CloudWatch alarms and notifications

GitHub-triggered CI/CD using CodePipeline (optional)  not integrated yet



---

🧱 Architecture Overview

 <!-- optional -->

🔹 Key Components:

Stack	Description

VPC	Custom VPC, 2 AZs, NAT Gateways, IGW
Compute	EC2 in ASG (Nginx), ALB with health checks
Database	RDS MySQL (multi-AZ, private, SecretsManager)
Bootstrap	One-time EC2 to initialize schema/data
IAM	Roles for EC2 with minimal privileges.....


CI/CD	GitHub → CodePipeline → CloudFormation -- not yet

All services built up from master stack which will be nested to 4 core nested stacks.
Module level operation is maintained for ease of debug and implementation.

All services are comes under free tier and architected using aws free tier account.
Infrastructure will be deleted on deletion of master stack and there is no retention policy enabled on any services.

---

🧑‍💻 Setup Instructions

1. Clone the Repo

git clone https://github.com/jitheeshjames96/Shoplystproject.git


cd Shoplystproject

upload the Project folder to your s3 bucket

2. Prepare Keypair and env config file with s3 paths as per your bucket name and change the other parameters as per your convinience

Create a key pair and attached it with ec2 machine, but not enabling the ssh open in sg. Change that keyname as per tour key in env. json file
In case of ssm failure, an alternative to access the machine.

env file is created with parameters which is passed to master stack,
so that no values will be hard coded in template.


3. Deploy via CloudFormation (Optional CLI)

aws cloudformation deploy \
  --stack-name shopalyst-master-stack \
  --template-file <s3 url for master.yaml in your account> \
  --parameter-overrides file://env.json \
  --capabilities CAPABILITY_NAMED_IAM

4. CI/CD (Auto Deployment) not yet done now doing via above mode 

Commits to GitHub trigger CodePipeline → CloudFormation

buildspec.yml handles the deploy



---

🌐 Web Application

Static webpage served on EC2 (via Nginx)

index.html enhanced to include GitHub project link


---

📬 Notifications

Email alerts configured via SNS for ASG instance launch/termination

CloudWatch used for CPU-based scaling policy


---

📈 Monitoring & Scaling

Target group health check + ALB

ASG with CPU-based scaling:

Scale out > 70%

Scale in < 30%


---

📎 Notes

RDS and EC2 are in private subnets

All credentials are securely handled via Secrets Manager

IAM follows least privilege principles


---


## 📄 References
- AWS CloudFormation Documentation: https://docs.aws.amazon.com/cloudformation/
- AWS Secrets Manager: https://docs.aws.amazon.com/secretsmanager/
- Project documents creation and technical guidance using OpenAI ChatGPT


