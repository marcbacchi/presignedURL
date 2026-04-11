terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "Marc"
}

# --- Zip the Lambda source code ---

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/../main.py"
  output_path = "${path.module}/../dist/main.zip"
}

# --- IAM role for Lambda ---

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_exec" {
  name               = var.iam_role_name
  path               = "/service-role/"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}


data "aws_iam_policy_document" "s3_read" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.bucket_name}/*"]
  }
}

resource "aws_iam_role_policy" "s3_read" {
  name   = "${var.function_name}-s3-read"
  role   = aws_iam_role.lambda_exec.name
  policy = data.aws_iam_policy_document.s3_read.json
}

# --- Lambda function ---

resource "aws_lambda_function" "presigned_url" {
  function_name    = var.function_name
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  role             = aws_iam_role.lambda_exec.arn
  handler          = "main.lambda_handler"
  runtime          = "python3.12"
  timeout          = 10
  memory_size      = 128

  environment {
    variables = {
      BUCKET_NAME    = var.bucket_name
      OBJECT_NAME    = var.object_name
      URL_EXPIRATION = tostring(var.url_expiration)
    }
  }
}
