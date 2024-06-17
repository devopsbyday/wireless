module "elasticache" {
  source = "terraform-aws-modules/elasticache/aws"

  cluster_id               = "tps-wl-redis"
  create_cluster           = true
  create_replication_group = false

  engine_version = "7.1"
  node_type      = "cache.t4g.micro"

  vpc_id = module.vpc.vpc_id
  security_group_rules = {
    ingress_vpc = {
      description = "TPS Wireless Cache Ingress"
      cidr_ipv4   = module.vpc.vpc_cidr_block
    }
  }

  subnet_ids = module.vpc.private_subnets

  create_parameter_group = true
  parameter_group_family = "redis7-and-above"
  parameters = [
    {
      name  = "latency-tracking"
      value = "yes"
    }
  ]

  tags = {
    Environment = "tps-dev"
  }
}