variable "subnet_id" {
  description = "Subnet ID for EC2 instance"
  type        = string
}

variable "sg_id" {
  description = "Security group id for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}
