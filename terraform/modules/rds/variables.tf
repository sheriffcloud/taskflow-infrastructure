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

variable "vpc_id" {
  description = "The ID of the VPC where the RDS instance will be deployed"
  type        = string
}

variable "database_subnet_ids" {
  description = "List of subnet IDs for the RDS instance"
  type        = list(string)
}

variable "rds_security_group_id" {
  description = "The ID of the security group for the RDS instance"
  type        = string
}

variable "instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
  # default     = "db.t3.micro"
}

variable "db_name" {
  description = "The name of the database to create"
  type        = string
  # default     = "taskflow"
}

variable "db_username" {
  description = "The username for the database"
  type        = string
  # default     = "taskflow_admin"
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "The port PostgreSQL database listens on"
  type        = number
  # default     = 5432
}

variable "allocated_storage" {
  description = "Initial storage allocated in GB"
  type        = number
  # default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum storage allocated in GB"
  type        = number
  # default     = 100
}

variable "backup_retention_period" {
  description = "The number of days to retain backups for"
  type        = number
  # default     = 7
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  # default     = true
}

variable "skip_final_snapshot" {
  description = "Specifies whether a final snapshot is created when the RDS instance is deleted"
  type        = bool
  # default     = true
  # We set true so terraform destroy runs cleanly
  # In real production ALWAYS set this to false
}
