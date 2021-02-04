output "aws_db_instance_address" {
  value = module.prod_mysql_db.aws_db_instance_address
}
output "aws_db_instance_port" {
  value = module.prod_mysql_db.aws_db_instance_port
}
output "environment" {
  value = module.prod_mysql_db.environment
}
