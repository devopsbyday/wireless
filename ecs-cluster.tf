module "ec2-scheduler"{
    source = "./elasticache"

    count = local.create ? 1 : 0

}