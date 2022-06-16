resource "aws_eip" "test_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.test_ig]
}

resource "aws_nat_gateway" "test_nat_gateway" {
  subnet_id     = aws_subnet.test_pub_subnet.id
  allocation_id = aws_eip.test_eip.id
}

resource "aws_subnet" "test_priv_subnet" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = var.priv_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name    = "${var.app_name}-private-subnet"
  }
}

resource "aws_route_table" "test_priv_route" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.test_nat_gateway.id
  }
}

resource "aws_route_table_association" "test_priv_route_association" {
  subnet_id      = aws_subnet.test_priv_subnet.id
  route_table_id = aws_route_table.test_priv_route.id
}
