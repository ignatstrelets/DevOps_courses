import {
  to = aws_vpc.existing_vpc
  id = var.vpc
}

resource "aws_vpc" "existing_vpc" {}

data "aws_subnets" "existing_subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.existing_vpc.id]
  }

  tags = {
    Tier = "Public"
  }
}

data "aws_subnet" "public" {
  for_each = toset(data.aws_subnets.existing_subnets.ids)
  id       = each.value
}

resource "aws_key_pair" "web-server-key-pair" {
  key_name   = "web-server-key"
  public_key = var.ssh_public_key
}

resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  vpc_id      = aws_vpc.existing_vpc.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.existing_vpc.cidr_block]
  }
}

resource "aws_security_group" "web-server-sg" {
  name = "web-server-sg"
  vpc_id = aws_vpc.existing_vpc.id

  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = [aws_vpc.existing_vpc.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [aws_vpc.existing_vpc.cidr_block]
  }
}

resource "aws_lb" "web-server-alb" {
  name               = "tf-wordpress-node"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets = [for s in data.aws_subnet.public : s.id]
  enable_deletion_protection = false
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web-server-alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.wordpress.arn
  }
}

resource "aws_lb_listener_rule" "node_rule" {
  listener_arn = aws_lb_listener.http.arn
  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.node.arn
  }
  condition {
    path_pattern {
      values = ["/node/*"]
    }
  }
}

resource "aws_lb_target_group" "wordpress" {
  name = "wordpress"
  port     = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.existing_vpc.id
  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 2
    timeout             = 5
    port                = "80"
    path                = "/wordpress"
    interval            = 30
  }
}

resource "aws_lb_target_group" "node" {
  name = "node"
  port     = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.existing_vpc.id
  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 2
    timeout             = 5
    port                = "80"
    path                = "/node"
    interval            = 30
  }
}

resource "aws_lb_target_group_attachment" "wordpress_attachment" {
  target_group_arn = aws_lb_target_group.wordpress.arn
  target_id        = aws_instance.web-server.id
}

resource "aws_lb_target_group_attachment" "node_attachment" {
  target_group_arn = aws_lb_target_group.node.arn
  target_id        = aws_instance.web-server.id
}

resource "aws_instance" "web-server" {
  ami           = "ami-080b9a28388eeb1cb"
  subnet_id     = "subnet-0aeac58bd1ec5aa27"
  instance_type = var.instance_size
  key_name      = aws_key_pair.web-server-key-pair.key_name
  vpc_security_group_ids = [aws_security_group.web-server-sg.id]
  associate_public_ip_address = var.public_ip_bool
  tags = {
    Name = var.instance_name
  }
}