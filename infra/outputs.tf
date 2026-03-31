output "xpix_public_ip" {
  value       = aws_instance.xpix_server.public_ip
  description = "Public IP of the XPix EC2 instance"
}