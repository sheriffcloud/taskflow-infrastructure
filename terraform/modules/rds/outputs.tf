output "endpoint" {
    description = "RDS connection endpoint — the hostname part of DATABASE_URL"
    value = aws_db_instance.main.endpoint
  
}

output "host" {
    description = "RDS connection host — the hostname part of DATABASE_URL"
    value = aws_db_instance.main.address
}

output "port" {
    description = "RDS connection port — the port part of DATABASE_URL"
    value = aws_db_instance.main.port
}

output "db_name" {
    description = "RDS database name"
    value = aws_db_instance.main.db_name
}

output "username" {
    description = "RDS database username"
    value = aws_db_instance.main.username
}