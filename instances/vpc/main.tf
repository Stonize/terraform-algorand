resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "VPC Algorand"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.cidr_public_subnet
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rtb_public.id
}
