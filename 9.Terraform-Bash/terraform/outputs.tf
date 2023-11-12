output "instance_public_ip" {
  value = aws_instance.web-server.public_ip
}

output "alb_domain_name" {
  value = aws_lb.web-server-alb.dns_name
}
