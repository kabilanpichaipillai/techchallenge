resource "aws_lb" "test-web-alb" {
  name                       = "${var.app_name}-web-alb"
  internal                   = "false"
  load_balancer_type         = "application"
  security_groups            = [var.alb_sec_grp]
  subnets                    = var.pb_subnet
}

data "aws_acm_certificate" "test-acm-web-cert" {
  domain = "${var.domain_name}"
}

resource "aws_lb_listener" "test-web-https-listener" {
  load_balancer_arn = aws_lb.test-web-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.test-acm-web-cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test-web-target-group.arn
  }
}

resource "aws_lb_target_group" "test-web-target-group" {
  name        = "${var.app_name}-web-target-group"
  port        = "443"
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener_certificate" "web_cert_map_ref" {
  listener_arn    = aws_lb_listener.test-web-https-listener.arn
  certificate_arn = data.aws_acm_certificate.test-acm-web-cert.arn
}

data "aws_route53_zone" "test-web-zone" {
  name = var.domain_name
}

resource "aws_route53_record" "test-web-route53" {
  zone_id = data.aws_route53_zone.test-web-zone.zone_id
  name    = "${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.test-web-alb.dns_name
    zone_id                = aws_lb.test-web-alb.zone_id
    evaluate_target_health = true
  }
}