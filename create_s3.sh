#!/bin/bash

# Define the bucket name
BUCKET_NAME="Team4techsolutionsbucket"

# Create the S3 bucket
aws s3 mb s3://$BUCKET_NAME

if [ $? -eq 0 ]; then
    echo "Bucket created successfully."
else
    echo "Failed to create bucket."
fi

