output "vpc_id" {
  value = module.vpc.vpc_id
}

output "web_subnet" {
  value = module.vpc.web_subnet_id

}

output "be_subnet" {
  value = module.vpc.be_subnet_id

}

output "igw" {
  value = module.vpc.igw_id
}

output "rt_1" {
  value = module.vpc.rt_id
}

output "web_sg" {
  value = module.sg.web_security_group_id
}

output "be_sg" {
  value = module.sg.be_security_group_id
}

output "web_instance_id" {
  value = module.ec2.web_ec2_instance_id
}

output "be_instance_id" {
  value = module.ec2.be_ec2_instance_id
}

output "web_instance_public_ip" {
  value = module.ec2.web_ec2_instance_public_ip
}

output "web_instance_private_ip" {
  value = module.ec2.web_ec2_instance_private_ip
}

output "web_instance_public_dns" {
  value = module.ec2.web_ec2_instance_public_dns
}

output "be_instance_public_ip" {
  value = module.ec2.be_ec2_instance_public_ip
}

output "be_instance_private_ip" {
  value = module.ec2.be_ec2_instance_private_ip
}

output "be_instance_public_dns" {
  value = module.ec2.be_ec2_instance_public_dns
}

output "db_instance_ip" {
  value = module.ec2.db_ec2_endpoint
}

output "backend_base_url" {
  value = "http://${module.ec2.be_ec2_instance_public_dns}:5000"
}