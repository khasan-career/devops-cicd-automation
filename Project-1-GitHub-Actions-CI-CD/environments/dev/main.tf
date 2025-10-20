module "vpc" {
  source = "../../modules/vpc"
}

module "security" {
  source = "../../modules/security"
  vpc_id = module.vpc.aws_vpc_id
}

module "ec2" {
  source             = "../../modules/ec2"
  public_subnet_ids  = module.vpc.public_subnet_ids
  web_sg_id          = module.security.web_sg_id
}

module "alb" {
  source             = "../../modules/alb"
  vpc_id             = module.vpc.aws_vpc_id
  alb_sg_id          = module.security.alb_sg_id
  public_subnet_ids  = module.vpc.public_subnet_ids
}

module "rds" {
  source      = "../../modules/rds"
  web_sg_id   = module.security.web_sg_id
  db_password = var.db_password
}

# 🔗 Allow EC2 to connect to RDS on port 3306
resource "aws_security_group_rule" "rds_inbound" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.ec2.ec2_sg_id
  security_group_id        = module.rds.rds_sg_id
}
