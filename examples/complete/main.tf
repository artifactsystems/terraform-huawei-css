provider "huaweicloud" {
  region = local.region
}

data "huaweicloud_availability_zones" "available" {}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "tr-west-1"

  vpc_cidr = "10.1.0.0/16"
  azs      = slice(data.huaweicloud_availability_zones.available.names, 0, 1)

  tags = {
    Name    = local.name
    Example = local.name
  }
}

################################################################################
# CSS Module
################################################################################

module "css_cluster" {
  source = "../../"

  name           = local.name
  engine_type    = "elasticsearch"
  engine_version = "7.10.2"

  security_mode = true
  password      = var.cluster_password
  https_enabled = true

  ess_node_config = {
    flavor          = "ess.spec-4u8g"
    instance_number = 1
    type            = "ess"
    volume = {
      volume_type = "HIGH"
      size        = 40
    }
  }

  master_node_config = {
    flavor          = "ess.spec-4u8g"
    instance_number = 3
    volume = {
      volume_type = "HIGH"
      size        = 40
    }
  }

  availability_zone = join(",", local.azs)
  vpc_id            = module.vpc.vpc_id
  subnet_id         = module.vpc.private_subnets[0]
  security_group_id = module.security_group.security_group_id

  # Backup strategy
  backup_strategy = {
    start_time = "00:00 GMT+08:00"
    keep_days  = 30
    prefix     = "${local.name}-backup"
  }

  # Enterprise configuration
  enterprise_project_id = var.enterprise_project_id

  # CSS configuration
  create_css_config = true

  # Performance tuning
  indices_queries_cache_size   = "15%"
  thread_pool_force_merge_size = "2"

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source = "github.com/artifactsystems/terraform-huawei-vpc?ref=v1.0.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]

  tags = local.tags
}

module "security_group" {
  source = "github.com/artifactsystems/terraform-huawei-security-group?ref=v1.0.0"

  name = local.name

  ingress_rules       = ["elasticsearch-rest-tcp", "elasticsearch-java-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  egress_rules        = ["all-all"]

  tags = local.tags
}
