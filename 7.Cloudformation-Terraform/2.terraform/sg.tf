resource "aws_security_group" "elb-sg" {
  name = "elb-sg"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  }

  tags = {
    Name = "elb-sg"
  }
}

resource "aws_security_group" "asg-sg" {
  name = "asg-sg"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  tags = {
    Name = "asg-sg"
  }
}

resource "aws_security_group" "db-sg" {
  name = "db-sg"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  tags = {
    Name = "db-sg"
  }
}

resource "aws_security_group" "redis-sg" {
  name = "redis-sg"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 6379
    to_port   = 6379
    protocol  = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  tags = {
    Name = "redis-sg"
  }
}

resource "aws_security_group" "memc-sg" {
  name = "memc-sg"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 11211
    to_port   = 11211
    protocol  = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  tags = {
    Name = "memc-sg"
  }
}

resource "aws_db_subnet_group" "db-subnet-group" {
  subnet_ids = [aws_subnet.private-a.id, aws_subnet.private-b.id]
}

resource "aws_elasticache_subnet_group" "redis-subnet-group" {
  subnet_ids = [aws_subnet.private-a.id, aws_subnet.private-b.id]
  name       = "redis-subnet-group"
}

resource "aws_elasticache_subnet_group" "memcached-subnet-group" {
  subnet_ids = [aws_subnet.private-a.id, aws_subnet.private-b.id]
  name       = "memcached-subnet-group"
}