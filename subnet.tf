// Public subnet****
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
   tags = {
    Name = "ps1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
   map_public_ip_on_launch = true
   tags = {
    Name = "ps2"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1c"
   map_public_ip_on_launch = true
   tags = {
    Name = "ps3"
  }
}

// private subnet

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1a"
   tags = {
    Name = "pas1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1b"
   tags = {
    Name = "pas1"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "us-east-1c"
   tags = {
    Name = "pas1"
  }
}