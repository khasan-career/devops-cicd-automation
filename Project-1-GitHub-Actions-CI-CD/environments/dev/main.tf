# Environment: dev
# Complete 3-tier setup

module "vpc" {
  source = "../../modules/vpc"
}

module "security" {
  source = "../../modules/security"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source              = "../../modules/ec2"
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  security_group_ids  = [module.security.web_sg_id]
  instance_type       = var.ec2_instance_type
  key_name            = var.key_name
}

module "alb" {
  source              = "../../modules/alb"
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  security_group_id   = module.security.alb_sg_id
  target_instance_ids = [module.ec2.instance_id]
}

module "rds" {
  source              = "../../modules/rds"
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  db_username         = var.db_username
  db_password         = var.db_password
  security_group_id   = module.security.db_sg_id
}
