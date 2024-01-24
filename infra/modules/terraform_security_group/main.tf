#Backend security group
resource "aws_security_group" "be_sg" {
  name        = var.be_sg_name
  description = var.be_sg_description
  vpc_id      = var.vpc_id
  tags = {
    Name    = var.be_sg_name
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "be_ingress" {
  for_each          = {
    for index, rule in var.be_ingress_rules: 
    rule.rule_name => rule
  }

  description       = each.value.description
  ip_protocol       = each.value.ip_protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  cidr_ipv4         = each.value.cidr_ipv4
  security_group_id = aws_security_group.be_sg.id
  tags = {
    Name    = each.value.rule_name
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_egress_rule" "be_egress_rule" {
  for_each          = {
    for index, rule in var.be_egress_rules: 
    rule.rule_name => rule
  }

  security_group_id = aws_security_group.be_sg.id
  ip_protocol       = each.value.ip_protocol
  cidr_ipv4         = each.value.cidr_ipv4
  tags = {
    Name    = each.value.rule_name
    Project = var.project_name
  }
}
#Web security group
resource "aws_security_group" "web_sg" {
  name        = var.web_sg_name
  description = var.web_sg_description
  vpc_id      = var.vpc_id
  tags = {
    Name    = var.web_sg_name
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "web_ingress" {
  for_each          = {
    for index, rule in var.web_ingress_rules: 
    rule.rule_name => rule
  }

  description       = each.value.description
  ip_protocol       = each.value.ip_protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  cidr_ipv4         = each.value.cidr_ipv4
  security_group_id = aws_security_group.web_sg.id
  tags = {
    Name    = each.value.rule_name
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_egress_rule" "web_egress_rule" {
  for_each          = {
    for index, rule in var.web_egress_rules: 
    rule.rule_name => rule
  }

  security_group_id = aws_security_group.web_sg.id
  ip_protocol       = each.value.ip_protocol
  cidr_ipv4         = each.value.cidr_ipv4
  tags = {
    Name    = each.value.rule_name
    Project = var.project_name
  }
}

#Database security group
resource "aws_security_group" "db_1_sg" {
  name        = var.db_1_sg_name
  description = var.db_1_sg_description
  vpc_id      = var.vpc_id
  tags = {
    Name    = var.be_sg_name
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "db_1_ingress" {
  for_each          = {
    for index, rule in var.db_1_ingress_rules: 
    rule.rule_name => rule
  }

  description       = each.value.description
  ip_protocol       = each.value.ip_protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  cidr_ipv4         = each.value.cidr_ipv4
  security_group_id = aws_security_group.db_1_sg.id
  tags = {
    Name    = each.value.rule_name
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_egress_rule" "db_1_egress_rule" {
  for_each          = {
    for index, rule in var.db_1_egress_rules: 
    rule.rule_name => rule
  }

  description       = each.value.description
  ip_protocol       = each.value.ip_protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  cidr_ipv4         = each.value.cidr_ipv4
  security_group_id = aws_security_group.db_1_sg.id
  tags = {
    Name    = each.value.rule_name
    Project = var.project_name
  }
}