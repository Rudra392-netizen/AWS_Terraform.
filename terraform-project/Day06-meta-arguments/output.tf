output "instance_type" {
  description = "Tell me which instnace type we are using"
  value       = aws_instance.simple_ec2[*].instance_type
}

output "Environment" {
  description = "Tell mw which environment we are using"
  value       = aws_s3_bucket.example.tags["Environment"]
}

