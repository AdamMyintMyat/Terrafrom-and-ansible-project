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

variable "db_1_subnet_cidr" {
  description = "db 1 network"
  default     = "192.168.3.0/24"
}

variable "db_2_subnet_cidr" {
  description = "db 2 network"
  default     = "192.168.4.0/24"
}

variable "db_1_subnet_id" {
  description = "db 1 network"
}

variable "db_2_subnet_id" {
  description = "db 2 network"
}