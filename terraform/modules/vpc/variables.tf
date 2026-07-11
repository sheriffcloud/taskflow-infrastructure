variable "aws_region" {
    description = "The AWS region to deploy resources in"
    type        = string
    # default     = "us-east-1"
  
}


variable "environment" {
    description = "The environment for the deployment (e.g., dev, staging, prod)"
    type        = string
    # default     = "production"
}


variable "project_name" {
    description = "The name of the project"
    type        = string
    # default     = "taskflow"
}

# ── VPC Variables ─────────────────────────────────────────────────────────────
variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
    # default     = "10.0.0.0/16"
}

variable "availability_zones" {
    description = "List of availability zones to use"
    type        = list(string)
    # default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
    description = "List of CIDR blocks for public subnets"
    type        = list(string)
    # default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
    description = "List of CIDR blocks for private subnets"
    type        = list(string)
    # default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "database_subnet_cidrs" {
    description = "List of CIDR blocks for database subnets"
    type        = list(string)
    # default     = ["10.0.5.0/24", "10.0.6.0/24"]    
}