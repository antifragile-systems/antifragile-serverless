terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = "2.14.0"

  region = var.aws_region
}

data "aws_vpc" "selected" {
  tags = {
    Name = var.infrastructure_name
  }
}

data "aws_subnet_ids" "selected" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    IsPrivateSubnet = true
  }
}

data "aws_security_groups" "selected" {
  tags = {
    IsAntifragile = true
    Name          = "serverless"
  }
}

data "aws_sns_topic" "selected" {
  name = var.infrastructure_name
}
