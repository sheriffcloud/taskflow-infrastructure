resource "aws_elasticache_cluster" "main" {
  cluster_id = "${var.project_name}-${var.environment}-elasticache-cluster"

  engine         = "redis"
  engine_version = var.engine_version

  node_type       = var.redis_node_type
  num_cache_nodes = var.redis_num_cache_nodes

  port = var.redis_port

  subnet_group_name    = aws_elasticache_subnet_group.main.name
  parameter_group_name = aws_elasticache_parameter_group.main.name
  security_group_ids   = [var.elasticache_security_group_id]

  snapshot_retention_limit = var.snapshot_retention_limit
  snapshot_window          = "02:00-03:00"
  maintenance_window       = "sun:05:00-sun:06:00"
  apply_immediately        = var.apply_immediately

  tags = {
    Name        = "${var.project_name}-${var.environment}-elasticache-cluster"
    Environment = var.environment
  }


}
