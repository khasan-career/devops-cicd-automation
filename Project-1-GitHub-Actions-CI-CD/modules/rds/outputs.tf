output "rds_sg_id" {
  description = "RDS Security Group ID"
  value       = aws_security_group.rds_sg.id
}

output "rds_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.this.endpoint
}
