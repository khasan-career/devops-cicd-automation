## variables.tf - declares root variables. Values come from env or environments/*.tfvars.
variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "db_allocated_storage" {
  type = number
}

variable "db_instance_class" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
  sensitive   = true
}

variable "vpc_id" {
  type    = string
  default = ""
}
