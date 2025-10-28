variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 (us-east-2)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "web_sg_id" {
  description = "Security group ID for web server"
  type        = string
}

resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.web_sg_id]
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo amazon-linux-extras install nginx1 -y
    sudo systemctl enable nginx
    sudo systemctl start nginx
    echo "<h1>Terraform + GitHub Actions Deployment Successful!</h1>" > /usr/share/nginx/html/index.html
  EOF

  tags = {
    Name = "project1-web-instance"
  }
}
