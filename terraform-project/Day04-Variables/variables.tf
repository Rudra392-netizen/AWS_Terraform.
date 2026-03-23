
variable "key_name" {
  description = "Name of existing AWS key pair"
  default     = "docker"
}


variable "Environment" {
  default = "Dev"
  type    = string
}

variable "instance_type" {
  description = "The type of instance that you want to use"
  type        = string
}
