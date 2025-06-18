variable "cluster_name" {
  type        = string
  description = "Name of ther EKS cluster"
}

variable "cluster_version" {
    type = string
    description= "Kubernetes version"
}

variable "vpc_id" {
    description= "vpc id"
    type = string
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet Ids"
}

variable "node_groups" {
    description = "Node group configuration"
    type = map(object({
        instance_types = list(string)
        capacity_type = string
        scaling_config = object({
            desired_size = number
            max_size = number
            min_size = number
        })
    }))
}
