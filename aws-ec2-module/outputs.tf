output "instance_availability_zone" {
  value = aws_instance.instance.availability_zone
}
output "instance_public_ip" {
  value = "ssh -i ~/.ssh/id_ed25519 ubuntu@${aws_instance.instance.public_ip}"
}