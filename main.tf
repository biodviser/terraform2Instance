resource "aws_vpc" "front_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "front_vpc_public_subnet" {
  vpc_id                  = aws_vpc.front_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"
  tags = {
    Name = "dev_public_subnet"
  }
}

resource "aws_internet_gateway" "front_igw" {
  vpc_id = aws_vpc.front_vpc.id

  tags = {
    Name = "dev_igw"
  }
}

resource "aws_route_table" "front_public_rt" {
  vpc_id = aws_vpc.front_vpc.id

  tags = {
    Name = "dev_public_rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.front_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.front_igw.id
}

resource "aws_route_table_association" "front_public_association" {
  subnet_id      = aws_subnet.front_vpc_public_subnet.id
  route_table_id = aws_route_table.front_public_rt.id
}

resource "aws_security_group" "front_sg" {
  name        = "dev_sg"
  description = "dev security group"
  vpc_id      = aws_vpc.front_vpc.id

  ingress {
    description = "my ip ingress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["147.32.98.207/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_instance" "dev_node" {
  ami                    = data.aws_ami.server_ami.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.front_sg.id]
  subnet_id              = aws_subnet.front_vpc_public_subnet.id


  tags = {
    Name = "front_instance"
  }
}