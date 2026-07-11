output "repository_urls" {
    description = "Map of service names to their ECR repository URLs"
    value = {
        for i, service in var.services :
        service => aws_ecr_repository.services[i].repository_url
    }
  
}

output "repository_names" {
    description = "List of repository names — useful for IAM policies"
    value = aws_ecr_repository.services[*].name
}

output "registry_id" {
    description = "The ECR registry ID — same as your AWS account ID"
    value = aws_ecr_repository.services[0].registry_id
}