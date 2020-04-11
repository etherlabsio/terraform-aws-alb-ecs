locals {
  dns_record_name  = "${local.local_dns_prefix}.${replace(data.aws_route53_zone.selected.name, "/[.]$/", "")}"
  local_dns_prefix = var.dns_prefix == "" ? var.name : var.dns_prefix
}
