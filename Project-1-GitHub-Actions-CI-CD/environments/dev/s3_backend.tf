terraform {
  backend "s3" {
    bucket         = "kamrul-terraform-backend"
    key            = "project1/dev/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
