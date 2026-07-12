
# ── VPC Outputs ─────────────────────────────────────────────────────────────
output "vpc_id" {
  description = "The ID of the VPC created by the module"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets created by the module"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets created by the module"
  value       = module.vpc.private_subnet_ids
}

output "database_subnet_ids" {
  description = "The IDs of the database subnets created by the module"
  value       = module.vpc.database_subnet_ids
}


# ── EKS Outputs ─────────────────────────────────────────────────────────────
output "eks_cluster_name" {
  description = "The name of the EKS cluster created by the module"
  value       = module.eks.eks_cluster_name
}

output "eks_cluster_endpoint" {
  description = "The endpoint URL of the EKS cluster created by the module"
  value       = module.eks.eks_cluster_endpoint
}

output "eks_nodes_security_group_id" {
  description = "The ID of the EKS security group created by the module"
  value       = module.vpc.eks_nodes_security_group_id
}

output "cluster_certificate" {
  description = "Base64 encoded certificate for cluster authentication"
  value       = module.eks.cluster_certificate
  sensitive   = true
}

output "configure_kubectl" {
  description = "Command to configure kubectl to connect to this cluster"
  value       = module.eks.configure_kubectl
}


# ── RDS Outputs ─────────────────────────────────────────────────────────────
output "rds_endpoint" {
  description = "The endpoint URL of the RDS instance created by the module"
  value       = module.rds.endpoint
}

output "rds_host" {
  description = "RDS connection host - the hostname part of DATABASE_URL"
  value       = module.rds.host
}

output "rds_port" {
  description = "RDS connection port - the port part of DATABASE_URL"
  value       = module.rds.port
}

output "rds_db_name" {
  description = "RDS database name"
  value       = module.rds.db_name
}

output "rds_username" {
  description = "RDS database username"
  value       = module.rds.username
}

output "rds_security_group_id" {
  description = "The ID of the RDS security group created by the module"
  value       = module.vpc.rds_security_group_id
}


# ── Redis Outputs ─────────────────────────────────────────────────────────────
output "redis_endpoint" {
  description = "The endpoint URL of the Redis instance created by the module"
  value       = module.elasticache.redis_endpoint
}

output "redis_port" {
  description = "The port of the Redis instance created by the module"
  value       = module.elasticache.redis_port
}

output "redis_connection_string" {
  description = "The connection string of the Redis instance created by the module"
  value       = module.elasticache.redis_connection_string
}

output "elasticache_security_group_id" {
  description = "The ID of the ElastiCache security group created by the module"
  value       = module.vpc.elasticache_security_group_id
}


# ── ECR Outputs ─────────────────────────────────────────────────────────────
output "ecr_repository_urls" {
  description = "The URLs of the ECR repositories created by the module"
  value       = module.ecr.repository_urls
}

output "repository_names" {
  description = "List of repository names — useful for IAM policies"
  value       = module.ecr.repository_names
}

output "registry_id" {
  description = "The ECR registry ID — same as your AWS account ID"
  value       = module.ecr.registry_id
}

# output "configure_kubectl" {
#     description = "Run this command to configure kubectl after apply"
#     value = "aws eks update-kubeconfig --region ${var.aws_region} --name ${var.project_name}-${var.environment}"

# }

# ── ALB Outputs ─────────────────────────────────────────────────────────────
output "alb_security_group_id" {
  description = "The ID of the ALB security group created by the module"
  value       = module.vpc.alb_security_group_id
}