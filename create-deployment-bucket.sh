#!/bin/bash

AWS_REGION="us-east-1"
AWS_PROFILE="sandbox"

aws --profile $AWS_PROFILE --region $AWS_REGION cloudformation create-stack --template-body file://stacks/aws-deployment-bucket.yml --stack-name=cf-ha-deployment-bucket

echo "Wait for stack to be created"

aws --profile $AWS_PROFILE --region $AWS_REGION cloudformation wait stack-create-complete --stack-name cf-ha-deployment-bucket

echo "Stack created"