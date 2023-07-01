variable "command_template_file" {
  type = string
  # default = "../ssh-config/ssh_linux_config.tpl"
  default = "templates/ssh_win_config.tpl"
}

variable "aws_ec2_user_data" {
  type = string
  # default = "../templates/update_docker.tpl"
  default = "../templates/update_jdk.tpl"
}

variable "aws_ec2_aws_key_pair" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"
}

variable "aws_ec2_availability_zone" {
  type    = string
  default = "us-west-2"
}

variable "aws_ec2_instance_type" {
  type    = string
  default = "t2.micro"
}