resource "aws_security_group" "test-ecs-sec-grp" {
  name        = "${var.app_name}-ecs-sec-group"
  description = "ECS Security Group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = "3000"
    to_port     = "3000"
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