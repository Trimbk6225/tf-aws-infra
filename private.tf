//Create Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id
}

//Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "private_assoc_1" {
  subnet_id = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc_2" {
  subnet_id = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc_3" {
  subnet_id = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.private_rt.id
}
