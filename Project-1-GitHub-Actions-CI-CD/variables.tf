## variables.tf - declares root variables. Values come from env or environments/*.tfvars.

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-2"
}

variable "project_name" {
  description = "Prefix for resource names"
  type        = string
  default     = "kamrul-three-tier"
}

variable "environment" {
  description = "Environment name (dev/stage/prod)"
  type        = string
  default     = "dev"
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs (one per AZ)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs (one per AZ)"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "web_instance_count" {
  description = "Number of web instances"
  type        = number
  default     = 1
}

variable "app_instance_count" {
  description = "Number of app instances"
  type        = number
  default     = 1
}

variable "instance_ami" {
  description = "AMI to use for EC2 instances (Ubuntu 22.04 recommended)"
  type        = string
  default     = "ami-0a313d6098716f372" # placeholder - update per region
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "db_allocated_storage" {
  type    = number
  default = 20
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_username" {
  type    = string
  #default = "adminuser"
}

variable "db_password" {
  type    = string
  sensitive   = true
  # default = "ChangeMe123!" # replace with sensitive secret in production
}
