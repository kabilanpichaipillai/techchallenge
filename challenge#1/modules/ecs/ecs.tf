resource "aws_ecs_task_definition" "test-ecs-task" {
  family                   = "test"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "iis",
    "image": "aws_ecr_repository.test-ecr-repo.arn",
    "cpu": 1024,
    "memory": 2048,
    "essential": true
  }
]
TASK_DEFINITION
}

resource "aws_ecs_cluster" "test-ecs-cluster" {
  name = "${var.app_name}-cluster"
}

resource "aws_ecs_service" "test-ecs-service" {
  name            = "${var.app_name}-service"
  cluster         = aws_ecs_cluster.test-ecs-cluster.name
  task_definition = aws_ecs_task_definition.test-ecs-task.arn
  desired_count   = "2"
  launch_type   = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.test-web-target-group.arn
    container_name   = "${var.app_name}-container"
    container_port   = "3000"
  }
}
