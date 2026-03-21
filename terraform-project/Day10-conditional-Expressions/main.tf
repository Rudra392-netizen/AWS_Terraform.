# Today we are learning about conditional expression in terraform.
# 1. if-else condition in terraform is written as below:

variable "env" {
  default = "dev"
}

resource "aws_instance" "example" {
  ami           = "ami-07062e2a343acc423" # (us-east-2 region)
  instance_type = var.env == "dev" ? "t2.medium" : "t2.micro"



  tags = {
    Name = "rudra-ec2-instance"
  }
}


#If you want to enable or disable monitoring for the ec2 instance based on the environment used:
variable "enable_monitoring" {
  default = true

}
resource "aws_instance" "example2" {
  ami = "ami-07062e2a343acc423" # (us-east-2 region)

  instance_type = var.env == "prod" ? "t2.medium" : "t2.micro"
  monitoring    = var.enable_monitoring ? true : false

  tags = {
    Name = "rudra-ec2-instance2"
  }
}


# Dynamic blocks in terrafrom are used to create multiple blocks of the same type based on the number of items in the list"
variable "ports" {
  default = [80, 443, 22]
}

resource "aws_security_group" "example" {
  name = "my-sg"

  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}

# 2nd aws_security_group with dynamic block
variable "ports1" {
  default = [3306, 8080, 6379]

}

resource "aws_security_group" "example2" {
  name = "my-sg2"

  dynamic "ingress" {
    for_each = var.ports1
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}


# How to use splat expressions to get the IP addresses of all the EC2 instances created using count or for_each"

# Task 1 create 2 ec2 instances and create a security group and attach the security group to the ec2 instances. The security group should have 3 ingress rules for ports 80, 22 and 443.
variable "ports4" {
  default = [80, 22, 443]
}

resource "aws_security_group" "example3" {
  name = "my-sg3"

  dynamic "ingress" {
    for_each = var.ports4
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

resource "aws_instance" "example3" {


  count         = 2
  ami           = "ami-07062e2a343acc423"
  instance_type = "t2.micro"
  key_name      = "docker"

  vpc_security_group_ids = [aws_security_group.example3.id]

  tags = {
    Name              = "rudra-new-ec2-${count.index}"
    enable_monitoring = "true" #   }
  }
}

output "ids" {
  value = aws_instance.example3[*].id
}

output "public_ips" {
  value = aws_instance.example3[*].public_ip
}

# “Create Multiple EC2 Instances with different names Using for_each”

variable "instances" {
  default = {
    web = "t2.micro"
    app = "t2.small"
  }
}
resource "aws_instance" "example4" {
  for_each      = var.instances
  ami           = "ami-07062e2a343acc423"
  instance_type = each.value
  key_name      = "docker"
  monitoring    = true

  tags = {
    name = each.key

  }
}
