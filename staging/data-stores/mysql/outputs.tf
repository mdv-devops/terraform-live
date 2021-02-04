
output "aws_db_instance_address" {
  value = module.staging_mysql_db.aws_db_instance_address
}
output "aws_db_instance_port" {
  value = module.staging_mysql_db.aws_db_instance_port
}
output "environment" {
  value = module.staging_mysql_db.environment
}
