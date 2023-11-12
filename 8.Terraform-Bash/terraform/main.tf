resource "aws_key_pair" "web-server-key-pair" {
  key_name   = "web-server-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDUIYUIxNxDPssYRvWLyZuL/C17HrAT9OVn34MX0V4CKNqcloy5n/6ZnrdivwpwG1RvB17OfK8f90IPWOP2c3IPlKSycBU9Ey3VzYQOBSo4bx3d8e6bHQk/kj/XpY9N2cYpqvu70krm5urnqJYCYdg4tA623osRNDMuMAFX0iCgLuO+ZDAA2hGr8uh1GZihlE6ggERgqL3EFcTKYpIiiGYCTxJnd0P1BmZLJwI2hRBU6LzR6F1uolqReJnRC7t/hIaPa7DLQCHSAt10W+37Fy1qoVG2UP+1UrtHTzaBXRa3ZXpm71k7r266w+IiA4Wn3+cfvViHPpVovbFtLZ6moHLMhNrCj1KcDexBdDvBPili+6+TGwjM6+QR6++USvyWTVkb4CB5nvF4VEtbrX9fQoipEUd0VY+LsHu5yTcfAYmqO+oHd5mpYZcQ4GNRP1Nw4vU3HHMWL1V+coYDBMWeME/zP/PLg1zP4IfjBS+otdRm8h0BSMWx5lkrQu2YXLVrWDk="
}

#resource "aws_alb" "" {}

resource "aws_instance" "web-server" {
  ami           = "ami-0e339d7c1ad39ea85"
  instance_type = var.instance_size
  key_name      = aws_key_pair.web-server-key-pair.key_name
  vpc_security_group_ids = ["sg-0034b0b24ce1f56c8"]
  tags = {
    Name = var.instance_name
  }
}