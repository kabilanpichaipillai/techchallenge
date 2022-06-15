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