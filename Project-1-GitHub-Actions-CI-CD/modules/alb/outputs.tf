output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.this.dns_name   # ✅ corrected from aws_lb.alb → aws_lb.this
}
