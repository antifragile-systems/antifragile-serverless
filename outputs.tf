output "aws_vpc" {
  value = data.aws_vpc.selected
}

output "aws_subnet_ids" {
  value = data.aws_subnet_ids.selected
}

output "aws_security_groups" {
  value = data.aws_security_groups.selected
}
