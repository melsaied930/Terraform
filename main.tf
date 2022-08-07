resource "aws_vpc" "dev_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "name" = "dev_vpc"
  }
}

resource "aws_subnet" "dev_subnet" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"
  tags = {
    "name" = "dev_subnet"
  }
}

resource "aws_internet_gateway" "dev_internet-gateway" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    "name" = "dev_internet-gateway"
  }
}

resource "aws_route_table" "dev_route-table" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    "name" = "dev_route-table"
  }
}

resource "aws_route" "dev_route" {
  route_table_id         = aws_route_table.dev_route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dev_internet-gateway.id
}

resource "aws_route_table_association" "dev_route-table-association" {
  subnet_id      = aws_subnet.dev_subnet.id
  route_table_id = aws_route_table.dev_route-table.id
}

resource "aws_security_group" "dev_security-group" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
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
}

resource "aws_key_pair" "dev_key-pair" {
  key_name   = "key-pair-2"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "dev_instance" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.dev_ami.id
  key_name               = aws_key_pair.dev_key-pair.id
  vpc_security_group_ids = [aws_security_group.dev_security-group.id]
  subnet_id              = aws_subnet.dev_subnet.id
  user_data              = file("templates/userdata.tpl")
  tags = {
    "name" = "dev_instance"
  }
  provisioner "local-exec" {
    command = templatefile("${var.command}", {
      hostname = self.public_ip,
      user     = "ubuntu",
    identityfile = "~/.ssh/id_ed25519" })
  }
  provisioner "local-exec" {
    command = "rm -f ~/.ssh/config"
    when    = destroy
  }
}