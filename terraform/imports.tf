# Imports bring existing AWS resources under Terraform management.
# Run: terraform init && terraform plan
# The plan will show the import + any in-place changes (e.g. runtime 3.9 → 3.12).
# Run: terraform apply to execute.
#
# Once applied, these import blocks can be removed — they are no-ops on subsequent runs.

import {
  to = aws_lambda_function.presigned_url
  id = "presignedURL"
}

import {
  to = aws_iam_role.lambda_exec
  id = "presignedURL-role-nubc2m7d"
}