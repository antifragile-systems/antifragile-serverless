terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = "2.54.0"

  region = var.aws_region
}

provider "template" {
  version = "2.1.2"
}

data "terraform_remote_state" "infrastructure_state" {
  backend = "s3"

  config = {
    region = var.state_aws_region
    bucket = var.state_aws_s3_bucket
    key    = "${var.infrastructure_name}.tfstate"
  }
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

resource "aws_iam_role" "antifragile-serverless" {
  name = var.name

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
              "Service": [
                  "lambda.amazonaws.com"
              ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

  tags = {
    IsAntifragile = true
  }
}

resource "aws_iam_role_policy_attachment" "antifragile-serverless" {
  role       = aws_iam_role.antifragile-serverless.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_s3_bucket" "antifragile-serverless" {
  bucket_prefix = "antifragile-serverless."
  acl           = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }

  tags = {
    IsAntifragile = true
  }
}
