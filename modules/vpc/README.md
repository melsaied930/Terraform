# AWS VPC Terraform Module
Creating default 
- aws_vpc
- aws_subnet
- aws_internet_gateway
- aws_route_table
- aws_route"
- aws_route_table_association"
- aws_security_group

## Usage
~~~
locals {
  common_tags = {
    Name = "module-vpc-${module.vpc.project_name}"
  }
}

module "vpc" {
  source = "../modules/vpc"
  or
  source = "github.com/melsaied930/Terraform/modules/vpc"
  region = "us-east-1"
}

resource "aws_instance" "instance" {
  availability_zone      = module.vpc.aws_subnet_availability_zone
  vpc_security_group_ids = [module.vpc.security_group_id]
  subnet_id              = module.vpc.aws_subnet_id
}
~~~

## Variables
~~~
project_name
region
vpc_cidr_block
vpc_enable_dns_hostnames
vpc_enable_dns_support
subnet_cidr_block
subnet_map_public_ip_on_launch
route_destination_cidr_block
security_group_from_port
security_group_to_port
security_group_protocol
security_group_cidr_blocks
~~~

## Outputs 
~~~
region
project_name
aws_subnet_id
security_group_id
aws_subnet_availability_zone
aws_subnet.subnet.availability_zone
~~~