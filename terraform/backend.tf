terraform {
  backend "s3" {
    bucket         = "taskflow-terraform-state-YOUR_AWS_ACCOUNT_ID"
    key            = "taskflow/production/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "taskflow-terraform-locks"
  }
}
