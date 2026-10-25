#!/bin/bash
set -e

# Script to create a S3 bucket using CloudFormation

# Configuration
STACK_NAME="s3-simple"
TEMPLATE_FILE="main.cform.yaml"
IMAGE_FILE="image.png"

aws cloudformation deploy \
    --template-file $TEMPLATE_FILE \
    --stack-name $STACK_NAME

if [ $? -eq 0 ]; then
    echo "CloudFormation stack deployed successfully"
else
    echo "Failed to deploy CloudFormation stack"
    exit 1
fi

# Get the bucket name from stack outputs
BUCKET_NAME=$(aws cloudformation describe-stacks \
    --stack-name $STACK_NAME \
    --query 'Stacks[0].Outputs[?OutputKey==`BucketName`].OutputValue' \
    --output text)

if [ -z "$BUCKET_NAME" ]; then
    echo "Failed to get bucket name from stack outputs"
    exit 1
fi

echo "Bucket name: $BUCKET_NAME"

# Upload the image to the bucket
echo "Uploading image '${IMAGE_FILE}' to bucket '${BUCKET_NAME}'..."
aws s3 cp "$IMAGE_FILE" "s3://$BUCKET_NAME/"

if [ $? -eq 0 ]; then
    echo "Image uploaded to bucket successfully"
    echo "Image URL: https://$BUCKET_NAME.s3.amazonaws.com/$IMAGE_FILE"
else
    print_error "Failed to upload image to bucket"
    exit 1
fi

# Example output:
# gabriel in daws/exercises/cloudformation on  main [!+] took 38,3s 
# ❯ ./main.sh

# Waiting for changeset to be created..
# Waiting for stack create/update to complete
# Successfully created/updated stack - s3-simple
# CloudFormation stack deployed successfully
# Bucket name: s3-simple-petbucket-kliid6u0rpcl
# Uploading image 'image.png' to bucket 's3-simple-petbucket-kliid6u0rpcl'...
# upload: ./image.png to s3://s3-simple-petbucket-kliid6u0rpcl/image.png
# Image uploaded to bucket successfully
# Image URL: https://s3-simple-petbucket-kliid6u0rpcl.s3.amazonaws.com/image.png
# gabriel in daws/exercises/cloudformation on  main [!+] took 40,0s 