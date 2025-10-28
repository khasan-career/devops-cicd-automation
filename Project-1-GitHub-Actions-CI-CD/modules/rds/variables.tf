variable "vpc_id" {
  description = "VPC ID where the RDS security group will be created"
  type        = string
}

variable "web_sg_id" {
  description = "Web security group ID allowed to connect to RDS"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS subnet group"
  type        = list(string)
}

variable "db_password" {
  description = "Database password for RDS"
  type        = string
  sensitive   = true
}
