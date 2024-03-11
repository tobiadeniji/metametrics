resource "aws_autoscaling_group" "web_autoscaling_group" {
  desired_capacity     = 3
  max_size             = 5
  min_size             = 1
  launch_configuration = aws_launch_configuration.web_launch_config.id

  vpc_zone_identifier = ["subnet-xxxxxxxxxxxxxxxx"]  # Specify your subnet IDs

  tag {
    key                 = "Name"
    value               = "web-instance"
    propagate_at_launch = true
  }
}
