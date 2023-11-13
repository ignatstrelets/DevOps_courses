resource "aws_instance" "web-server-a" {
  subnet_id = aws_subnet.public-a.id
  ami           = "ami-077f3abe5acce17a0"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [ aws_security_group.asg-sg.id ]
  tags = {
    Name = "web-server-a"
  }
}

