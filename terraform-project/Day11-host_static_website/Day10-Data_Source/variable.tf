variable "environment" {
  type    = string
  default = "dev"
}

variable "instance_type" {
  type = map(string)
  default = {
    dev  = "t2.micro"
    prod = "t2.medium"
  }
}
