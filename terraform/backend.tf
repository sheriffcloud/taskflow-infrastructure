terraform {
  backend "s3" {
    bucket         = "sheriffcloud-taskflow-tfstate"
    key            = "taskflow/production/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "taskflow-terraform-locks"
  }
}