output "env_app_user" {
  value       = local.env_app_concat
  description = "Environment + Application name"
}

output "max_port" {
  value       = local.max_port
  description = "find the maximum port from the given list"
}

output "min_port" {
  value       = local.min_port
  description = "find the minimum port from the given list"
}

output "all_tags_keys" {
  value       = keys(aws_security_group.my-sg.tags)
  description = "get all the keys from the tags of the security groups"

}

output "tags_values" {
  value       = values(aws_security_group.my-sg.tags)
  description = "lis of all the values present in the tags of the aes security group"
}

output "allowed_ports" {
  value       = toset(var.allowed_ports)
  description = "set of all the allowed ports with unique values"
}
