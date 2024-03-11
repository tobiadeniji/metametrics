resource "aws_db_instance" “meta_rds" {
  identifier           = "meta-rds"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = “metadb"
  username             = "admin"
  password             = var.db_password
  publicly_accessible  = false
  multi_az             = true  # Multi-AZ for high availability
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

scaling_configuration {
    auto_pause               = true
    max_capacity             = 2
    min_capacity             = 1
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }

  lifecycle {
    create_before_destroy = true
  }

# Enable cross-region replication for high availability
  replication_configuration {
    role           = aws_iam_role.replication_role.arn
    destination {
      bucket        = "arn:aws:s3:::meta-s3-bucket-replica"
      storage_class = "STANDARD"
    }
  }


