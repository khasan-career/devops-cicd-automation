variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

variable "aws_access_key" {
  description = "AWS access key (sensitive)"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS secret key (sensitive)"
  type        = string
  sensitive   = true
}

# Network & compute defaults (can be overridden per environment)
variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Existing EC2 key pair name"
  type        = string
  default     = "kamrul-dev-key"
}
