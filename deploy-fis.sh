#!/bin/bash

if [[ -z "$REGION" ]]; then
    REGION="us-east-1"
fi

ACCOUNT="sandbox"

DEPLOY_BUCKET=$(aws --profile $ACCOUNT --region $REGION cloudformation list-exports --query "Exports[?Name=='cf-ha-demo-deployment-bucket'].Value" --output text)

aws --profile $ACCOUNT --region $REGION cloudformation deploy --template-file stacks/aws-fis.yml --stack-name cf-ha-fis --s3-bucket $DEPLOY_BUCKET --capabilities CAPABILITY_IAM