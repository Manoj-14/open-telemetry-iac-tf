output "cluster_endpoint" {
    description = "EKS cluster endpoint"
    value = aws_eks_cluster.cluster.endpoint
}

output "cluster_name" {
    description = "EKS cluster name"
    value = aws_eks_cluster.cluster.name
}
