resource "aws_elastic_beanstalk_application" "test-beanstalk-app" {
  name        = var.app_name
  description = "test-beanstalk-app"
}

resource "aws_elastic_beanstalk_environment" "elasticBeanStackPython" {
  name                = var.app_name
  application         = aws_elastic_beanstalk_application.test-beanstalk-app.name
  solution_stack_name = "64bit Amazon Linux 2015.03 v2.0.3 running Go 1.4"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = var.pv_subnet_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = var.pb_subnet_id
  }

}
