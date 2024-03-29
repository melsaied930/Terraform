variable "project_name" { default = "env" }
variable "region" { default = "us-east-1" }
variable "vpc_cidr_block" { default = "10.123.0.0/16" }
variable "vpc_enable_dns_hostnames" { default = true }
variable "vpc_enable_dns_support" { default = true }
variable "subnet_cidr_block" { default = "10.123.1.0/24" }
variable "subnet_map_public_ip_on_launch" { default = true }
variable "route_destination_cidr_block" { default = "0.0.0.0/0" }
variable "security_group_from_port" { default = 0 }
variable "security_group_to_port" { default = 0 }
variable "security_group_protocol" { default = -1 }
variable "security_group_cidr_blocks" { default = ["0.0.0.0/0"] }