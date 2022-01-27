# AWS HA Testing Repository

Testing AWS HA environment

# Deploy cluster environment

This cluster environment will include:

* S3 Deployment bucket `stacks/aws-deployment-bucket.yml`
* Multi-AZ VPC from quick-start-aws-vpc template: https://aws-quickstart.github.io/quickstart-aws-vpc/
* Application Load Balancer, EC2 AutoScale Application servers and Multi-AZ RDS MySQL instances `stacks/aws-cluster.yml`

