variable "aws_region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "project_name" {
  description = "Assignment 3"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  default     = "192.168.0.0/16"
}

variable "be_subnet_cidr" {
  description = "Private Subnet CIDR"
  default     = "192.168.1.0/24"
}

variable "web_subnet_cidr" {
  description = "Public Subnet CIDR"
  default     = "192.168.2.0/24"
}

variable "default_route"{
  description = "Default route"
  default     = "0.0.0.0/0"
}

variable "home_net" {
  description = "Home network"
  default     = "24.84.0.0/16"
}

variable "bcit_net" {
  description = "BCIT network"
  default     = "142.232.0.0/16"
  
}

variable "ami_id" {
  description = "AMI ID"
  default = "data.aws_ami.ubuntu.id"
}

variable "ssh_key_name"{
  description = "AWS SSH key name"
  default = "acit_4640"
}

variable "db_name" {
  description = "Database name"
  default = "a03_db"
}

variable "db_user" {
  description = "Database username"
  default = "adam"
}

variable "db_passwd" {
  description = "Database password"
  default = "secure123"
}