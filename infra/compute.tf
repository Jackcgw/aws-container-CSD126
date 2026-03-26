resource "aws_instance" "xpix" {
  ami                         = var.ami_id
  associate_public_ip_address = true
  availability_zone           = "us-east-1b"
  iam_instance_profile        = var.instance_profile_name
  instance_type               = "t3.micro"
  key_name                    = "Lab4Key"
  subnet_id                   = aws_subnet.public_2.id
  vpc_security_group_ids      = [aws_security_group.xpix_sg.id]

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "xpix app-server"
  }
}

import {
  to = aws_instance.xpix
  id = "i-029392ae47dfb0d95"
}
import {
  to = aws_cognito_user_pool.xpix
  id = "us-east-1_HcQmw3lMO"
}

import {
  to = aws_cognito_user_pool_client.xpix
  id = "us-east-1_HcQmw3lMO/7qnlppln1rg9434cpqkmh939eb"
}
output "public_ip" {
  value = aws_instance.xpix.public_ip
}