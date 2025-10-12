## outputs.tf - root outputs to expose important resource values after apply.

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}
