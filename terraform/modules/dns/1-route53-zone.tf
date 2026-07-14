resource "aws_route53_zone" "main" {
  name          = var.domain_name
  comment       = "Managed by Terraform"
  force_destroy = true

  tags = {
    Name        = var.domain_name
    Environment = var.environment
    Project     = var.project_name
  }
}
