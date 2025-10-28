module "vpc" {
  source = "../../modules/vpc"
}

module "security" {
  source = "../../modules/security"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source            = "../../modules/ec2"
  public_subnet_ids = module.vpc.public_subnet_ids
  web_sg_id         = module.security.web_sg_id
}

module "alb" {
  source             = "../../modules/alb"
  vpc_id             = module.vpc.vpc_id
  alb_sg_id          = module.security.alb_sg_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  instance_id        = module.ec2.ec2_id     # ✅ new line
}

module "rds" {
  source      = "../../modules/rds"
  vpc_id      = module.vpc.vpc_id
  web_sg_id   = module.security.web_sg_id
  subnet_ids  = module.vpc.public_subnet_ids
  db_password = var.db_password
}

