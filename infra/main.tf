module "vpc" {
  source       = "./modules/terraform_vpc"
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  be_subnet_cidr  = var.be_subnet_cidr
  web_subnet_cidr = var.web_subnet_cidr
  db_1_subnet_id = module.vpc.db_1_subnet_id
  db_2_subnet_id = module.vpc.db_2_subnet_id
  home_net     = var.home_net
  aws_region   = var.aws_region
}

#Security group
module "sg"{
  source = "./modules/terraform_security_group"
  be_sg_name = "backend security group name"
  be_sg_description = "Allow inbound traffic from BCIT and Home"
  web_sg_name = "web security group name"
  web_sg_description = "Allow inbound traffic from anywhere"
  db_1_sg_name = "Database security group name"
  db_1_sg_description = "Allow 3306 traffic from subnet"
  project_name = var.project_name
  vpc_id = module.vpc.vpc_id
  be_ingress_rules = [
    {
      description = "ssh access from home"
      ip_protocol = "tcp"
      from_port = 22
      to_port = 22
      cidr_ipv4 = var.home_net
      rule_name = "ssh_access_home"
    },
    {
      description = "ssh access from bcit"
      ip_protocol = "tcp"
      from_port = 22
      to_port = 22
      cidr_ipv4 = var.bcit_net
      rule_name = "ssh_access_bcit"
    },
    {
      description = "all traffic from within VPC"
      ip_protocol = "-1"
      from_port = 0
      to_port = 0
      cidr_ipv4 = var.vpc_cidr
      rule_name = "all_VPC_traffic"
    }
   ]
  be_egress_rules = [ 
    {
      description = "allow all egress traffic"
      ip_protocol = "-1"
      cidr_ipv4 = var.default_route
      rule_name = "allow_all_egress"
    }
   ]
  web_ingress_rules = [
    {
      description = "443 access from anywhere"
      ip_protocol = "tcp"
      from_port = 443
      to_port = 443
      cidr_ipv4 = var.default_route
      rule_name = "443_access_anywhere"
    },
    {
      description = "ssh access from home"
      ip_protocol = "tcp"
      from_port = 22
      to_port = 22
      cidr_ipv4 = var.home_net
      rule_name = "ssh_access_home"
    },
    {
      description = "ssh access from bcit"
      ip_protocol = "tcp"
      from_port = 22
      to_port = 22
      cidr_ipv4 = var.bcit_net
      rule_name = "ssh_access_bcit"
    },
    {
      description = "80 traffic from anywhere"
      ip_protocol = "tcp"
      from_port = 80
      to_port = 80
      cidr_ipv4 = var.default_route
      rule_name = "80_access_anywhere"
    },
    {
    description = "all traffic from backend subnet"
      ip_protocol = "-1"
      from_port = 0
      to_port = 0
      cidr_ipv4 = var.be_subnet_cidr
      rule_name = "all_backend_subnet_traffic"
    }
   ]
  web_egress_rules = [ 
    {
      description = "allow all egress traffic"
      ip_protocol = "-1"
      from_port = 0
      to_port = 0
      cidr_ipv4 = var.default_route
      rule_name = "allow_all_egress"
    }
   ]
   db_1_ingress_rules = [
    {
      description = "3306 access from subnet"
      ip_protocol = "tcp"
      from_port = 3306
      to_port = 3306
      cidr_ipv4 = var.be_subnet_cidr
      rule_name = "3306_from_backend_subnet"
    },
   ]
  db_1_egress_rules = [ 
    {
      description = "allow all egress traffic"
      ip_protocol = "tcp"
      from_port = 3306
      to_port = 3306
      cidr_ipv4 = var.be_subnet_cidr
      rule_name = "3306_to_backend_subnet"
    }
   ]
}

#EC2
module "ec2" {
  source = "./modules/terraform_ec2"
  instance_name = "Backend_server"
  project_name = var.project_name

  web_subnet_id = module.vpc.web_subnet_id
  web_security_group_id = module.sg.web_security_group_id

  be_subnet_id = module.vpc.be_subnet_id
  be_security_group_id = module.sg.be_security_group_id

  db_subnet_group_name = module.vpc.db_subnet_group_name
  db_security_group_id = module.sg.db_security_group_id
  db_name = var.db_name
  db_user = var.db_user
  db_passwd = var.db_passwd

  aws_region = var.aws_region
  ami_id = var.ami_id
  ssh_key_name = var.ssh_key_name
}

resource "local_file" "backend_ansible_config" {
  content = <<EOF
---
  backend_service_file: etc/systemd/system/backend.service
  backend_username: backend
  backend_group: backend
  db_name: "${var.db_name}"
  db_user: "${var.db_user}"
  db_passwd: "${var.db_passwd}"
  db_host: "${module.ec2.db_ec2_endpoint}"
  table_name: item

EOF

  filename = "../ansible/roles/backend/vars/main.yml"

}

resource "local_file" "web_ansible_config" {
  content = <<EOF
---
  backend_base_url : "http://${module.ec2.be_ec2_instance_public_dns}:5000"
  web_root_directory: /etc/nginx/sites-available/

EOF

  filename = "../ansible/roles/web/vars/main.yml"

}