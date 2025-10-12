## main.tf - root module wiring. Calls modules/* and passes variables/outputs between modules.
resource "aws_db_subnet_group" "db_subnet" {
  name       = "${var.project_name}-${var.environment}-dbsubnet"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.project_name}-${var.environment}-dbsubnet"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage = var.db_allocated_storage
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = var.db_instance_class

  # ✅ Corrected line
  db_name = "${var.project_name}_${var.environment}_db"

  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = false
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  tags = {
    Name = "${var.project_name}-${var.environment}-rds"
  }
}

resource "aws_security_group" "db_sg" {
  name        = "${var.project_name}-${var.environment}-db-sg"
  description = "DB SG - restrict to VPC"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#data "aws_vpc" "selected" {
#  id = var.vpc_id
#}
