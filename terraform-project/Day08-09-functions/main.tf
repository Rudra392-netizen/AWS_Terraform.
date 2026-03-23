# #Convert the env and app_name into uppercase and concatenate them with a hyphen in between"
# locals {
#   env_app_name   = upper(var.env_name)
#   app_user       = upper(var.app_name)
#   env_app_concat = "${local.env_app_name}-${local.app_user}"
# }

# #securtiyu group with dynamic ingress rules using the allowed_ports variable"
# resource "aws_security_group" "my-sg" {
#   name        = local.env_app_concat
#   description = "security group for ${local.env_app_concat} in ${var.env_name} environment"


#   #combining the variable tags with additional tags for the environment"
#   tags = merge(var.tags_map, {
#     environment = var.env_name
#     application = var.app_name
#   })


#   dynamic "ingress" {
#     for_each = var.allowed_ports
#     content {
#       from_port   = ingress.value
#       to_port     = ingress.value
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }
# }

# #max and the min functions to get the maximum and minimum port number from the allowed_ports variable"
# locals {
#   max_port = max(20, 443, 80)
#   min_port = min(20, 443, 80)
# }

# #Find the length of all the allowed ports using the length function"
# locals {
#   allowed_ports = length(var.allowed_ports)
# }

# # locals {
# #   call_email = var.email
# # }


# locals {
#   ami_id = lookup(var.ami_map, "us-east-5", "default-ami-id")
# }

# locals {
#   type_of_instance = lookup(var.ec2_instance, "instance_type1", "default_instance_type")
# }

locals {
  port_string = tostring(var.port)
}


locals {
  port_number = tonumber(var.port_string)
}

locals {
  map_as_list = values(var.to_map)
}

locals {
  set = toset(var.list)
}
