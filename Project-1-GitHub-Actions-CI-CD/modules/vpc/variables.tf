## variables.tf - declares root variables. Values come from env or environments/*.tfvars.

variable "project_name" { 
    type = string 
    }
variable "environment" { 
    type = string 
    }

variable "vpc_cidr" { 
    type = string 
    }

variable "public_subnet_cidrs" { 
    type = list(string) 
    }

variable "private_subnet_cidrs" { 
    type = list(string) 
    }
