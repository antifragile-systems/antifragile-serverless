output "aws_vpc_id" {
  value = data.aws_vpc.selected.id
}

output "aws_subnet_ids" {
  value = data.aws_subnet_ids.selected.ids
}

output "aws_security_group_ids" {
  value = data.aws_security_groups.selected.ids
}
