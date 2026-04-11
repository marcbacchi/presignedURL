import logging
import os
import boto3
from botocore.exceptions import ClientError

BUCKET_NAME = os.environ.get("BUCKET_NAME", "publicsharebuckit")
OBJECT_NAME = os.environ.get("OBJECT_NAME", "Marc_Bacchi_Resume.pdf")
URL_EXPIRATION = int(os.environ.get("URL_EXPIRATION", "86400"))


def create_presigned_url(bucket_name, object_name, expiration=86400):
    """Generate a presigned URL to share an S3 object

    :param bucket_name: string
    :param object_name: string
    :param expiration: Time in seconds for the presigned URL to remain valid
    :return: Presigned URL as string. If error, returns None.
    """
    s3_client = boto3.client('s3')
    try:
        response = s3_client.generate_presigned_url(
            'get_object',
            Params={'Bucket': bucket_name, 'Key': object_name},
            ExpiresIn=expiration,
        )
    except ClientError as e:
        logging.error(e)
        return None

    return response


def lambda_handler(event, context):
    url = create_presigned_url(BUCKET_NAME, OBJECT_NAME, URL_EXPIRATION)
    if url is None:
        return {"statusCode": 500, "body": "Failed to generate presigned URL"}
    return {"statusCode": 200, "body": url}
