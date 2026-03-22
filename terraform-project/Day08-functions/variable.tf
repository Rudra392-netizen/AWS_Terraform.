variable "env_name" {
  type        = string
  default     = "dev"
  description = "The environment name is dev"

}

variable "app_name" {
  type        = string
  default     = "myapp"
  description = "The name of the application is myapp"
}

variable "allowed_ports" {
  type        = list(number)
  default     = [22, 443, 80, 80]
  description = "the list of allowed ports for the security group"
}

variable "tags_map" {
  type = map(string)
  default = {
    owner        = "rudra"
    project_name = "ml_project"
  }
}
