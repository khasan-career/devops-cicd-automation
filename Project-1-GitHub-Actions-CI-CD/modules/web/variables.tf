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

variable "instance_count" {
  type = number
}

variable "instance_type" {
  type = string
}

variable "instance_ami" {
  type = string
}

variable "vpc_id" {
  type    = string
  default = ""
}
