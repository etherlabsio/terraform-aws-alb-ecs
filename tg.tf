resource "aws_alb_target_group" "alb_service_tg" {
  depends_on           = [null_resource.alb_exists]
  name                 = "${var.name}-tg"
  port                 = var.port
  protocol             = "HTTP"
  deregistration_delay = var.deregistration_delay

  health_check {
    path                = var.healthcheck_path
    unhealthy_threshold = var.unhealthy_threshold
    interval            = var.healthcheck_interval
    timeout             = var.healthcheck_timeout
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [lambda_multi_value_headers_enabled]
  }

  vpc_id = var.vpc_id
}

resource "aws_lb_listener_rule" "alb_service_listener_rule" {
  depends_on   = [null_resource.alb_exists]
  listener_arn = var.listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_service_tg.arn
  }

  condition {
    host_header {
      values = [local.dns_record_name]
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "null_resource" "alb_exists" {
  triggers = {
    alb_name = var.listener_arn
  }
}

