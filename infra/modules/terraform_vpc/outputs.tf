output "vpc_id" {
  value = aws_vpc.a03_vpc.id
}

output "be_subnet_id" {
  value = aws_subnet.be_subnet.id
}

output "web_subnet_id" {
  value = aws_subnet.web_subnet.id
}

output "db_1_subnet_id" {
  value = aws_subnet.db_1_subnet.id
}

output "db_2_subnet_id" {
  value = aws_subnet.db_2_subnet.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.db_subnet_group.name
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "rt_id" {
  value = aws_route_table.rt.id
}