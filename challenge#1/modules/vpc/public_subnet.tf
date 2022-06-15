resource "aws_subnet" "test_pub_subnet" {
  cidr_block              = var.pub_subnet_cidr
  availability_zone       = var.availability_zone
  vpc_id                  = aws_vpc.test_vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.app_name}-public-subnet"
  }
}

resource "aws_route_table" "test_pub_route" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_ig.id
  }
}

resource "aws_route_table_association" "test_pub_route_association" {
  subnet_id      = aws_subnet.test_pub_subnet.id
  route_table_id = aws_route_table.test_pub_route.id
}
