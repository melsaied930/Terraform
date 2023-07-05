output "availability_zone" {
  value = data.aws_availability_zones.available_zones.names[0]
}

output "dev_instance_public_ip" {
  value = "ssh -i ~/.ssh/id_ed25519 ubuntu@${aws_instance.dev_instance[0].public_ip}"
}