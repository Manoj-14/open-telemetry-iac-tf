resource "aws_vpc" "otel_vpc"{
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  enable_dns_support = "true"
  tags = {
    "Name" = "otel_vpc"
  }
}

resource "aws_subnet" "otel-subnet-pub" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.otel_vpc.id
  cidr_block = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zones[count.index]
  tags = {
    "Name" = "otel-subnet-pub"
  }
}

resource "aws_subnet" "otel-subnet-priv" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.otel_vpc.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    "Name" = "otel-subnet-priv"
  }
}

resource "aws_internet_gateway" "otel_IGW" {
  vpc_id = aws_vpc.otel_vpc.id
  tags = {
    "Name" = "otel_IGW"
  }
}


resource "aws_eip" "otel_nat_eip" {
  count = length(var.public_subnet_cidrs)
  domain = "vpc"
  tags = {
    "Name": "otel_nat_eip"
  }
}

resource "aws_nat_gateway" "otel_nat" {
  count = length(var.public_subnet_cidrs)
  allocation_id = aws_eip.otel_nat_eip[count.index].id
  subnet_id = aws_subnet.otel-subnet-pub[count.index].id
  tags = {
    "Name": "otel_nat"
  }
}

resource "aws_route_table" "otel-pub-RT" {
  vpc_id = aws_vpc.otel_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.otel_IGW.id
    }

    tags = {
      "Name" = "otel-pub-RT"
    }
}

resource "aws_route_table" "otel-priv-RT" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.otel_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.otel_nat[count.index].id
    }

    tags = {
      "Name" = "otel-priv-RT"
    }
}

resource "aws_route_table_association" "otel_subnet_public_rt" {
  count = length(var.public_subnet_cidrs)
  subnet_id = aws_subnet.otel-subnet-pub[count.index].id
  route_table_id = aws_route_table.otel-pub-RT.id
}


resource "aws_route_table_association" "otel_subnet_private_rt" {
  count = length(var.private_subnet_cidrs)
  subnet_id = aws_subnet.otel-subnet-priv[count.index].id
  route_table_id = aws_route_table.otel-priv-RT[count.index].id
}
