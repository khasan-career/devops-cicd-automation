## main.tf - root module wiring. Calls modules/* and passes variables/outputs between modules.

# App module: EC2 instances in private subnets with SG allowing inbound from web SG (if provided).
resource "aws_security_group" "app_sg" {
  name   = "${var.project_name}-${var.environment}-app-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"] # allow from VPC - in production tighten this to web SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app" {
  count                  = var.instance_count
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = element(var.subnet_ids, count.index % length(var.subnet_ids))
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  tags = {
    Name = "${var.project_name}-${var.environment}-app-${count.index}"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y apache2
              sudo systemctl enable apache2
              sudo systemctl start apache2
              echo "Hello from app-${count.index}" > /var/www/html/index.html
              EOF
}

#data "aws_vpc" "selected" {
#  id = var.vpc_id
#}
