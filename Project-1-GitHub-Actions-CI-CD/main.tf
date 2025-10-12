## main.tf - root module wiring. Calls modules/* and passes variables/outputs between modules.

# Root module - wires modules together in a simple predictable way.

module "vpc" {
  source = "./modules/vpc"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

# Application -- Web tier (public) - simple EC2 instances.
module "web" {
  source         = "./modules/web"
  project_name   = var.project_name
  environment    = var.environment
  subnet_ids     = module.vpc.public_subnet_ids
  instance_count = var.web_instance_count
  instance_type  = var.instance_type
  instance_ami   = var.instance_ami
}

# Application -- App tier (private) - simple EC2 instances.
module "app" {
  source         = "./modules/app"
  project_name   = var.project_name
  environment    = var.environment
  subnet_ids     = module.vpc.private_subnet_ids
  instance_count = var.app_instance_count
  instance_type  = var.instance_type
  instance_ami   = var.instance_ami
}

# ALB - placed in public subnets.
module "alb" {
  source              = "./modules/alb"
  project_name        = var.project_name
  environment         = var.environment
  subnet_ids          = module.vpc.public_subnet_ids
  target_instance_ids = concat(module.web.instance_ids, module.app.instance_ids)
  # We pass instance IDs explicitly; module uses them to register targets.
}

# RDS - uses private subnets via subnet group
module "rds" {
  source               = "./modules/rds"
  project_name         = var.project_name
  environment          = var.environment
  subnet_ids           = module.vpc.private_subnet_ids
  db_username          = var.db_username
  db_password          = var.db_password
  db_instance_class    = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
}

