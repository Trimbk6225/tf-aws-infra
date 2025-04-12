variable "profile" {
  type        = string
  description = "Aws profile name"
}

variable "aws_region" {
  description = "The AWS region to deploy resources to"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

data "aws_availability_zones" "available" {}

variable "public_subnets" {
  type = map(object({
    cidr = string
  }))
}

variable "private_subnets" {
  type = map(object({
    cidr = string
  }))
}

variable "webapp_port" {
  type = number
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "custom_ami_id" {
  type = string
}


# S3 bucket configuration
variable "bucket_name_prefix" {
  description = "Prefix for S3 bucket name."
}

# General environment information
variable "environment" {
  description = "Environment tag (e.g., Dev, Prod)"
  type        = string
}

# RDS configuration variables
variable "rds_identifier" {
  description = "The identifier for the RDS instance"
  type        = string
}

variable "db_engine" {
  description = "The database engine to use (e.g., mysql, postgres)"
  type        = string
}

variable "db_family" {
  description = "The parameter group family for the database engine (e.g., mysql8.0, postgres13)"
  type        = string
}

variable "db_instance_class" {
  description = "The instance class/type for the RDS instance"
  type        = string
}

variable "db_storage" {
  description = "The allocated storage size for the RDS instance in GB"
  type        = number
}

variable "max_connections" {
  description = "The maximum number of database connections allowed"
  type        = number
}

variable "db_username" {
  description = "The username for the RDS database"
  type        = string
  sensitive   = true
}

# variable "db_password" {
#   description = "The password for the RDS database"
#   type        = string
#   sensitive   = true
# }


variable "db_port" {
  description = "The port on which the database listens (e.g., 3306 for MySQL)"
  type        = number
}


variable "multi_az" {
  description = "Specifies if the RDS instance should be Multi-AZ"
  type        = bool
}

variable "db_name" {
  description = "The name of the database to create in the RDS instance"
  type        = string
}

variable "domain_name" {
  description = "The root domain name, e.g., example.com"
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair for EC2 instances"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
}

variable "cpu_high_threshold" {
  description = "High CPU utilization threshold for scaling out"
}

variable "cpu_low_threshold" {
  description = "Low CPU utilization threshold for scaling in"
}

variable "cooldown_period" {
  description = "Cooldown period between scaling actions"
}

variable "scale_out_adjustment" {
  description = "Number of instances to add during scale-out"
}

variable "scale_in_adjustment" {
  description = "Number of instances to remove during scale-in"
}

variable "imported_ssl_cert_arn" {
  description = "ARN of the imported SSL certificate for HTTPS listener"
  type        = string
}