#resource "aws_instance" "web-server-a" {
#  subnet_id = aws_subnet.public-a.id
#  ami           = "ami-08766f81ab52792ce"
#  instance_type = "t3.micro"
#  key_name      = "ignat-vpc"
#  vpc_security_group_ids = [ aws_security_group.xxxxx.id ]
#  tags = {
#    Name = "web-server-a"
#  }
#}
#
