#!/bin/bash

# Variables
FUNCTION_NAME="metametrics-frontend"
HANDLER="lambda_function.lambda_handler"
ZIPPED_FILE="fe-function.zip"
ROLE_ARN="arn:aws:iam::123456789012:role/lambda-execution-role"
REGION="us-west-1"

# Package Lambda function code
zip -r $ZIPPED_FILE lambda_function.py

# Deploy Lambda function
aws lambda create-function \
    --function-name $FUNCTION_NAME \
    --runtime python3.8 \
    --role $ROLE_ARN \
    --handler $HANDLER \
    --zip-file file://$ZIPPED_FILE \
    --region $REGION

# Clean up
rm -f $ZIPPED_FILE

