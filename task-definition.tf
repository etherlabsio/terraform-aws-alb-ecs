resource "aws_ecs_task_definition" "main" {
  family             = var.name
  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn

  lifecycle {
    create_before_destroy = true
  }

  container_definitions = <<DEFINITION
  [
    {
      "cpu": ${var.cpu},
      "essential": true,
      "environment": ${data.template_file._environment_list.rendered},
      "image": "${var.image}:${var.image_version}",
      "memory": ${var.memory},
      "memoryReservation": ${var.memoryReservation},
      "name": "${var.name}",
      "command": ${var.command},
      "entryPoint": ${var.entry_point},
      "portMappings": [
        {
          "containerPort": ${var.port}
        }
      ],
      "ulimits": [
        {
          "softLimit": 65535,
          "hardLimit": 65535,
          "name": "nofile"
        }
      ],
      "logConfiguration": {
        "logDriver": "syslog",
        "options": {
          "syslog-address": "udp://127.0.0.1:514"
        }
      }
    }
  ]

DEFINITION

}

data "template_file" "_environment_keys" {
  count = length(keys(var.environment))

  template = <<JSON
{
  "name": $${name},
  "value":$${value}
}
JSON


  vars = {
    name  = jsonencode(element(keys(var.environment), count.index))
    value = jsonencode(var.environment[element(keys(var.environment), count.index)])
  }
}

data "template_file" "_environment_list" {
  template = <<JSON
  [$${environment}]
JSON


  vars = {
    environment = join(",", data.template_file._environment_keys.*.rendered)
  }
}
