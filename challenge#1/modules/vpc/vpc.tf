resource "aws_vpc" "test_vpc" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true

  tags = {
    Name    = "${var.app_name}-vpc-${var.env_id}"
  }
}

resource "aws_internet_gateway" "test_ig" {
  vpc_id = aws_vpc.test_vpc.id
}
