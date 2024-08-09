output "public-instance_id" {
  description = "ID of the PUBLIC EC2 instance"
  value       = aws_instance.instance-public.id
}

output "public-instance_public_ip" {
  description = "Public IP address of the PUBLIC EC2 instance"
  value       = aws_instance.instance-public.public_ip
}

output "public-instance_private_ip" {
  description = "Private IP address of the PUBLIC EC2 instance"
  value       = aws_instance.instance-public.private_ip
}


output "private-instance_id" {
  description = "ID of the PRIVATE EC2 instance"
  value       = aws_instance.instance-private.id
}

output "private-instance_private_ip" {
  description = "Privat eIP address of the PRIVATE EC2 instance"
  value       = aws_instance.instance-private.private_ip
}

