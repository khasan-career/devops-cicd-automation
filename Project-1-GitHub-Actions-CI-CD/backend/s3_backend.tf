## Module file - annotated. Comments explain resource purpose and variable flow.

# This file demonstrates remote backend configuration using S3 + DynamoDB.
# Do NOT commit secrets. For init, pass -backend-config=backend/remote_backend.tfvars
terraform {
  backend "s3" {
    bucket         = "kamrul-terraform-backend"
    key            = "project1/dev/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
