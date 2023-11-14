resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tf-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_subnet" "public-a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/20"
  map_public_ip_on_launch = true
  availability_zone = "eu-north-1a"

  tags = {
    Name = "tf-public-a"
  }

}

resource "aws_subnet" "public-b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.16.0/20"
  map_public_ip_on_launch = true
  availability_zone = "eu-north-1b"

  tags = {
    Name = "tf-public-b"
  }
}

resource "aws_subnet" "private-a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.128.0/20"
  map_public_ip_on_launch = false
  availability_zone = "eu-north-1a"

  tags = {
    Name = "tf-private-a"
  }
}

resource "aws_subnet" "private-b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.144.0/20"
  map_public_ip_on_launch = false
  availability_zone = "eu-north-1b"

  tags = {
    Name = "tf-private-b"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "tf-public-route-table"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "tf-private-route-table"
  }
}

resource "aws_route_table_association" "public-a" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public-a.id
}

resource "aws_route_table_association" "public-b" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public-b.id
}

resource "aws_route_table_association" "private-a" {
  route_table_id = aws_route_table.private.id
  subnet_id = aws_subnet.private-a.id
}

resource "aws_route_table_association" "private-b" {
  route_table_id = aws_route_table.private.id
  subnet_id = aws_subnet.private-b.id
}

resource "aws_db_subnet_group" "db-subnet-group" {
  subnet_ids = [aws_subnet.private-a.id, aws_subnet.private-b.id]
}

resource "aws_elasticache_subnet_group" "ec-subnet-group" {
  subnet_ids = [aws_subnet.private-a.id, aws_subnet.private-b.id]
  name       = "ec-subnet-group"
}

#resource "aws_elasticache_subnet_group" "memcached-subnet-group" {
#  subnet_ids = [aws_subnet.private-a.id, aws_subnet.private-b.id]
#  name       = "memcached-subnet-group"
#}
