output "region" {
  value = var.region
}
output "project_name" {
  value = var.project_name
}
output "aws_subnet_id" {
  value = aws_subnet.subnet.id
}
output "security_group_id" {
  value = aws_security_group.security_group.id
}
output "aws_subnet_availability_zone" {
  value = aws_subnet.subnet.availability_zone
}