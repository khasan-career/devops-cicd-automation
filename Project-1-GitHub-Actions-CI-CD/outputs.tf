## outputs.tf - root outputs to expose important resource values after apply.

# Root outputs
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS name"
  value       = module.alb.alb_dns_name
}

output "web_instance_ids" {
  description = "Web EC2 instance IDs"
  value       = module.web.instance_ids
}

output "app_instance_ids" {
  description = "App EC2 instance IDs"
  value       = module.app.instance_ids
}

output "rds_endpoint" {
  description = "RDS endpoint address"
  value       = module.rds.db_address
}
