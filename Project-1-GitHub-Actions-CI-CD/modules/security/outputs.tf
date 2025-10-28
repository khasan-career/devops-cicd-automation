output "web_sg_id" {
  description = "Security group ID for web servers"
  value       = aws_security_group.web_sg.id
}

output "alb_sg_id" {
  description = "Security group ID for ALB"
  value       = aws_security_group.alb_sg.id
}
