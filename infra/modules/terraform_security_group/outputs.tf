output "web_security_group_id" {
  value = aws_security_group.web_sg.id
}

output "be_security_group_id" {
  value = aws_security_group.be_sg.id
}

output "db_security_group_id" {
  value = aws_security_group.db_1_sg.id
}