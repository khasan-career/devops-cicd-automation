## outputs.tf - root outputs to expose important resource values after apply.

output "db_address" {
  value = aws_db_instance.default.address
}

output "db_id" {
  value = aws_db_instance.default.id
}
