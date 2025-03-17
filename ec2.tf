resource "aws_instance" "custom_instance" {
  ami                         = var.custom_ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet_1.id
  vpc_security_group_ids      = [aws_security_group.application_sg.id, aws_security_group.database_sg.id]
  associate_public_ip_address = true
  disable_api_termination     = false

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name # ✅ Attach IAM role to EC2

  root_block_device {
    volume_size           = 25
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name = "Dev-EC2-Instance"
  }

  user_data = <<EOF
#!/bin/bash

# Create .env file with dynamically retrieved values
cat <<EOT >> /opt/csye6225/webapp/.env
DATABASE_USERNAME=${var.db_username}
DATABASE_PASSWORD=${var.db_password}
DATABASE_HOST=${aws_db_instance.rds_instance.address}  # Fetching RDS hostname dynamically
DATABASE_NAME=${var.db_name}
DATABASE_PORT=${var.db_port}
S3_BUCKET_NAME=${aws_s3_bucket.s3_bucket.bucket}       # Fetching S3 bucket name dynamically
AWS_REGION=${var.aws_region}
EOT

sudo systemctl enable csye6225
sudo service csye6225 start
EOF
}