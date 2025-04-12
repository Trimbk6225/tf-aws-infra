resource "aws_launch_template" "web_app_lt" {
  name          = "${var.environment}-web-app-lt"
  image_id      = var.custom_ami_id
  instance_type = var.instance_type

  key_name = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.application_sg.id]
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }

  user_data = base64encode(<<EOF
#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -x

yum update -y
yum install -y python3-pip jq unzip curl git

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Pull password securely and log it
SECRET_JSON=$(aws secretsmanager get-secret-value \
  --region ${var.aws_region} \
  --secret-id ${var.environment}-db-password \
  --query SecretString --output text)

echo "Fetched secret: $SECRET_JSON"

DB_PASSWORD=$(echo $SECRET_JSON | jq -r .password)

mkdir -p /opt/csye6225/webapp

cat <<EOT > /opt/csye6225/webapp/.env
DATABASE_USERNAME=${var.db_username}
DATABASE_PASSWORD=$DB_PASSWORD
DATABASE_HOST=${aws_db_instance.rds_instance.address}
DATABASE_NAME=${var.db_name}
DATABASE_PORT=${var.db_port}
S3_BUCKET_NAME=${aws_s3_bucket.s3_bucket.bucket}
AWS_REGION=${var.aws_region}
EOT



sudo mkdir -p /opt/aws/amazon-cloudwatch-agent/etc
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/cloudwatch-config.json -s
sudo systemctl enable csye6225
sudo service csye6225 start
EOF
  )

  tags = {
    Name        = "${var.environment}-Launch-Template"
    Environment = var.environment
  }
}

resource "aws_autoscaling_group" "web_app_asg" {
  name                    = "${var.environment}-web-app-asg"
  max_size                = 5
  min_size                = 3
  desired_capacity        = 3
  default_instance_warmup = 300

  launch_template {
    id      = aws_launch_template.web_app_lt.id
    version = "$Latest"
  }

  vpc_zone_identifier = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id,
    aws_subnet.public_subnet_3.id,
  ]

  target_group_arns = [aws_lb_target_group.web_app_tg.arn]


  tag {
    key                 = "Name"
    value               = "${var.environment}-WebApp-ASG"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "scale_out_policy" {
  name                   = "${var.environment}-Scale-Out-Policy"
  scaling_adjustment     = var.scale_out_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.cooldown_period
  autoscaling_group_name = aws_autoscaling_group.web_app_asg.name

  policy_type = "SimpleScaling"
}

resource "aws_autoscaling_policy" "scale_in_policy" {
  name                   = "${var.environment}-Scale-In-Policy"
  scaling_adjustment     = var.scale_in_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.cooldown_period
  autoscaling_group_name = aws_autoscaling_group.web_app_asg.name

  policy_type = "SimpleScaling"
}
