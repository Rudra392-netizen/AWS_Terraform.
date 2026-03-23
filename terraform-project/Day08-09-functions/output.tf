# output "env_app_user" {
#   value       = local.env_app_concat
#   description = "Environment + Application name"
# }

# output "max_port" {
#   value       = local.max_port
#   description = "find the maximum port from the given list"
# }

# output "min_port" {
#   value       = local.min_port
#   description = "find the minimum port from the given list"
# }

# output "all_tags_keys" {
#   value       = keys(aws_security_group.my-sg.tags)
#   description = "get all the keys from the tags of the security groups"

# }

# output "tags_values" {
#   value       = values(aws_security_group.my-sg.tags)
#   description = "lis of all the values present in the tags of the aes security group"
# }

# output "allowed_ports" {
#   value       = toset(var.allowed_ports)
#   description = "set of all the allowed ports with unique values"
# }

# output "allowed_ports_length" {
#   value       = length(var.allowed_ports)
#   description = "length of the allowed ports list"
# }

# # output "email" {
# #   value = var.email

# # }

# output "finding_ami_id" {
#   value = lookup(var.ami_map, "us-east-5", "default-ami-id")
# }


# output "finding_instance_type" {
#   value = lookup(var.ec2_instance, "instance_type1", "default_instance_type")
# }
output "port_string" {
  value       = tostring(local.port_string)
  description = "The port number is converted to a string using the tostring function"

}

output "string_to_number" {
  value       = tonumber(local.port_number)
  description = "The port string is converted back to a number using the tonumber function"
}

output "convert_map_to_list" {
  value       = tolist(local.map_as_list)
  description = "use tolist function to convert map to a list"
}

output "convert_list_to_set" {
  value       = toset(local.set)
  description = "convert a list into a set"

}

output "sum" {
  value       = sum(local.sum_of_two_numbers)
  description = "Cacculating sum of two numbers using sum()"
}
