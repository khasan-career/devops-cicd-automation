variable "aws_region" {}
variable "aws_access_key" { sensitive = true }
variable "aws_secret_key" { sensitive = true }

variable "vpc_cidr" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "instance_type" {}
variable "key_name" {}
