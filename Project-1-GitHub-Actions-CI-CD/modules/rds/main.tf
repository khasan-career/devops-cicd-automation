## main.tf - root module wiring. Calls modules/* and passes variables/outputs between modules.
resource "aws_db_subnet_group" "main" {
  name       = "db-subnet-group"
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "mysql" {
  identifier             = "cicd-demo-db"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.sg_id]
  skip_final_snapshot    = true
}

output "db_endpoint" { value = aws_db_instance.mysql.endpoint }
