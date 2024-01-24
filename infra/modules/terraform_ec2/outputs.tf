output "web_ec2_instance_id" {
  value = aws_instance.web_ec2_instance.id
}

output "web_ec2_instance_public_ip" {
  value = aws_instance.web_ec2_instance.public_ip
}

output "web_ec2_instance_public_dns" {
  value = aws_instance.web_ec2_instance.public_dns
}

output "web_ec2_instance_private_ip" {
  value = aws_instance.web_ec2_instance.private_ip
}

output "be_ec2_instance_id" {
  value = aws_instance.be_ec2_instance.id
}

output "be_ec2_instance_public_ip" {
  value = aws_instance.be_ec2_instance.public_ip
}

output "be_ec2_instance_public_dns" {
  value = aws_instance.be_ec2_instance.public_dns
}

output "be_ec2_instance_private_ip" {
  value = aws_instance.be_ec2_instance.private_ip
}

output "db_ec2_instance_id" {
  value = aws_db_instance.rds_instance.id
}

output "db_ec2_endpoint" {
  value = aws_db_instance.rds_instance.address
}
