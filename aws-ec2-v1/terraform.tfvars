aws_ec2_availability_zone = "us-west-2a"
command_template_file     = "templates/ssh_win_config.tpl"
aws_ec2_user_data         = "../templates/update_jdk.tpl"
aws_ec2_aws_key_pair      = "~/.ssh/id_ed25519.pub"
aws_ec2_instance_type     = "t2.micro"