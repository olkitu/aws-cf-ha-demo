# Get Cloudformation exported values to Terraform
# data.aws_cloudformation_export.subnet_id.value

data "aws_cloudformation_export" "cf-ha-deployment-bucket" {
  name = "cf-ha-demo-deployment-bucket"
}

# VPC ID
data "aws_cloudformation_export" "cf-ha-vpc-VPCID" {
  name = "cf-ha-vpc-VPCID"
}

# VPC CIDR
data "aws_cloudformation_export" "cf-ha-vpc-VPCCIDR" {
  name = "cf-ha-vpc-VPCCIDR"
}

# VPC Public Subnet IDs
data "aws_cloudformation_export" "cf-ha-vpc-PublicSubnet1ID" {
  name = "cf-ha-vpc-PublicSubnet1ID"
}

data "aws_cloudformation_export" "cf-ha-vpc-PublicSubnet2ID" {
  name = "cf-ha-vpc-PublicSubnet2ID"
}

# VPC Private Subnet IDs
data "aws_cloudformation_export" "cf-ha-vpc-PrivateSubnet1AID" {
  name = "cf-ha-vpc-PrivateSubnet1AID"
}

data "aws_cloudformation_export" "cf-ha-vpc-PrivateSubnet2AID" {
  name = "cf-ha-vpc-PrivateSubnet2AID"
}