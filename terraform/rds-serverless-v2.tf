# Serverless v2 Database demo
resource "aws_rds_cluster" "rds-serverless-v2" {
  cluster_identifier = "example"
  engine             = "aurora-mysql"
  engine_mode        = "provisioned"
  engine_version     = "8.0"
  database_name      = "demo"
  master_username    = "admin"
  master_password    = "Qwerty1234"

  db_subnet_group_name = aws_db_subnet_group.rds-serverless-v2.name

  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }
}

resource "aws_rds_cluster_instance" "rds-serverless-v2" {
  cluster_identifier = aws_rds_cluster.rds-serverless-v2-demo.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.rds-serverless-v2-demo.engine
  engine_version     = aws_rds_cluster.rds-serverless-v2-demo.engine_version
}

resource "aws_db_subnet_group" "rds-serverless-v2" {
  subnet_ids = [
    cf-ha-vpc-PrivateSubnet1AID,
    cf-ha-vpc-PrivateSubnet2AID
  ]
}