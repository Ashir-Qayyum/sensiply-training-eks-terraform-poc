resource "aws_db_instance" "mysql_database" {

  identifier = "${var.project_name}-mysql"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  db_name           = var.db_name
  username          = var.db_username
  password          = var.db_password

  port = 3306

  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

  vpc_security_group_ids = [
    aws_security_group.rds_security_group.id
  ]

  publicly_accessible     = true
  multi_az                = false
  storage_encrypted       = true
  skip_final_snapshot     = true
  deletion_protection     = false
  backup_retention_period = 0

}


resource "aws_security_group" "rds_security_group" {

  name        = "${var.project_name}-rds-security-group"
  description = "Security Group for MySQL RDS"
  vpc_id      = var.vpc_id


  ingress {

    description = "Allow MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }


  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

}



resource "aws_db_subnet_group" "rds_subnet_group" {

  name = "${var.project_name}-rds-subnet-group"
  subnet_ids = [
    var.subnet_1,
    var.subnet_2
  ]

}