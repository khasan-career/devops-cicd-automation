## main.tf - root module wiring. Calls modules/* and passes variables/outputs between modules.

# Web module: launches EC2 instances in provided subnet(s) and installs nginx via user_data.
resource "aws_security_group" "web_sg" {
  name   = "${var.project_name}-${var.environment}-web-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  count                  = var.instance_count
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = element(var.subnet_ids, count.index % length(var.subnet_ids))
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags = {
    Name = "${var.project_name}-${var.environment}-web-${count.index}"
  }

  # simple user_data to install nginx so HTTP responds
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y nginx
              sudo systemctl enable nginx
              sudo systemctl start nginx
              echo "Hello from web-${count.index}" > /var/www/html/index.html
              EOF
}

#data "aws_vpc" "selected" {
#  id = var.vpc_id
#}
