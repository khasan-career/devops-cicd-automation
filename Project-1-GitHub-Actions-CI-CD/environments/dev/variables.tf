variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "db_password" {
  description = "Password for the RDS instance"
  type        = string
  sensitive   = true
}
