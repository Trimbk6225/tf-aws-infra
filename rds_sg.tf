resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.my_vpc.id

  // Define your security group settings here
  name        = "rds-security-group"
  description = "Security group for RDS instance"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "rds-security-group"
    Environment = var.environment
  }
}