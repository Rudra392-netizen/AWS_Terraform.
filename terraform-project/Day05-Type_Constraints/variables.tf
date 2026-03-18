
variable "key_name" {
  description = "Name of existing AWS key pair"
  default     = "docker"
}


variable "Environment" {
  default = "Dev"
  type    = string
}

variable "number_of_instances" {
  description = "Create multiple instances of the same type"
  type        = number
}

variable "monitoring_enabled" {
  description = "Monitoring is Enabled"
  type        = bool
  default     = true
}

variable "associate_public_ip" {
  description = "Associate public ip address with EC2 instances"
  default     = true
  type        = bool
}

variable "instance_type" {
  description = "Tell me the types of instances to use"
  type        = list(string)
  default     = ["t2.micro", "t2.small", "t2.medium"]
}

variable "regions" {
  description = "tell me in which region to create the rescources in"
  type        = list(string)
  default     = ["ap-south-1", "us-east-2", "us-west-1", "us-west-2"]
}
