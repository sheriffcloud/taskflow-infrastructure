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

variable "alb_hosted_zone_id" {
  description = "ALB hosted zone ID for Route53 alias record"
  type        = string
  # default     = "Z35SXDOTRQ7X7K"
  # Z35SXDOTRQ7X7K is the fixed hosted zone ID
  # for ALL ALBs in us-east-1
  # This never changes — it's an AWS constant
  # Different regions have different IDs:
  # us-east-1: Z35SXDOTRQ7X7K
  # us-west-2: Z1H1FL5HABSF5
  # eu-west-1: Z32O12XQLNTSW2
}