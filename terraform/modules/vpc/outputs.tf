output "vpc_id" {
    description = "The ID of the VPC created by the module"
    value = aws_vpc.main.id
  
}

output "public_subnet_ids" {
    description = "The IDs of the public subnets created by the module"
    value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
    description = "The IDs of the private subnets created by the module"
    value = aws_subnet.private[*].id
}

output "database_subnet_ids" {
    description = "The IDs of the database subnets created by the module"
    value = aws_subnet.database[*].id
}

output "internet_gateway_id" {
    description = "The ID of the Internet Gateway created by the module"
    value = aws_internet_gateway.main.id
}

output "nat_gateway_ids" {
    description = "The IDs of the NAT Gateways created by the module"
    value = aws_nat_gateway.main[*].id
}

output "alb_security_group_id" {
    description = "The ID of the ALB security group created by the module"
    value = aws_security_group.alb.id
}

output "eks_nodes_security_group_id" {
    description = "The ID of the EKS nodes security group created by the module"
    value = aws_security_group.eks_nodes.id
}

output "rds_security_group_id" {
    description = "The ID of the RDS security group created by the module"
    value = aws_security_group.rds.id
}

output "elasticache_security_group_id" {
    description = "The ID of the ElastiCache security group created by the module"
    value = aws_security_group.elasticache.id
}