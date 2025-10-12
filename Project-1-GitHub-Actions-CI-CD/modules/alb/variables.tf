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

variable "target_instance_ids" {
  type    = list(string)
  default = []
}

variable "vpc_id" {
  type    = string
  default = ""
}
