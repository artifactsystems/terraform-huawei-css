provider "huaweicloud" {
  region = local.region
}

data "huaweicloud_availability_zones" "available" {}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "tr-west-1"

  vpc_cidr = "10.0.0.0/16"
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
  engine_version = "7.10.2"

  ess_node_config = {
    flavor          = "ess.spec-4u8g"
    instance_number = 1
    volume = {
      volume_type = "HIGH"
      size        = 40
    }
  }

  availability_zone = local.azs[0]
  vpc_id            = module.vpc.vpc_id
  subnet_id         = module.vpc.private_subnets[0]
  security_group_id = module.security_group.security_group_id

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
