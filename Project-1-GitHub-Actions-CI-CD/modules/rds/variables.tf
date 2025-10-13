variable "private_subnets" {
  description = "Private subnet ids for DB subnet group"
  type        = list(string)
}

variable "sg_id" {
  description = "Security group id for DB instance"
  type        = string
}

variable "db_username" {
  description = "DB username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "DB password (use secrets for production)"
  type        = string
  #default     = "password123!"
  sensitive   = true
}

# For DB password pass here is alternative approach:
# Option-1 (while run the terraform): terraform apply -var="db_password=MySecurePassword!"

# Option-2 (Before terraform apply): export TF_VAR_db_password="MySecurePassword!"
# terraform apply
