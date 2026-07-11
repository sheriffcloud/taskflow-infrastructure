# TaskFlow Infrastructure

Production-grade AWS infrastructure for TaskFlow — a microservices task management application.

## Architecture

VPC (10.0.0.0/16)
├── Public Subnets (2 AZs)  → ALB, NAT Gateways
├── Private Subnets (2 AZs) → EKS Worker Nodes
└── Database Subnets (2 AZs) → RDS, ElastiCache
AWS Services:
├── EKS 1.36        → Kubernetes cluster
├── RDS PostgreSQL  → Application database
├── ElastiCache     → Redis pub/sub
└── ECR             → Docker image registry

## Prerequisites

- AWS CLI configured
- Terraform >= 1.5
- kubectl

## Deploy

```bash
# 1. Copy and fill in variables
cp terraform.tfvars.example terraform.tfvars

# 2. Initialize Terraform
terraform init

# 3. Review what will be created
terraform plan

# 4. Apply infrastructure
terraform apply

# 5. Configure kubectl
aws eks update-kubeconfig --region us-east-1 --name taskflow-production-eks-cluster
```

## Destroy

```bash
terraform destroy
```

## Technologies

- Terraform
- AWS EKS (Kubernetes)
- AWS RDS (PostgreSQL)
- AWS ElastiCache (Redis)
- AWS ECR
- AWS VPC