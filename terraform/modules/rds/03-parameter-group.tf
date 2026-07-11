resource "aws_db_parameter_group" "main" {
  name   = "${var.project_name}-${var.environment}-db-parameter-group"
  description = "Parameter group for TaskFlow RDS instances"
  family = "postgres15"

  parameter {
    name  = "log_connections"
    value = "1"
  }

  parameter {
    name  = "log_disconnections"
    value = "1"
  }


parameter {
    name  = "log_min_duration_statement"
    value = "1000"
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-db-parameter-group"
    Environment = var.environment
  }
}