#create a s3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "rudra-tf-bucket-98188"

  tags = {
    Name        = "My bucket"
    Environment = var.Environment
  }
}

#Create an EC2 instance and understand how to use count()
resource "aws_instance" "simple_ec2" {
  count         = 2
  ami           = "ami-07062e2a343acc423"
  instance_type = var.instance_type[count.index]
  key_name      = "docker"

  monitoring                  = var.monitoring_enables
  associate_public_ip_address = true

  tags = {
    Name = "rudra-simple-ec2"
  }
}


#How to use depende_on to create a dependency between two resources
resource "aws_s3_bucket" "example2" {
  bucket = "rudra-25050"

  tags = {
    Name        = "demo-bucket"
    Environment = var.Environment
  }
}

#Now we want to create an EC2 instance only after the S3 bucket is created. For that we will use the depends_on meta-argument
resource "aws_instance" "simple_ec22" {
  ami           = "ami-07062e2a343acc423"
  instance_type = "t2.micro"
  key_name      = "docker"

  monitoring                  = var.monitoring_enables
  associate_public_ip_address = true

  tags = {
    Name = "rudra-simple-ec22"
  }

  depends_on = [aws_s3_bucket.example2]
}


