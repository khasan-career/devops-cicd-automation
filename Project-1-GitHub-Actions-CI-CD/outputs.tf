## outputs.tf - root outputs to expose important resource values after apply.

# Root outputs
output "alb_dns" {
  description = "ALB DNS name"
  value       = module.alb.alb_dns_name
  depends_on  = [module.alb]
}
