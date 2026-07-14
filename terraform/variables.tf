variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"

}


variable "environment" {
  description = "The environment for the deployment (e.g., dev, staging, prod)"
  type        = string
  default     = "production"
}


variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "taskflow"
}

# ── VPC Variables ─────────────────────────────────────────────────────────────
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "database_subnet_cidrs" {
  description = "List of CIDR blocks for database subnets"
  type        = list(string)
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}

# ── EKS Variables ─────────────────────────────────────────────────────────────

variable "eks_cluster_version" {
  description = "Kubernetes version of the EKS cluster"
  type        = string
  default     = "1.36"
}

variable "eks_node_instance_type" {
  description = "The EC2 instance type for the EKS worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "eks_node_min_size" {
  description = "The minimum number of worker nodes in the EKS node group"
  type        = number
  default     = 2
}

variable "eks_node_max_size" {
  description = "The maximum number of worker nodes in the EKS node group"
  type        = number
  default     = 6
}

variable "eks_node_desired_size" {
  description = "The desired number of worker nodes to start with"
  type        = number
  default     = 2
}


# ── RDS Variables ─────────────────────────────────────────────────────────────

variable "instance_class" {
  description = "RDS instance size"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "The name of the initial RDS database"
  type        = string
  default     = "taskflow"
}

variable "db_username" {
  description = "Master username for RDS"
  type        = string
  default     = "taskflow_admin"
}

variable "db_password" {
  description = "Master password for RDS"
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "The port on which the RDS instance will listen"
  type        = number
  default     = 5432
}


variable "allocated_storage" {
  description = "Initial storage allocated in GB"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum storage allocated in GB"
  type        = number
  default     = 100
}

variable "backup_retention_period" {
  description = "The number of days to retain backups for"
  type        = number
  default     = 7
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Specifies whether a final snapshot is created when the RDS instance is deleted"
  type        = bool
  default     = true
  # We set true so terraform destroy runs cleanly
  # In real production ALWAYS set this to false
}

# ── ElastiCache Variables ─────────────────────────────────────────────────────

variable "redis_node_type" {
  description = "The instance type for the Redis node"
  type        = string
  default     = "cache.t3.micro"
}

variable "redis_num_cache_nodes" {
  description = "The number of Redis nodes"
  type        = number
  default     = 1
}

variable "engine_version" {
  description = "ElastiCache engine version"
  type        = string
  default     = "7.1"
}

variable "redis_port" {
  description = "ElastiCache port"
  type        = number
  default     = 6379
}

variable "snapshot_retention_limit" {
  description = "The number of days for which ElastiCache snapshots are retained"
  type        = number
  default     = 1
}

variable "apply_immediately" {
  description = "Whether to apply changes immediately or during the next maintenance window"
  type        = bool
  default     = true
}


# ── ECR Variables ─────────────────────────────────────────────────────

variable "services" {
  description = "List of service names to create repositories for"
  type        = list(string)
  default     = ["api-gateway", "user-service", "task-service", "notification-service", "frontend"]
}

variable "image_retention_count" {
  description = "Number of images to keep per repository before old ones are deleted"
  type        = number
  default     = 10
}

# ── DNS Variables ─────────────────────────────────────────────────────
variable "domain_name" {
  description = "Root domain name"
  type        = string
  default     = "netforgetech.online"
}

variable "alb_dns_name" {
  description = "ALB DNS name created by Load Balancer Controller"
  type        = string
  default     = ""
  # Empty on first apply → records skipped
  # Set after ALB created → records created
}