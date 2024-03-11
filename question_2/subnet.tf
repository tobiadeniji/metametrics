# Subnet Group for Multi-AZ deployment
subnet_group_name = "meta-subnet-group"
subnet_ids        = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.meta_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet_b" {
  vpc_id     = aws_vpc.meta_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}
