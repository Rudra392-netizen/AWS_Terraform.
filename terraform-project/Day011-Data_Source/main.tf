data "aws_ami" "latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
  owners = ["amazon"]
}

#Get the default vpc_id
data "aws_vpc" "default" {
  default = true
}

#Get subnet from that vpc
data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
#Now get the exisiting security group
data "aws_security_group" "default" {
  name = "default"
}

#Use lookup to select the instance_type
locals {
  instance_type = lookup(var.instance_type, var.environment, "t2.micro")
}

#Create ec2 instance using all these existing resources
resource "aws_instance" "app" {
  ami                    = data.aws_ami.latest.id
  instance_type          = local.instance_type
  subnet_id              = data.aws_subnets.subnets.ids[0]
  vpc_security_group_ids = [data.aws_security_group.default.id]

  tags = {
    Name = "${var.environment}-server"
  }
}

