output "service_dns_name" {
  value = local.dns_record_name
}

output "service_name" {
  value = aws_ecs_service.alb_service.name
}

output "tg_arn" {
  value = aws_alb_target_group.alb_service_tg.arn
}

output "td_name" {
  value = aws_ecs_task_definition.main.family
}

output "td_arn" {
  value = aws_ecs_task_definition.main.arn
}

output "td_revision" {
  value = aws_ecs_task_definition.main.revision
}
