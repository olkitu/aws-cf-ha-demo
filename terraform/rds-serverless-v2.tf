# Serverless v2 Database demo
resource "aws_rds_cluster" "rds-serverless-v2" {
  engine              = "aurora-mysql"
  engine_mode         = "provisioned"
  engine_version      = "8.0.mysql_aurora.3.02.0"
  database_name       = "demo"
  master_username     = "admin"
  master_password     = "Qwerty1234"
  skip_final_snapshot = true
  storage_encrypted   = true

  db_subnet_group_name = aws_db_subnet_group.rds-serverless-v2.name
  vpc_security_group_ids = [
    data.aws_cloudformation_export.cf-ha-securitygroups-RDSSecurityGroupId.value
  ]

  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }

  depends_on = [
    aws_cloudformation_stack.cf-ha-securitygroups
  ]
}

resource "aws_rds_cluster_instance" "rds-serverless-v2" {
  cluster_identifier = aws_rds_cluster.rds-serverless-v2.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.rds-serverless-v2.engine
  engine_version     = aws_rds_cluster.rds-serverless-v2.engine_version
}

resource "aws_db_subnet_group" "rds-serverless-v2" {
  subnet_ids = [
    data.aws_cloudformation_export.cf-ha-vpc-PrivateSubnet1AID.value,
    data.aws_cloudformation_export.cf-ha-vpc-PrivateSubnet2AID.value
  ]
}