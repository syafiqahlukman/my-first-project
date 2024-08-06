variable "aws_access_key" {
  description = "The AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "The AWS secret key"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-southeast-1"
}

variable "instance_type" {
  description = "The type of instance to deploy"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-060e277c0d4cce553"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}