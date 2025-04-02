resource "aws_db_parameter_group" "db_param_group" {
  name   = "${var.rds_identifier}-param-group"
  family = var.db_family

  parameter {
    name         = "max_connections"
    value        = var.max_connections
    apply_method = "immediate"
  }
}

resource "aws_db_instance" "rds_instance" {
  identifier                = var.rds_identifier
  engine                    = var.db_engine
  instance_class            = var.db_instance_class
  allocated_storage         = var.db_storage
  username                  = var.db_username
  password                  = var.db_password
  db_name                   = var.db_name
  db_subnet_group_name      = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids    = [aws_security_group.rds_sg.id]
  parameter_group_name      = aws_db_parameter_group.db_param_group.name
  publicly_accessible       = false
  multi_az                  = false
  skip_final_snapshot       = true
  final_snapshot_identifier = "${var.rds_identifier}-final-snapshot"

  tags = {
    Name        = "${var.rds_identifier}-instance"
    Environment = var.environment

  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "${var.rds_identifier}-subnet-group"

  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id,
    aws_subnet.private_subnet_3.id,
  ]

  tags = {
    Name        = "${var.rds_identifier}-subnet-group"
    Environment = var.environment
  }
}