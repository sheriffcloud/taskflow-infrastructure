resource "aws_ecr_repository" "services" {
  count                = length(var.services)
  name                 = "${var.project_name}-${var.environment}-${var.services[count.index]}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }


  tags = {
    Name        = "${var.project_name}-${var.environment}-${var.services[count.index]}"
    Service     = var.services[count.index]
    Environment = var.environment
  }
}
