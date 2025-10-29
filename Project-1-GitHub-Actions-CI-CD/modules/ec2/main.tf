variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
  default     = "ami-0807bd3aff0ae7273" # Amazon Linux 2 (us-east-2)
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

variable "key_name" {
  description = "EC2 Key Pair name to use for SSH access"
  type        = string
}

resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.web_sg_id]
  associate_public_ip_address = true
  key_name               = var.key_name

  user_data_replace_on_change = true

  user_data = <<-EOF
    #!/bin/bash
    exec > /var/log/user-data.log 2>&1
    echo "=== Starting user data script for Amazon Linux 2023 ==="

    dnf update -y
    dnf install -y nginx
    systemctl enable nginx
    systemctl start nginx
    mkdir -p /usr/share/nginx/html
    echo "<h1>Terraform + GitHub Actions Deployment Successful (Amazon Linux 2023)</h1>" > /usr/share/nginx/html/index.html

    echo "=== Completed user data script ==="
  EOF

  tags = {
    Name = "github-actions-web-instance"
  }

 # Ensures Terraform replaces instance automatically when type changes
  lifecycle {
    create_before_destroy = true
  }

}
