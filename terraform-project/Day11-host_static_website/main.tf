#create a s3 bucket where our files will be stored
resource "aws_s3_bucket" "example" {
  bucket = "my-devops-site-12345"

}

#Now block all public access for the bucket
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
#Now this bucket becomes secure


#Now upload files in this bucket


resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  index_document {
    suffix = "index.html"
  }
}

#now upload index.html file
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.example.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"

}

#Now upload custom.css file
resource "aws_s3_object" "example" {
  bucket       = aws_s3_bucket.example.id
  key          = "custom.css"
  source       = "custom.css"
  content_type = "text/css"
}

#Now attach the bucket policy
resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.example.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.oai.iam_arn
        },
        Action   = "s3:GetObject",
        Resource = "${aws_s3_bucket.example.arn}/*"
      }
    ]
  })
}


#Create cloudFormation Distribution
# OAI (VERY IMPORTANT)
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for S3"
}

# CloudFront Distribution
resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = aws_s3_bucket.example.bucket_regional_domain_name
    origin_id   = "s3-origin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id = "s3-origin"

    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  depends_on = [aws_s3_bucket.example]
}
