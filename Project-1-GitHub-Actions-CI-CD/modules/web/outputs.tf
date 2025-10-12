## outputs.tf - root outputs to expose important resource values after apply.

output "instance_ids" {
  value = [for i in aws_instance.web : i.id]
}

output "instance_private_ips" {
  value = [for i in aws_instance.web : i.private_ip]
}
