output "vpc_id" {
    description = "VPC ID"
    value       = aws_vpc.otel_vpc.id
}

output "public_subnets" {
    description = "Public subnets"
    value = aws_subnet.otel-subnet-pub[*].id
}

output "private_subnets" {
    description = "Private subnets"
    value = aws_subnet.otel-subnet-priv[*].id
}
