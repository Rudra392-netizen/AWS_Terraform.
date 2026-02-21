output "instance_id" {
  description = "Tells the ID of your EC2 Instance"
  value       = aws_instance.simple_ec2.id

}

output "s3_bucket_id" {
  description = "Tell me the s3 bucket Id"
  value       = aws_s3_bucket.example.bucket_domain_name
}

output "instance_type" {
  description = "Tell me the type of instance we are using"
  value       = aws_instance.simple_ec2.instance_type
}

