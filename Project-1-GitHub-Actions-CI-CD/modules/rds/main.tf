variable "web_sg_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "db_password" {
  type      = string
  sensitive = true
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL from web SG"
  vpc_id      = element(var.subnet_ids, 0) != "" ? "" : "" # Placeholder for demonstration
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.web_sg_id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "project1-db-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "this" {
  identifier              = "project1-db"
  engine                  = "mysql"
  instance_class          = "db.t4g.micro"
  allocated_storage       = 20
  username                = "adminuser"
  password                = var.db_password
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.default.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  publicly_accessible     = false
}
