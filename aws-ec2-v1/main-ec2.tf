locals {
  common_tags = {
    Name = "dev"
  }
}

resource "aws_vpc" "dev_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = local.common_tags
}

resource "aws_subnet" "dev_subnet" {
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.dev_vpc.id
  tags                    = local.common_tags
}

resource "aws_internet_gateway" "dev_internet_gateway" {
  vpc_id = aws_vpc.dev_vpc.id
  tags   = local.common_tags
}

resource "aws_route_table" "dev_route_table" {
  vpc_id = aws_vpc.dev_vpc.id
  tags   = local.common_tags
}

resource "aws_route" "dev_route" {
  route_table_id         = aws_route_table.dev_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dev_internet_gateway.id
}

resource "aws_route_table_association" "dev_route_table_association" {
  subnet_id      = aws_subnet.dev_subnet.id
  route_table_id = aws_route_table.dev_route_table.id
}

resource "aws_security_group" "dev_security_group" {
  name   = "allow tls"
  vpc_id = aws_vpc.dev_vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = local.common_tags
}

resource "aws_key_pair" "dev_key_pair" {
  key_name   = "key_pair"
  public_key = file(var.aws_ec2_aws_key_pair)
  tags       = local.common_tags
}

resource "aws_instance" "dev_instance" {
  availability_zone      = data.aws_availability_zones.available_zones.names[0]
  instance_type          = var.aws_ec2_instance_type
  ami                    = data.aws_ami.ami.id
  key_name               = aws_key_pair.dev_key_pair.id
  vpc_security_group_ids = [aws_security_group.dev_security_group.id]
  subnet_id              = aws_subnet.dev_subnet.id
  user_data              = file(var.user_data)
  count                  = var.aws_instance_count
  root_block_device {
    volume_size = 10
  }
  tags = local.common_tags
  provisioner "local-exec" {
    command = templatefile(var.command_file, {
      hostname     = self.public_ip,
      user         = "ubuntu",
      identityfile = "~/.ssh/id_ed25519"
      }
    )
    interpreter = ["bash", "-c"]
  }
  provisioner "local-exec" {
    when    = destroy
    command = "sed '/^Host ${self.public_ip}$/,/^$/d' ~/.ssh/config > ~/.ssh/config.tmp && mv ~/.ssh/config.tmp ~/.ssh/config"
  }
}