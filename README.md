# Terraform
https://youtu.be/iRaai1IBlB0

brew install terraform

terraform -v
terraform init
terraform validate
terraform plan
terraform apply
terraform apply -help
terraform apply -auto-approve

terraform apply -replace aws_instance.dev_instance
terraform apply -replace aws_instance.dev_instance -auto-approve
terraform apply -refresh-only
terraform apply -refresh-only -auto-approve

terraform destroy
terraform destroy -auto-approve

terraform state list
terraform state show aws_instance.dev_instance
terraform show# Terraform
terraform fmt

terraform plan -var-file=dev.tfvars

terraform get -update

terraform workspace
terraform workspace list


ssh-keygen -t ed25519

ssh -i ~/.ssh/id_ed25519 ubuntu@ec2-34-221-102-238.us-west-2.compute.amazonaws.com

https://github.com/MPriv32/GitOps-Spacelift-Terraform

  # ingress {
  #   description = "HTTPS"
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  # ingress {
  #   description = "HTTP"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  # ingress {
  #   description = "SSH"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

