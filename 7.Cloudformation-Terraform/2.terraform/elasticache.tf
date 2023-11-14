resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "tf-redis"
  engine               = "redis"
  node_type            = "cache.t4g.micro"
  num_cache_nodes      = 1
  port                 = 6379
  subnet_group_name = aws_elasticache_subnet_group.ec-subnet-group.name
  security_group_ids = [aws_security_group.redis-sg.id]
}

resource "aws_elasticache_cluster" "memcached" {
  cluster_id           = "tf-memcached"
  engine               = "memcached"
  node_type            = "cache.t4g.micro"
  num_cache_nodes      = 1
  port                 = 11211
  subnet_group_name = aws_elasticache_subnet_group.ec-subnet-group.name
  security_group_ids = [aws_security_group.memc-sg.id]
}