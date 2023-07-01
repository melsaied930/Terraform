output "dev_instance_availability_zone" {
  value = aws_instance.dev_instance.availability_zone
}
output "dev_instance_public_ip" {
  value = "ssh -i ~/.ssh/id_ed25519 ubuntu@${aws_instance.dev_instance.public_ip}"
}