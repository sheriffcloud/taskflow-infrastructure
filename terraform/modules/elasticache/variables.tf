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

variable "elasticache_security_group_id" {
  description = "The ID of the security group for the ElastiCache instance"
  type        = string
}

variable "redis_node_type" {
    description = "ElastiCache node instance size"
    type        = string
    # default = "cache.t3.micro"
}

variable "redis_num_cache_nodes" {
    description = "Number of cache nodes in the ElastiCache cluster"
    type        = number
    # default     = 1
}

variable "engine_version" {
    description = "ElastiCache engine version"
    type        = string
    # default     = "7.1"
}

variable "redis_port" {
    description = "ElastiCache port"
    type        = number
    # default     = 6379
}

variable "snapshot_retention_limit" {
    description = "The number of days for which ElastiCache snapshots are retained"
    type        = number
    # default     = 1
}

variable "apply_immediately" {
    description = "Whether to apply changes immediately or during the next maintenance window"
    type        = bool
    # default     = true
}