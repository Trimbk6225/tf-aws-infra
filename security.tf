resource "aws_security_group" "application_sg" {
  name        = "application-security-group"
  description = "Security group for EC2 instances hosting web applications"
  vpc_id      = aws_vpc.my_vpc.id

  // Allow SSH (Port 22) from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # // Allow HTTP (Port 80) from anywhere
  # ingress {
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # // Allow HTTPS (Port 443) from anywhere
  # ingress {
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  // Allow application-specific port (replace with actual port)
  ingress {
    from_port       = var.webapp_port
    to_port         = var.webapp_port
    protocol        = "tcp"
    security_groups = [aws_security_group.load_balancer_sg.id]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "application-security-group"
    Environment = var.environment
  }
}

resource "aws_security_group" "database_sg" {
  name        = "database-sg"
  description = "Security group for RDS instances"

  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.application_sg.id]
  }
}

resource "aws_security_group" "load_balancer_sg" {
  name        = "load-balancer-security-group"
  description = "Security group for Load Balancer"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
    Name        = "Load-Balancer-Security-Group"
    Environment = var.environment
  }
}

