resource "aws_ecr_repository" "test-ecr-repo" {
  name = "${var.app_name}"
}