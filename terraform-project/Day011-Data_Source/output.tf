output "instance_type" {
  value = local.instance_type
}

output "ami_id" {
  value = data.aws_ami.latest.id
}

output "subnet_id" {
  value = data.aws_subnets.subnets.id
}

output "name_of_security_group" {
  value = data.aws_security_group.default.name
}

