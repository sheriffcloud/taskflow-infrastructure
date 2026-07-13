terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    
    http = {
      source  = "hashicorp/http"
      version = "~> 3.0"
      # Downloads content from HTTP URLs
      # Used to fetch the LBC IAM policy
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
      # Reads TLS certificates
      # Used to get EKS OIDC certificate thumbprint
      # Required for aws_iam_openid_connect_provider
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "taskflow"
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}