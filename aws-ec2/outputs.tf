output "dev_instance_availability_zone" {
  value = aws_instance.dev_instance.availability_zone
}
output "dev_instance_public_ip" {
  value = aws_instance.dev_instance.public_ip
}
