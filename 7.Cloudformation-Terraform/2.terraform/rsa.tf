resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "<id_rsa.pub>"
}