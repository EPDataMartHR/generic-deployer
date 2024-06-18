#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Parameters
STACK_NAME=$1
TEMPLATE_FILE=$2
ENVIRONMENT=$3

# Build SAM application
sam build --use-container --template-file ${TEMPLATE_FILE}

# Deploy SAM application
sam deploy \
    --no-confirm-changeset \
    --no-fail-on-empty-changeset \
    --stack-name "${STACK_NAME}" \
    --s3-bucket "cep-${ENVIRONMENT}-eyp-hr-sam-deployments" \
    --s3-prefix "${STACK_NAME}" \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
    --region "${AWS_REGION}" \
    --tags "global:project=DL-HR" "global:bu=HR"
