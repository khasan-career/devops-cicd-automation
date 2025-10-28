# ✅ Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL from web servers"
  vpc_id      = var.vpc_id

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

  tags = {
    Name = "project1-rds-sg"
  }
}

# ✅ Subnet Group for RDS
resource "aws_db_subnet_group" "default" {
  name       = "project1-db-subnet-group"
  subnet_ids = var.subnet_ids
  tags = {
    Name = "project1-db-subnet-group"
  }
}

# ✅ RDS Instance
resource "aws_db_instance" "this" {
  identifier              = "project1-db"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = "adminuser"
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.default.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = false
  deletion_protection     = false
  tags = {
    Name = "project1-db-instance"
  }
}
