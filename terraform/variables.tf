variable "region" {
  type        = string
  description = "aws-region"
  default     = "us-east-1"
}

variable "availability_zones" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  description = "avalibility zones"
}


variable "bucket" {
  type        = string
  default     = "otel-tf-state"
  description = "backend s3 location"
}

variable "dynamodb_table" {
  type        = string
  default     = "otel-tf-lockin"
  description = "tf state lock"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "cidr for vpc"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "public cidr"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
  description = "private cidr"
}


variable "cluster_name" {
  type        = string
  default     = "otel-eks-cluster"
  description = "k8s cluster name"
}
