variable "profile" {
    type = string
        description = "Aws profile name"
}

variable "aws_region" {
  description = "The AWS region to deploy resources to"
  type = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type  = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type = string
}

data "aws_availability_zones" "available" {}

variable "public_subnets" {
  type = map(object({
    cidr = string
  }))
}

variable "private_subnets" {
  type  = map(object({
    cidr = string
  }))
}