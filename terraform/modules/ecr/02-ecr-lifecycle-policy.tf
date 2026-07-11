resource "aws_ecr_lifecycle_policy" "services" {
  count      = length(var.services)
  repository = aws_ecr_repository.services[count.index].name

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep only the ${var.image_retention_count} most recent images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": ${var.image_retention_count}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}
