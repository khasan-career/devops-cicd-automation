data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]
  key_name               = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx git
              systemctl enable nginx
              systemctl start nginx
              echo "<h1>Terraform + GitHub Actions CI/CD App Deployment Success!</h1>" > /var/www/html/index.html
              EOF

  tags = { Name = "web-server" }
}

output "instance_id"        { value = aws_instance.web.id }
output "instance_public_ip" { value = aws_instance.web.public_ip }
