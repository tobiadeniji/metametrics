resource "aws_s3_bucket" “my_s3_bucket" {
  bucket = “test-bucket"
  acl    = "private"
}
