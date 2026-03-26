resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "xpix-vpc"
  }
}

import {
  to = aws_vpc.main
  id = "vpc-05829ad8072f48ce2"
}
resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "xpix-public-2"
  }
}

import {
  to = aws_subnet.public_2
  id = "subnet-06130a1749f0023d6"
}
resource "aws_subnet" "public_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "xpix-public-1"
  }
}

import {
  to = aws_subnet.public_1
  id = "subnet-0f589820bb111ea28"
}
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "xpix-private-2"
  }
}

import {
  to = aws_subnet.private_2
  id = "subnet-00b67621f003af0d0"
}
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "xpix-private-1"
  }
}

import {
  to = aws_subnet.private_1
  id = "subnet-0154b2e99b761afe6"
}
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "xpix-igw"
  }
}

import {
  to = aws_internet_gateway.main
  id = "igw-0d61b8cd6c99fe39e"
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "xpix-public-rt"
  }
}

import {
  to = aws_route_table.public
  id = "rtb-03853ff28f6226fd1"
}

resource "aws_route_table" "private_1" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "xpix-private-rt-1"
  }
}

import {
  to = aws_route_table.private_1
  id = "rtb-0f3bb48499626cf9f"
}

resource "aws_route_table" "private_2" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "xpix-private-rt-2"
  }
}

import {
  to = aws_route_table.private_2
  id = "rtb-0bbdb66486800315d"
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

import {
  to = aws_route_table_association.public_1
  id = "subnet-0f589820bb111ea28/rtb-03853ff28f6226fd1"
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

import {
  to = aws_route_table_association.public_2
  id = "subnet-06130a1749f0023d6/rtb-03853ff28f6226fd1"
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_1.id
}

import {
  to = aws_route_table_association.private_1
  id = "subnet-0154b2e99b761afe6/rtb-0f3bb48499626cf9f"
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_2.id
}

import {
  to = aws_route_table_association.private_2
  id = "subnet-00b67621f003af0d0/rtb-0bbdb66486800315d"
}
# --- XPix Web Security Group ---
resource "aws_security_group" "xpix_sg" {
  name        = "xpix-sg"
  description = "Managed by Terraform"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "xpix-sg"
  }
}

import {
  to = aws_security_group.xpix_sg
  id = "sg-0895bfb27cfa64d37"
}

resource "aws_vpc_security_group_ingress_rule" "xpix_sg_http" {
  security_group_id = aws_security_group.xpix_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

import {
  to = aws_vpc_security_group_ingress_rule.xpix_sg_http
  id = "sgr-05ab7564a267ec60c"
}

# --- App Server Security Group ---
resource "aws_security_group" "app_server" {
  name        = "xpix app-server"
  description = "allow XPix app server connections"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "xpix-app-server"
  }
}

import {
  to = aws_security_group.app_server
  id = "sg-0098eb45754fe4628"
}

resource "aws_vpc_security_group_ingress_rule" "app_server_ssh" {
  security_group_id = aws_security_group.app_server.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

import {
  to = aws_vpc_security_group_ingress_rule.app_server_ssh
  id = "sgr-00d2cd84521fdb970"
}