resource "aws_launch_configuration" "web_launch_config" {
  name = "web_launch_config"
  image_id = var.ami_id  # Specify the desired Amazon Machine Image (AMI)
  instance_type = "t2.micro"  # Specify the desired instance type
  
  security_groups = [aws_security_group.web_sg.name]

  lifecycle {
    create_before_destroy = true
  }
}
