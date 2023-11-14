resource "aws_elb" "elb" {
  name               = "tf-elb"
  subnets = [aws_subnet.public-a.id, aws_subnet.public-b.id]
  cross_zone_load_balancing = true
  idle_timeout = 60
  connection_draining = true
  security_groups = [aws_security_group.elb-sg.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 2
    timeout             = 4
    target              = "HTTP:80/index.html"
    interval            = 5
  }
  tags = {
    Name = "tf-elb"
  }
}