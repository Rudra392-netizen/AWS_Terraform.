# variable "env_name" {
#   type        = string
#   default     = "dev"
#   description = "The environment name is dev"

# }

# variable "app_name" {
#   type        = string
#   default     = "myapp"
#   description = "The name of the application is myapp"
# }

# variable "allowed_ports" {
#   type        = list(number)
#   default     = [22, 443, 80, 80]
#   description = "the list of allowed ports for the security group"
# }

# variable "tags_map" {
#   type = map(string)
#   default = {
#     owner        = "rudra"
#     project_name = "ml_project"
#   }
# }


# # #How to use validate function in terraform"
# # variable "email" {
# #   type = string
# #   validation {
# #     condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.email))
# #     error_message = "The email must be made from all these words"
# #   }

# # }

# #Lookup function
# variable "ami_map" {
#   type = map(string)
#   default = {
#     us-east-1 = "ami-12345678"
#     us-west-2 = "ami-87654321"
#   }
# }


# variable "ec2_instance" {
#   type = map(string)
#   default = {
#     instance_type1 = "t2.micro"
#     instance_type2 = "t2.small"
#   }
# }


#Type-conversion function in terraform
variable "port" {
  type    = number
  default = 8080

}

#tonumber() which is used to convert any value to a number
variable "port_string" {
  type    = number
  default = "8080"
}

#tolist() which is used to convert any tuple, map into a list
variable "to_map" {
  type = map(string)
  default = {
    value1 = "t2.micro"
    value2 = "t2.small"
  }
}

#toset() which is used to convert any list to a set
variable "list" {
  type    = list(number)
  default = [10, 20, 30, 40, 40]
}

#how to use sum() in terraform
variable "sum" {
  type    = list(number)
  default = [10, 20, 30, 40]
}
