#!/bin/bash

REGION="us-east-1"
ACCOUNT="sandbox"

DEPLOY_BUCKET=$(aws --profile $ACCOUNT --region $REGION cloudformation list-exports --query "Exports[?Name=='cf-ha-demo-deployment-bucket'].Value" --output text)

# Download latest aws-vpc-template to deploy simple Multi-AZ VPC network
curl -s https://raw.githubusercontent.com/aws-quickstart/quickstart-aws-vpc/main/templates/aws-vpc.template.yaml -o stacks/aws-vpc.template.yaml

echo "Deploy aws-vpc.template.yaml template"

aws --profile $ACCOUNT --region $REGION cloudformation deploy --template-file stacks/aws-vpc.template.yaml --stack-name cf-ha-vpc --s3-bucket $DEPLOY_BUCKET --capabilities CAPABILITY_IAM --parameter-overrides \
    NumberOfAZs=2 \
    AvailabilityZones=us-east-1a,us-east-1b