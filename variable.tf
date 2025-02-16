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

variable "public_subnets" {
  description = "Map of public subnet configurations"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  description = "Map of private subnet configurations"
  type  = map(object({
    cidr = string
    az   = string
  }))
}