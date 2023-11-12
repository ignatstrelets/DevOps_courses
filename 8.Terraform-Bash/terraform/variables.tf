variable "instance_size" {
  description = "EC2 instance size"
  default = "t3.micro"
  validation {
    condition     = contains(["t3.micro", "t3.small"], var.instance_size)
    error_message = "Valid values for var: instance_size are (t3.micro, t3.small)."
  }
}

variable "ssh_public_key" {
  description = "SSH public key"
}

variable "instance_name" {
  description = "EC2 instance name"
}