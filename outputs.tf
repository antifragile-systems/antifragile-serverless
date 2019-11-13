output "aws_vpc_id" {
  value = data.aws_vpc.selected.id
}

output "aws_subnet_ids" {
  value = data.aws_subnet_ids.selected.ids
}

output "aws_security_group_ids" {
  value = data.aws_security_groups.selected.ids
}

output "aws_sns_topic_arn" {
  value = data.aws_sns_topic.selected.arn
}

output "aws_iam_role_name" {
  value = aws_iam_role.antifragile-serverless.name
}
