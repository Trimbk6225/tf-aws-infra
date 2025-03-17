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

variable "db_password" {
  description = "The password for the RDS database"
  type        = string
  sensitive   = true
}

# Database port
variable "db_port" {
  description = "The port on which the database listens (e.g., 3306 for MySQL)"
  type        = number
}

# Security group for database access
variable "multi_az" {
  description = "Specifies if the RDS instance should be Multi-AZ"
  type        = bool
}

variable "db_name" {
  description = "The name of the database to create in the RDS instance"
  type        = string
}
