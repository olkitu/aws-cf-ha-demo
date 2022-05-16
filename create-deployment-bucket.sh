#!/bin/bash

if [[ -z "$REGION" ]]; then
    REGION="us-east-1"
fi

PROFLE="sandbox"

aws --profile $PROFLE --region $REGION cloudformation create-stack --template-body file://stacks/aws-deployment-bucket.yml --stack-name=cf-ha-deployment-bucket

echo "Wait for stack to be created"

aws --profile $PROFLE --region $REGION cloudformation wait stack-create-complete --stack-name cf-ha-deployment-bucket

echo "Stack created"