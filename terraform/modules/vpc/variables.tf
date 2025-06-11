variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "availability_zones" {
  type        = list(string)
  description = "CIDR block for VPC"
}

variable "private_subnet_cidrs" {
  description = "list of CIDR's for private subnets"
  type = list(string)
}

variable "public_subnet_cidrs" {
  description = "list of CIDR's for public subnets"
  type = list(string)
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type = string
}
