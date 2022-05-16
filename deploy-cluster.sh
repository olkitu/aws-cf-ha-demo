#!/bin/bash

REGION="us-east-1"
ACCOUNT="sandbox"

DEPLOY_BUCKET=$(aws --profile $ACCOUNT --region $REGION cloudformation list-exports --query "Exports[?Name=='cf-ha-demo-deployment-bucket'].Value" --output text)

VPCID=$(aws --profile $ACCOUNT --region $REGION cloudformation list-exports --query "Exports[?Name=='cf-ha-vpc-VPCID'].Value" --output text)
VPCCIDR=$(aws --profile $ACCOUNT --region $REGION cloudformation list-exports --query "Exports[?Name=='cf-ha-vpc-VPCCIDR'].Value" --output text)

PublicSubnet1ID=$(aws --profile $ACCOUNT --region $REGION cloudformation list-exports --query "Exports[?Name=='cf-ha-vpc-PublicSubnet1ID'].Value" --output text)
PublicSubnet2ID=$(aws --profile $ACCOUNT --region $REGION cloudformation list-exports --query "Exports[?Name=='cf-ha-vpc-PublicSubnet2ID'].Value" --output text)

PrivateSubnet1AID=$(aws --profile $ACCOUNT --region $REGION cloudformation list-exports --query "Exports[?Name=='cf-ha-vpc-PrivateSubnet1AID'].Value" --output text)
PrivateSubnet2AID=$(aws --profile $ACCOUNT --region $REGION cloudformation list-exports --query "Exports[?Name=='cf-ha-vpc-PrivateSubnet2AID'].Value" --output text)

echo "Uploading code to S3"

# Copy code to S3 bucket
aws --profile $ACCOUNT --region $REGION s3 sync code s3://$DEPLOY_BUCKET/code --delete
aws --profile $ACCOUNT --region $REGION s3 sync code s3://$DEPLOY_BUCKET/sql --delete

echo "Deploying stack to AWS"

# Deploy to AWS the stack
aws --profile $ACCOUNT --region $REGION cloudformation deploy --template-file stacks/aws-cluster.yml --stack-name cf-ha-cluster --s3-bucket $DEPLOY_BUCKET --capabilities CAPABILITY_IAM --parameter-overrides \
    VPCID=$VPCID \
    VPCCIDR=$VPCCIDR \
    PublicSubnet1ID=$PublicSubnet1ID \
    PublicSubnet2ID=$PublicSubnet2ID \
    PrivateSubnet1AID=$PrivateSubnet1AID \
    PrivateSubnet2AID=$PrivateSubnet2AID \
    DBPassword=fisdemodatabasepasssword202020 \
    DeployBucket=$DEPLOY_BUCKET

# Import Database
INSTANCE_ID=$(aws --profile sandbox ec2 describe-instances --filters "Name=tag:Name,Values=app-autoscale" --query Reservations[*].Instances[*].[InstanceId] --output text | head -n1)
RDS_ENDPOINT=$(aws --profile $ACCOUNT --region $REGION cloudformation list-exports --query "Exports[?Name=='cf-ha-cluster-RDSEndPointAddress'].Value" --output text)

aws --profile $ACCOUNT --region $REGION ssm send-command --document-name "AWS-RunShellScript" --document-version "1" --targets '[{"Key":"InstanceIds","Values":["${INSTANCE_ID}"]}]' --parameters '{"workingDirectory":[""],"executionTimeout":["3600"],"commands":["cat /tmp/test-db.sql | mysql -h ${RDS_ENDPOINT} -u admin -p fisdemodatabasepasssword202020"]}' --timeout-seconds 300 --max-concurrency "1" --max-errors "0" --region ${REGION}
