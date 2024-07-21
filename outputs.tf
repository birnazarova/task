output "instance_ips" {
  value = aws_instance.vm[*].private_ip
}
