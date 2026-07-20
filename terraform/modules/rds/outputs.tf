output "rds_endpoint" {
  value = aws_db_instance.mysql_database.endpoint
}

output "rds_port" {
  value = aws_db_instance.mysql_database.port
}

output "database_name" {
  value = aws_db_instance.mysql_database.db_name
}

output "database_username" {
  value = aws_db_instance.mysql_database.username
}