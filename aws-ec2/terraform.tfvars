aws_ec2_aws_key_pair      = "~/.ssh/id_ed25519.pub"
aws_ec2_availability_zone = "us-west-1"
aws_ec2_instance_type     = "t2.micro"
aws_instance_count        = 1

# command_file = "templates/ssh_win_config.tpl"
command_file = "../ssh-config/ssh_linux_config.tpl"
user_data    = "../templates/update_jdk.tpl"