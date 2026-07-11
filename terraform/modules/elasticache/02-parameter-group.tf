resource "aws_elasticache_parameter_group" "main" {
  name   = "${var.project_name}-${var.environment}-elasticache-parameter-group"
  family = "redis7"
  description = "Parameter group for TaskFlow Redis"

  parameter {
    name  = "maxmemory-policy"
    value = "allkeys-lru"
  }

  parameter {
    name  = "timeout"
    value = "300"
  }


    tags = {
        Name        = "${var.project_name}-${var.environment}-elasticache-parameter-group"
        Environment = var.environment
    }
}