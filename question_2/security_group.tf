# Create a security group allowing incoming traffic on port 80
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow incoming traffic on port 80"
  
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow database traffic"
  
  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    security_groups = [aws_security_group.default.id]
  }
}
