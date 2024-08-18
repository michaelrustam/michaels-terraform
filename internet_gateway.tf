resource "aws_internet_gateway" "int_gateway" {
  vpc_id = aws_vpc.main_vpcs.id
}

resource "aws_route_table" "public_route_tbl" {
  vpc_id = aws_vpc.main_vpcs.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.int_gateway.id
  }
}

resource "aws_route_table_association" "public_subnet_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_tbl.id
}

resource "aws_route_table_association" "public_subnet_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_tbl.id
}