output "function_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.presigned_url.function_name
}

output "function_arn" {
  description = "Lambda function ARN"
  value       = aws_lambda_function.presigned_url.arn
}

output "invoke_arn" {
  description = "ARN used to invoke the function (e.g. from API Gateway)"
  value       = aws_lambda_function.presigned_url.invoke_arn
}
