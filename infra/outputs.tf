output "xpix_public_ip" {
  value       = aws_instance.xpix.public_ip
  description = "Public IP of the XPix EC2 instance"
}