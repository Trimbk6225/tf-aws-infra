# resource "aws_instance" "custom_instance" {
#   ami                         = var.custom_ami_id
#   instance_type               = var.instance_type
#   subnet_id                   = aws_subnet.public_subnet_1.id
#   vpc_security_group_ids      = [aws_security_group.application_sg.id, aws_security_group.database_sg.id]
#   associate_public_ip_address = true
#   disable_api_termination     = false

#   iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name # ✅ Attach IAM role to EC2

#   root_block_device {
#     volume_size           = 25
#     volume_type           = "gp2"
#     delete_on_termination = true
#   }

#   tags = {
#     Name = "Dev-EC2-Instance"
#   }

#   user_data = <<EOF
# #!/bin/bash

# # Create .env file with dynamically retrieved values
# cat <<EOT >> /opt/csye6225/webapp/.env
# DATABASE_USERNAME=${var.db_username}
# DATABASE_PASSWORD=${var.db_password}
# DATABASE_HOST=${aws_db_instance.rds_instance.address}  # Fetching RDS hostname dynamically
# DATABASE_NAME=${var.db_name}
# DATABASE_PORT=${var.db_port}
# S3_BUCKET_NAME=${aws_s3_bucket.s3_bucket.bucket}       # Fetching S3 bucket name dynamically
# AWS_REGION=${var.aws_region}
# EOT


# # Install and configure CloudWatch Agent
# sudo mkdir -p /opt/aws/amazon-cloudwatch-agent/etc
# # sudo tee /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<EOT
# # {
# #   "logs": {
# #     "logs_collected": {
# #       "files": {
# #         "collect_list": [
# #           {
# #             "file_path": "/var/log/csye6225/webapp.log",
# #             "log_group_name": "csye6225-webapp-logs",
# #             "log_stream_name": "{instance_id}"
# #           }
# #         ]
# #       }
# #     }
# #   },
# #   "metrics": {
# #     "metrics_collected": {
# #       "statsd": {
# #         "service_address": ":8125"
# #       }
# #     }
# #   }
# # }
# # EOT

# # Download and install CloudWatch Agent
# # wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
# # sudo dpkg -i -E ./amazon-cloudwatch-agent.deb

# # Start and enable CloudWatch Agent
# # sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s
# # sudo systemctl enable amazon-cloudwatch-agent
# sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/cloudwatch-config.json -s
# sudo systemctl enable csye6225
# sudo service csye6225 start
# EOF
# }