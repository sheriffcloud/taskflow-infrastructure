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

variable "private_subnet_ids" {
  description = "List of private subnet IDs where the EKS nodes will be deployed"
  type        = list(string)
}

variable "eks_cluster_version" {
  description = "Kubernetes version of the EKS cluster"
  type        = string
#   default     = "1.36"
}

variable "eks_node_instance_type" {
  description = "The EC2 instance type for the EKS worker nodes"
  type        = string
#   default     = "t3.medium"
}

variable "eks_node_min_size" {
  description = "The minimum number of worker nodes in the EKS node group"
  type        = number
#   default     = 2
}

variable "eks_node_max_size" {
  description = "The maximum number of worker nodes in the EKS node group"
  type        = number
#   default     = 6
}

variable "eks_node_desired_size" {
  description = "The desired number of worker nodes to start with"
  type        = number
#   default     = 2
}

variable "eks_nodes_security_group_id" {
  description = "The ID of the security group for the EKS worker nodes"
  type        = string
}