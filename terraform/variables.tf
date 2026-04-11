variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "S3 bucket containing the object to share"
  type        = string
  default     = "publicsharebuckit"
}

variable "object_name" {
  description = "S3 object key to generate a presigned URL for"
  type        = string
  default     = "Marc_Bacchi_Resume.pdf"
}

variable "url_expiration" {
  description = "Presigned URL validity in seconds (default 24h)"
  type        = number
  default     = 86400
}

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "presignedURL"
}

variable "iam_role_name" {
  description = "Name of the IAM execution role for the Lambda function"
  type        = string
  default     = "presignedURL-role-nubc2m7d"
}
