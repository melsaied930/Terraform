locals {
  common_tags = {
    Name = "module-vpc-${module.vpc.project_name}"
  }
}

module "vpc" {
  source = "../modules/vpc"
  #  source = "github.com/melsaied930/Terraform/modules/vpc"
  region = var.region
}
resource "aws_key_pair" "key_pair" {
  key_name   = module.vpc.project_name
  public_key = file(var.key_pair_public_key)
  tags       = local.common_tags
}

resource "aws_instance" "instance" {
  availability_zone      = module.vpc.aws_subnet_availability_zone
  instance_type          = var.aws_ec2_instance_type
  ami                    = data.aws_ami.ubuntu.id
  key_name               = aws_key_pair.key_pair.id
  vpc_security_group_ids = [module.vpc.security_group_id]
  subnet_id              = module.vpc.aws_subnet_id
  user_data              = file(var.user_data)
  tags                   = local.common_tags
  provisioner "local-exec" {
    command = templatefile("../ssh-config/ssh_linux_config.tpl", {
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