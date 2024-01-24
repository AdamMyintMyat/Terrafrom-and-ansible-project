provider "aws" {
  region = var.aws_region
}

#Create a VPC
resource "aws_vpc" "a03_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  
  tags = {
    Name="A03 VPC"
    Project = var.project_name
  }
}

#Create a backend subnet
resource "aws_subnet" "be_subnet" {
  cidr_block = var.be_subnet_cidr
  vpc_id     = aws_vpc.a03_vpc.id
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name="A03 Private Subnet"
    Project = var.project_name
  }
}

#Create a webfront subnet
resource "aws_subnet" "web_subnet" {
  cidr_block = var.web_subnet_cidr
  vpc_id     = aws_vpc.a03_vpc.id
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
  
  tags = {
    Name="A03 Public Subnet"
    Project = var.project_name
  }
} 

#Create a database 1 subnet
resource "aws_subnet" "db_1_subnet" {
  cidr_block = var.db_1_subnet_cidr
  vpc_id     = aws_vpc.a03_vpc.id
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "A03 db 1 Subnet"
    Project = var.project_name
  }
} 

#Create a database 2 subnet
resource "aws_subnet" "db_2_subnet" {
  cidr_block = var.db_2_subnet_cidr
  vpc_id     = aws_vpc.a03_vpc.id
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "A03 db 2 Subnet"
    Project = var.project_name
  }
} 

resource "aws_db_subnet_group" "db_subnet_group" {
  name = "a03_subnet_group"
  subnet_ids = [var.db_1_subnet_id, var.db_2_subnet_id]

  tags = {
    Name = "A03 Database subnet group"
    Project = var.project_name
  }
}

#Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id     = aws_vpc.a03_vpc.id
  
  tags = {
    Name="A03 Internet Gateway"
    Project = var.project_name
  }
}

#aws_route_table
resource "aws_route_table" "rt" {
 vpc_id     = aws_vpc.a03_vpc.id

 route {
  cidr_block = var.default_route
  gateway_id = aws_internet_gateway.igw.id
 }
 
 tags = {
    Name="A03 Route Table"
    Project = var.project_name
  }
}

#aws_route_table public association
resource "aws_route_table_association" "web_sg_rt" {
  subnet_id = aws_subnet.web_subnet.id
  route_table_id = aws_route_table.rt.id
}

#aws_route_table private association
resource "aws_route_table_association" "be_sg_rt" {
  subnet_id = aws_subnet.be_subnet.id
  route_table_id = aws_route_table.rt.id
}

#aws_route_table db 1 association
resource "aws_route_table_association" "db_1_sg_rt" {
  subnet_id = aws_subnet.db_1_subnet.id
  route_table_id = aws_route_table.rt.id
}

#aws_route_table db 2 association
resource "aws_route_table_association" "db_2_sg_rt" {
  subnet_id = aws_subnet.db_2_subnet.id
  route_table_id = aws_route_table.rt.id
}