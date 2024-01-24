variable "project_name" {
  description = "Project name"

}

variable "aws_region" {
  description = "AWS region"
}

variable "ami_id" {
  description = "AMI ID"
}

variable "web_subnet_id" {
  description = "The subnet to launch the web instance on"
}

variable "be_subnet_id" {
  description = "The subnet to launch the backend instance on"
}

variable "web_security_group_id" {
  description = "The security group to launch the web instance in"
}

variable "be_security_group_id" {
  description = "The security group to launch the backend instance in"
}

variable "ssh_key_name" {
  description = "AWS SSH key name"
  default     = "acit_4640"
}

variable "instance_name" {
  description = "Name of EC2 instance"
}

provider "aws" {
  region = var.aws_region
}

variable "db_name" {
  description = "name of database"
}

variable "db_user" {
  description = "name of database user"
}

variable "db_passwd" {
  description = "password of database user"
}

variable "db_engine" {
  description = "database engine"
  default = "mysql"
}

variable "db_version" {
  description = "database version"
  default = "8.0"
}

variable "db_subnet_group_name" {
  description = "The subnet to launch the database instance on"
}

variable "db_security_group_id" {
  description = "The security group to launch the database instance in"
}