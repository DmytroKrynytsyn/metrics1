variable "aws_region" {
  description = "The AWS region to launch resources in."
}

variable "availability_zone" {
  description = "The availability zone to launch the EC2 instance in."
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance."
}

variable "instance_type" {
  description = "The instance type to use for the EC2 instance."
}

variable "my_ip" {
  description = "The CIDR allowed to access the instance."
  default     = "89.247.166.172/32"  # Replace with your actual IP address
}
