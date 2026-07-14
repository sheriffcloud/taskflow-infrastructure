variable "environment" {
    description = "The environment for the deployment (e.g., dev, staging, prod)"
    type        = string
    # default     = "production"
}


variable "project_name" {
    description = "The name of the project"
    type        = string
    # default     = "taskflow"
}

variable "domain_name" {
  description = "Root domain name"
  type        = string
  default     = "netforgetech.online"
}

variable "alb_dns_name" {
  description = "ALB DNS name created by Load Balancer Controller"
  type        = string
  default     = ""
  # Empty on first apply → records skipped
  # Set after ALB created → records created
}