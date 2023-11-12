resource "aws_launch_template" "ubuntu-nginx" {
  image_id = "ami-077f3abe5acce17a0"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.asg-sg.id]
  key_name = aws_key_pair.deployer.key_name
}

resource "aws_autoscaling_group" "asg" {
  max_size = 4
  min_size = 1
  desired_capacity = 1
  default_cooldown = 120
  launch_template {
    id = aws_launch_template.ubuntu-nginx.id
  }
  vpc_zone_identifier = [aws_subnet.public-a.id, aws_subnet.public-b.id]
  load_balancers = [aws_elb.elb.id]
}

resource "aws_autoscaling_policy" "increment" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  name = "increment"
  policy_type = "StepScaling"
  adjustment_type = "ChangeInCapacity"
  step_adjustment {
    metric_interval_lower_bound = 0
    scaling_adjustment = 1
  }
}

resource "aws_autoscaling_policy" "decrement" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  name = "decrement"
  policy_type = "StepScaling"
  adjustment_type = "ChangeInCapacity"
  step_adjustment {
    metric_interval_lower_bound = 0
    scaling_adjustment = -1
  }
}

resource "aws_cloudwatch_metric_alarm" "greater_than_70" {
  alarm_name          = "greater_than_70"
  namespace   = "AWS/EC2"
  metric_name         = "CPUUtilization"
  statistic = "Average"
  threshold = 70
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  period = 120
  alarm_actions = [aws_autoscaling_policy.increment.arn]
}

resource "aws_cloudwatch_metric_alarm" "less_than_15" {
  alarm_name          = "less_than_15"
  namespace   = "AWS/EC2"
  metric_name         = "CPUUtilization"
  statistic = "Average"
  threshold = 15
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  period = 120
  alarm_actions = [aws_autoscaling_policy.decrement.arn]
}