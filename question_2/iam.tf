# IAM Role for Cross-Region Replication
resource "aws_iam_role" "replication_role" {
  name = "s3-replication-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# IAM Policy for Cross-Region Replication
resource "aws_iam_policy" "replication_policy" {
  name        = "s3-replication-policy"
  description = "Policy for S3 cross-region replication"
  
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:GetBucketVersioning",
      "Resource": "${aws_s3_bucket.meta_bucket.arn}"
    },
    {
      "Effect": "Allow",
      "Action": "s3:PutReplicationConfiguration",
      "Resource": "${aws_s3_bucket.meta_bucket.arn}"
    }
  ]
}
EOF
}

# Attach IAM Policy to IAM Role
resource "aws_iam_role_policy_attachment" "replication_policy_attachment" {
  policy_arn = aws_iam_policy.replication_policy.arn
  role       = aws_iam_role.replication_role.name
}
