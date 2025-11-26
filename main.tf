# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

# 1. Create the S3 bucket
resource "aws_s3_bucket" "public_bucket" {
  bucket = "aviz-hcp-test"
  tags = {
    Environment = "PublicAccessDemo"
  }
}

# 2. Disable public access blocks at the bucket level
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.public_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

}
