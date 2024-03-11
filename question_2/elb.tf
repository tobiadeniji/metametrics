# Elastic Load Balancer
resource "aws_elb" "web_elb" {
  name               = "web-elb"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]  

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  instances = aws_instance.web_instances[*].id
}
