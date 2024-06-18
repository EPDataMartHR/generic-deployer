#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Parameters
STACK_NAME=$1
TEMPLATE_FILE=$2
ENVIRONMENT=$3

# Build SAM application
sam build --use-container --template-file ${TEMPLATE_FILE}

echo $STACK_NAME
echo $ENVIRONMENT

# Deploy SAM application
sam deploy --template-file .aws-sam/build/template.yaml \
            --stack-name ${STACK_NAME} \
            --capabilities CAPABILITY_IAM \
            --parameter-overrides Environment=${ENVIRONMENT}
            --region $AWS_REGION
