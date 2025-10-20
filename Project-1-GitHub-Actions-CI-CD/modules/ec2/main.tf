variable "public_subnet_ids" {
  type = list(string)
}

variable "web_sg_id" {
  type = string
}

resource "aws_instance" "web" {
  ami                    = "ami-0c2b8ca1dad447f8a" # Amazon Linux 2 us-east-2
  instance_type          = "t3.micro"
  subnet_id              = element(var.public_subnet_ids, 0)
  vpc_security_group_ids = [var.web_sg_id]

  tags = {
    Name = "project1-web"
  }
}
