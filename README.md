# presignedURL
This is a simple script to create a presigned URL for an s3 bucket object, to enable shareable expiring download link.

1) Put this script in a Lambda function in your AWS account.
2) Update the variables in the script for your own bucket/object as indicated below
3) Set the access policy on the s3 bucket properly
4) Run the Lambda, which will return the URL

Not my own work.
This was gathered from the Boto3 docs here:  https://boto3.amazonaws.com/v1/documentation/api/latest/guide/s3-presigned-urls.html

Please clone, update, and use. 

### Update these parameters for your own bucket details:
#### bucket_name
#### object_name
#### expiration= ??? (in seconds)
