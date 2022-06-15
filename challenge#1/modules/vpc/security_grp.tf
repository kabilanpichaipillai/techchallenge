resource "aws_security_group" "test_rds_sec_grp" {
  name        = "${var.app_name}-rds-sec-group"
  description = "RDS Security Group"
  vpc_id      = aws_vpc.test_vpc.id

  ingress {
    from_port   = "3306"
    to_port     = "3306"
    protocol    = "tcp"
    cidr_blocks = [var.cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}