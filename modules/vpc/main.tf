locals {
  common_tags = {
    Name = "module-vpc-${var.project_name}"
  }
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_dns_support   = var.vpc_enable_dns_support
  tags                 = local.common_tags
}

resource "aws_subnet" "subnet" {
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = var.subnet_map_public_ip_on_launch
  vpc_id                  = aws_vpc.vpc.id
  tags                    = local.common_tags
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags   = local.common_tags
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  tags   = local.common_tags
}

resource "aws_route" "route" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = var.route_destination_cidr_block
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "security_group" {
  name   = var.project_name
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = var.security_group_from_port
    to_port     = var.security_group_to_port
    protocol    = var.security_group_protocol
    cidr_blocks = var.security_group_cidr_blocks
  }

  egress {
    from_port   = var.security_group_from_port
    to_port     = var.security_group_to_port
    protocol    = var.security_group_protocol
    cidr_blocks = var.security_group_cidr_blocks
  }

  tags = local.common_tags
}