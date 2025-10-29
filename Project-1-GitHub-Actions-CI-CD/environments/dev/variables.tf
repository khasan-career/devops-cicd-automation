variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "db_password" {
  description = "Password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "key_name" {
  description = "EC2 key pair name for SSH access"
  type        = string
}
