variable "monitoring_enables" {
  description = "Enable the monitoring for the EC2 instance"
  default     = true
  type        = bool
}

variable "instance_type" {
  description = "Tell me the type of instance to use"
  type        = list(string)
  default     = ["t2.micro", "t2.small", "t2.medium"]
}

variable "Environment" {
  description = "Tell me the environment which you want to use"
  default     = "Testing"
}

