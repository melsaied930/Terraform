data "aws_ami" "ami" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
}

data "aws_availability_zones" "available_zones" {
  state = "available"
  filter {
    name   = "region-name"
    values = [var.aws_ec2_availability_zone]
  }
}