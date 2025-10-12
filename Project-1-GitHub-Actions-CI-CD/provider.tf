## provider.tf - sets Terraform provider and backend. Read before modules.

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
