resource "aws_instance" "web_instances" {
  count          = 3
  ami            = "ami-xxxxxxxxxxxxxxxx"  # Specify the desired AMI
  instance_type  = "t2.micro"  # Specify the desired instance type
  key_name       = var.key_pair # Specify your key pair name
  security_group = [aws_security_group.web_sg.name]

  lifecycle {
    create_before_destroy = true
  }
}
