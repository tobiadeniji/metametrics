resource "aws_s3_bucket" "meta_bucket" {
  bucket = "meta-s3-bucket"
  acl    = "private"

  versioning {
    enabled = true  # Enable versioning for durability
  }

  lifecycle_rule {
    enabled = true

    noncurrent_version_expiration {
      days = 30  # Delete non-current versions after 30 days
    }
  }

