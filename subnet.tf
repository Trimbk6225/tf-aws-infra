// Public subnet****
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnets["ps1"].cidr
  availability_zone       = var.public_subnets["ps1"].az
  map_public_ip_on_launch = true
  tags = {
    Name = "ps1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnets["ps2"].cidr
  availability_zone       = var.public_subnets["ps2"].az
  map_public_ip_on_launch = true
  tags = {
    Name = "ps2"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnets["ps3"].cidr
  availability_zone       = var.public_subnets["ps3"].az
  map_public_ip_on_launch = true
  tags = {
    Name = "ps3"
  }
}


// private subnet

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnets["pas1"].cidr
  availability_zone = var.private_subnets["pas1"].az
  tags = {
    Name = "pas1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnets["pas2"].cidr
  availability_zone = var.private_subnets["pas2"].az
  tags = {
    Name = "pas2"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnets["pas3"].cidr
  availability_zone = var.private_subnets["pas3"].az
  tags = {
    Name = "pas3"
  }
}