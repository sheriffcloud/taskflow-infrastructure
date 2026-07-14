resource "aws_acm_certificate" "main" {
  domain_name       = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method = "DNS"

  tags = {
    Name = var.domain_name
    Environment = var.environment
    Project = var.project_name

  }

  lifecycle {
    create_before_destroy = true
  }
}