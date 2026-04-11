# presignedURL

AWS Lambda function that generates a temporary, expiring download link (presigned URL) for any file in an S3 bucket. Managed with Terraform.

## How it works

Invoking the Lambda function returns a presigned URL for the configured S3 object. The URL is valid for the configured expiration period, after which it stops working automatically.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.0
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- AWS credentials configured locally: `aws configure --profile Marc`

## Deploy

```bash
cd terraform
terraform init
terraform apply
```

## Invoke the function

```bash
aws lambda invoke \
  --function-name presignedURL \
  --profile Marc \
  --payload '{}' \
  response.json && cat response.json
```

The response body contains the presigned URL ready to share.

## Share a different file

Pass variables at apply time — no code changes needed.

**Different file, same bucket:**
```bash
terraform apply -var="object_name=my-other-file.pdf"
```

**Different file and bucket:**
```bash
terraform apply -var="bucket_name=mybucket" -var="object_name=my-other-file.pdf"
```

**Custom expiration (seconds):**
```bash
terraform apply -var="url_expiration=3600"   # 1 hour
terraform apply -var="url_expiration=86400"  # 24 hours (default)
terraform apply -var="url_expiration=604800" # 7 days
```

To reset back to defaults, run `terraform apply` with no flags.

## Configuration

All defaults live in `terraform/variables.tf`:

| Variable | Default | Description |
|---|---|---|
| `bucket_name` | `publicsharebuckit` | S3 bucket containing the file |
| `object_name` | `Marc_Bacchi_Resume.pdf` | S3 object key (filename) |
| `url_expiration` | `86400` | Link validity in seconds |
| `aws_region` | `us-east-1` | AWS region |
| `function_name` | `presignedURL` | Lambda function name |