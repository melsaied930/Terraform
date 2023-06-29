resource "aws_vpc" "dev_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "dev_vpc"
  }
}

resource "aws_subnet" "dev_subnet" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  # availability_zone       = var.aws_ec2_availability_zone
  tags = {
    "Name" = "dev_subnet"
  }
}

resource "aws_internet_gateway" "dev_internet_gateway" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    "Name" = "dev_internet_gateway"
  }
}

resource "aws_route_table" "dev_route_table" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    "Name" = "dev_route_table"
  }
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
  name        = "allow tls"
  description = "allow tls inbound traffic"
  vpc_id      = aws_vpc.dev_vpc.id
  ingress {
    description = "TLS from VPC"
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
  tags = {
    "Name" = "dev_security_group"
  }
}

resource "aws_key_pair" "dev_key_pair" {
  key_name   = "key_pair"
  public_key = file(var.aws_ec2_aws_key_pair)
  tags = {
    "Name" = "dev_key_pair"
  }
}

resource "aws_instance" "dev_instance" {
  instance_type          = var.aws_ec2_instance_type
  ami                    = data.aws_ami.dev_ami.id
  key_name               = aws_key_pair.dev_key_pair.id
  vpc_security_group_ids = [aws_security_group.dev_security_group.id]
  subnet_id              = aws_subnet.dev_subnet.id
  user_data              = file(var.aws_ec2_user_data)
  root_block_device {
    volume_size = 10
  }
  tags = {
    "Name" = "dev_instance"
  }
  provisioner "local-exec" {
    command = templatefile("../ssh-config/ssh_linux_config.tpl", {
      hostname     = self.public_ip,
      user         = "ubuntu",
      identityfile = "~/.ssh/id_ed25519"
      }
    )
    interpreter = ["bash", "-c"]
  }
  # provisioner "local-exec" {
  #   command = "rm -f ~/.ssh/config"
  #   when    = destroy
  # }
}

# resource "aws_eip" "dev_aws_eip" {
#   instance = aws_instance.dev_instance.id
#   vpc      = true
#   tags = {
#     Name = "dev_aws_eip"
#   }
# }
