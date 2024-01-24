data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}



resource "aws_instance" "be_ec2_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t3.micro"
  key_name        = var.ssh_key_name
  subnet_id       = var.be_subnet_id
  security_groups = [var.be_security_group_id]
  tags = {
    Name    = "a03_backend_server"
    Project = var.project_name
  }
}

resource "aws_instance" "web_ec2_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t3.micro"
  key_name        = var.ssh_key_name
  subnet_id       = var.web_subnet_id
  security_groups = [var.web_security_group_id]
  tags = {
    Name    = "a03_web_server"
    Project = var.project_name
  }
}

resource "aws_db_instance" "rds_instance" {
  allocated_storage    = 5
  db_name              = var.db_name
  engine               = var.db_engine
  instance_class       = "db.t2.micro"
  username             = var.db_user
  password             = var.db_passwd
  engine_version       = var.db_version
  db_subnet_group_name = var.db_subnet_group_name
  vpc_security_group_ids = [var.db_security_group_id]
  skip_final_snapshot = true
  port = 3306
  tags = {
    Name    = "a03_database_server"
    Project = var.project_name
  }
}
