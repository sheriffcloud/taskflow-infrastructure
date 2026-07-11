resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-${var.environment}-db-subnet-group"
  description = "Subnet group for TaskFlow RDS instances"
  subnet_ids = var.database_subnet_ids

  tags = {
    Name = "${var.project_name}-${var.environment}-db-subnet-group"
    Environment = var.environment
  }
}