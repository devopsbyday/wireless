resource "aws_vpc" "ec_redis_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "ec_redis_vpc"
  }
}

resource "aws_subnet" "ec_redis_subnet" {
  vpc_id     = aws_vpc.ec_redis_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "ec_redis_subnet"
  }
}

resource "aws_security_group" "elasticache_sg" {
  name        = "elasticache_sg"
  description = "Allow Redis traffic"
  vpc_id      = aws_vpc.ec_redis_vpc.id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}

resource "aws_elasticache_subnet_group" "ec_redis_subnet_group" {
  name       = "ec_redis_subnet_group"
  subnet_ids = [aws_subnet.ec_redis_subnet.id]

  tags = {
    Name = "ec_redis_subnet_group"
  }
}

resource "aws_elasticache_cluster" "ec_redis_cluster" {
  cluster_id           = "ec-redis-cluster"
  engine               = "redis"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 2
  parameter_group_name = "default.redis3.2"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.ec_redis_subnet_group.name
  security_group_ids   = [aws_security_group.elasticache_sg.id]

  tags = {
    Name = "ec_redis_cluster"
  }
}
