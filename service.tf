resource "aws_ecs_service" "alb_service" {
  name    = "${var.name}-service"
  cluster = data.aws_ecs_cluster.cluster_info.arn

  task_definition                   = aws_ecs_task_definition.main.arn
  desired_count                     = var.desired_count
  iam_role                          = var.service_role
  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  load_balancer {
    target_group_arn = aws_alb_target_group.alb_service_tg.arn
    container_name   = var.name
    container_port   = var.port
  }

  ordered_placement_strategy {
    type  = var.placement_type
    field = var.placement_field
  }

  lifecycle {
    ignore_changes = [
      desired_count,
      task_definition
    ]
  }
}

data "aws_route53_zone" "selected" {
  zone_id = var.zone_id
}

resource "aws_route53_record" "service_record" {
  count   = var.dns_enabled ? 1 : 0
  zone_id = var.zone_id
  name    = local.dns_record_name
  type    = "CNAME"
  ttl     = "60"
  records = [var.alb_dns_name]
}

data "aws_ecs_cluster" "cluster_info" {
  cluster_name = var.cluster_name
}


