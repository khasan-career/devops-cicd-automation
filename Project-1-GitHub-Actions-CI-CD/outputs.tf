## outputs.tf - root outputs to expose important resource values after apply.

# Root outputs
output "alb_dns" {
  description = "Load Balancer DNS"
  value       = module.alb.alb_dns_name
}
