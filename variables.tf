variable "name" {
}

variable "desired_count" {
  default = 1
}

variable "service_role" {
}

variable "vpc_id" {
}

variable "listener_arn" {
}

variable "alb_dns_name" {
}

variable "zone_id" {
}

variable "port" {
}

variable "image" {
}

variable "image_version" {
  default = "latest"
}

variable "cpu" {
}

variable "memory" {
}

variable "memoryReservation" {
}

variable "task_role_arn" {
  default = ""
}

variable "environment" {
  type    = map(string)
  default = {}
}

variable "execution_role_arn" {
}

variable "cluster_name" {
}

variable "autoscale_cpu_utilization_enabled" {
  default = true
}

variable "autoscale_memory_utilization_enabled" {
  default = true
}

variable "autoscale_enabled" {
  default = true
}

variable "dns_enabled" {
  default = true
}

variable "dns_prefix" {
  default = ""
}

variable "healthcheck_path" {
  default = "/debug/healthcheck"
}

variable "unhealthy_threshold" {
  default = 3
}

variable "healthcheck_interval" {
  default = 30
}

variable "healthcheck_timeout" {
  default = 10
}

variable "deregistration_delay" {
  default = 60
}

variable "health_check_grace_period_seconds" {
  default = 0
}

variable placement_type {
  default = "binpack"
}

variable placement_field {
  default = "memory"
}

variable "entry_point" {
  default = "null"
}

variable "command" {
  default = "null"
}
