region                = "us-west-1"
key_pair_public_key   = "~/.ssh/id_ed25519.pub"
aws_ec2_instance_type = "t2.micro"
user_data             = "../templates/update_jdk.tpl"