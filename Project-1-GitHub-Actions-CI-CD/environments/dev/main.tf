terraform {
  backend "s3" {}
}

# load root variables automatically from parent - using module call here
module "vpc" {
  source          = "../../modules/vpc"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "security" {
  source = "../../modules/security"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source          = "../../modules/ec2"
  subnet_id       = module.vpc.public_subnet_ids[0]
  sg_id           = module.security.web_sg_id
  instance_type   = var.instance_type
  key_name        = var.key_name
}

module "alb" {
  source             = "../../modules/alb"
  vpc_id             = module.vpc.vpc_id
  public_subnets     = module.vpc.public_subnet_ids
  sg_id              = module.security.alb_sg_id
  target_instance_id = module.ec2.instance_id
}

module "rds" {
  source          = "../../modules/rds"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnet_ids
  sg_id           = module.security.db_sg_id
}
