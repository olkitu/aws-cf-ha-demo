# AWS HA Testing Repository

Testing AWS HA environment

# Deploy cluster environment

This cluster environment will include:

* S3 Deployment bucket `stacks/aws-deployment-bucket.yml`
* Multi-AZ VPC from quick-start-aws-vpc template: https://aws-quickstart.github.io/quickstart-aws-vpc/
* Application Load Balancer, EC2 AutoScale Application servers and Multi-AZ RDS MySQL instances

Deploying to AWS is easy with AWS CLI. 

### Deploy deployment S3 Bucket

This bucket used only for deployment process to save Cloudformation templates.

```
./create-deployment-bucket.sh <PROFILE> <REGION>
```

### Deploy VPC

This will download latest quick-start-aws-vpc template from Github and deploy it to AWS.

```
./deploy-vpc.sh <PROFILE> <REGION>
```

### Deploy all other templates with Terraform

```
cd terraform
terraform init
AWS_PROFILE=<PROFILE> AWS_REGION=<REGION> terraform plan
AWS_PROFILE=<PROFILE> AWS_REGION=<REGION> terraform apply
```