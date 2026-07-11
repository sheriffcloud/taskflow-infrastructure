resource "aws_db_instance" "main" {
  identifier = "${var.project_name}-${var.environment}-db-postgres"

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = "gp2"
  storage_encrypted     = true


  engine         = "postgres"
  engine_version = "15.18"
  instance_class = var.instance_class

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  port     = var.db_port

  parameter_group_name   = aws_db_parameter_group.main.name
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_security_group_id]

  multi_az            = var.multi_az
  publicly_accessible = false

  backup_retention_period = var.backup_retention_period
  backup_window           = "03:00-04:00"
  maintenance_window      = "mon:04:00-mon:05:00"

  auto_minor_version_upgrade = true
  deletion_protection        = false
  skip_final_snapshot        = var.skip_final_snapshot

  tags = {
    Name = "${var.project_name}-${var.environment}-db-postgres"
    Environment = var.environment
  }
}
