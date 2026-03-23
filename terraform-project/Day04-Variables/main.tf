resource "aws_s3_bucket" "example" {
  bucket = "rudra-tf-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "${var.Environment}"
  }
}


# Create EC2 Instance

resource "aws_instance" "simple_ec2" {
  ami           = "ami-0198cdf7458a7a932" # Ubuntu Linux LTS (Mumbai region)
  instance_type = var.instance_type
  key_name      = var.key_name

}

