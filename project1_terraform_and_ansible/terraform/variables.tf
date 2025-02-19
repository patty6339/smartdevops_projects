variable "key_pair" {
  description = "EC2 Key Pair for SSH access"
  type        = string
  default     = "forsmartdevops"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
