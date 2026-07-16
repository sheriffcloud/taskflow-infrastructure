# This is the root module — it calls all the child modules
# Think of it as the main() function of your infrastructure
# Each module call is like calling a function

# ── VPC Module ────────────────────────────────────────────────────────────────
# Creates the entire network: VPC, subnets, IGW, NAT, route tables
module "vpc" {
  source = "./modules/vpc"

  # Pass our variables into the module
  aws_region            = var.aws_region
  project_name          = var.project_name
  environment           = var.environment
  vpc_cidr              = var.vpc_cidr
  availability_zones    = var.availability_zones
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
}

# ── ECR Module ────────────────────────────────────────────────────────────────
# Creates Docker image repositories — one per service
module "ecr" {
  source = "./modules/ecr"

  project_name          = var.project_name
  environment           = var.environment
  services              = var.services
  image_retention_count = var.image_retention_count
}

# # ── RDS Module ────────────────────────────────────────────────────────────────
# # Creates PostgreSQL database
# # Notice it uses outputs from the VPC module:
# # module.vpc.database_subnet_ids — the subnets RDS lives in
# # module.vpc.vpc_id — needed to create the security group
module "rds" {
  source = "./modules/rds"

  aws_region              = var.aws_region
  project_name            = var.project_name
  environment             = var.environment
  vpc_id                  = module.vpc.vpc_id
  database_subnet_ids     = module.vpc.database_subnet_ids
  instance_class          = var.instance_class
  db_name                 = var.db_name
  db_username             = var.db_username
  db_password             = var.db_password
  db_port                 = var.db_port
  allocated_storage       = var.allocated_storage
  max_allocated_storage   = var.max_allocated_storage
  backup_retention_period = var.backup_retention_period
  multi_az                = var.multi_az
  skip_final_snapshot     = var.skip_final_snapshot
  rds_security_group_id   = module.vpc.rds_security_group_id

  #   # RDS must wait for VPC to exist first
  depends_on = [module.vpc]
}

# # ── ElastiCache Module ────────────────────────────────────────────────────────
module "elasticache" {
  source = "./modules/elasticache"

  aws_region                    = var.aws_region
  project_name                  = var.project_name
  environment                   = var.environment
  vpc_id                        = module.vpc.vpc_id
  database_subnet_ids           = module.vpc.database_subnet_ids
  redis_node_type               = var.redis_node_type
  redis_num_cache_nodes         = var.redis_num_cache_nodes
  engine_version                = var.engine_version
  redis_port                    = var.redis_port
  snapshot_retention_limit      = var.snapshot_retention_limit
  apply_immediately             = var.apply_immediately
  elasticache_security_group_id = module.vpc.elasticache_security_group_id

  depends_on = [module.vpc]
}

# # ── EKS Module ───────────────────────────────────────────────────────────────
# # Creates the Kubernetes cluster
# # Must be created AFTER VPC so it knows which subnets to use
module "eks" {
  source = "./modules/eks"

  aws_region                  = var.aws_region
  project_name                = var.project_name
  environment                 = var.environment
  vpc_id                      = module.vpc.vpc_id
  eks_cluster_version         = var.eks_cluster_version
  eks_node_instance_type      = var.eks_node_instance_type
  private_subnet_ids          = module.vpc.private_subnet_ids
  eks_nodes_security_group_id = module.vpc.eks_nodes_security_group_id
  eks_node_min_size           = var.eks_node_min_size
  eks_node_max_size           = var.eks_node_max_size
  eks_node_desired_size       = var.eks_node_desired_size

  depends_on = [module.vpc]
}


module "dns" {
  source = "./modules/dns"

  project_name    = var.project_name
  environment     = var.environment
  domain_name     = var.domain_name
  alb_dns_name    = var.alb_dns_name
  alb_hosted_zone_id = var.alb_hosted_zone_id
 
}