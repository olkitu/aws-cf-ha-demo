# Deploy Cloudformation templates

resource "aws_cloudformation_stack" "cf-ha-securitygroups" {
  name          = "cf-ha-securitygroups"
  template_body = file("${path.module}/../cloudformation/securitygroups.yml")
}

resource "aws_cloudformation_stack" "cf-ha-loadbalancer" {
  name          = "cf-ha-loadbalancer"
  template_body = file("${path.module}/../cloudformation/loadbalancer.yml")
  depends_on = [
    aws_cloudformation_stack.cf-ha-securitygroups
  ]
}

resource "aws_cloudformation_stack" "cf-ha-autoscalegroup" {
  name          = "cf-ha-autoscalegroup"
  template_body = file("${path.module}/../cloudformation/autoscalegroup.yml")
  capabilities  = ["CAPABILITY_IAM"]
  parameters = {
    DBPassword   = "Qwerty1234",
    DeployBucket = data.aws_cloudformation_export.cf-ha-deployment-bucket.value
  }
  depends_on = [
    aws_cloudformation_stack.cf-ha-loadbalancer
  ]
}