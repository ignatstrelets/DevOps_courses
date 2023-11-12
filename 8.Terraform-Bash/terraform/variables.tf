variable "instance_size" {
  description = "EC2 instance size"
  validation {
    condition     = contains(["t3.micro", "t3.small"], var.instance_size)
    error_message = "Valid values for var: instance_size are (t3.micro, t3.small)."
  }
  default = "t3.micro"
}

variable "ssh_public_key" {
  description = "SSH public key"
}

variable "public_ip_bool" {
  description = "Public ip enabled/disabled"
  type = bool
  default = false
}

variable "vpc" {
  description = "VPC"
}

variable "instance_name" {
  description = "EC2 instance name"
  default = "wp-node"
}