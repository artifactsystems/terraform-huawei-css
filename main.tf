locals {
  create_css_cluster     = var.create_css_cluster && var.create
  create_css_config      = var.create_css_config && local.create_css_cluster
  create_css_log_setting = var.create_css_log_setting && local.create_css_cluster

  cluster_name = var.name
}

################################################################################
# CSS Cluster
################################################################################

resource "huaweicloud_css_cluster" "this" {
  count = local.create_css_cluster ? 1 : 0

  name           = local.cluster_name
  engine_type    = var.engine_type
  engine_version = var.engine_version

  ess_node_config {
    flavor          = var.ess_node_config.flavor
    instance_number = var.ess_node_config.instance_number
    type            = var.ess_node_config.type

    dynamic "volume" {
      for_each = var.ess_node_config.volume != null ? [var.ess_node_config.volume] : []
      content {
        volume_type = volume.value.volume_type
        size        = volume.value.size
      }
    }
  }

  dynamic "master_node_config" {
    for_each = var.master_node_config != null ? [var.master_node_config] : []
    content {
      flavor          = master_node_config.value.flavor
      instance_number = master_node_config.value.instance_number

      volume {
        volume_type = master_node_config.value.volume.volume_type
        size        = master_node_config.value.volume.size
      }
    }
  }

  dynamic "client_node_config" {
    for_each = var.client_node_config != null ? [var.client_node_config] : []
    content {
      flavor          = client_node_config.value.flavor
      instance_number = client_node_config.value.instance_number

      volume {
        volume_type = client_node_config.value.volume.volume_type
        size        = client_node_config.value.volume.size
      }
    }
  }

  dynamic "cold_node_config" {
    for_each = var.cold_node_config != null ? [var.cold_node_config] : []
    content {
      flavor          = cold_node_config.value.flavor
      instance_number = cold_node_config.value.instance_number

      dynamic "volume" {
        for_each = cold_node_config.value.volume != null ? [cold_node_config.value.volume] : []
        content {
          volume_type = volume.value.volume_type
          size        = volume.value.size
        }
      }
    }
  }

  vpc_id            = var.vpc_id
  subnet_id         = var.subnet_id
  security_group_id = var.security_group_id
  availability_zone = var.availability_zone

  security_mode = var.security_mode
  password      = var.password
  https_enabled = var.https_enabled

  dynamic "backup_strategy" {
    for_each = var.backup_strategy != null ? [var.backup_strategy] : []
    content {
      start_time  = backup_strategy.value.start_time
      keep_days   = backup_strategy.value.keep_days
      prefix      = backup_strategy.value.prefix
      bucket      = backup_strategy.value.bucket
      backup_path = backup_strategy.value.backup_path
      agency      = backup_strategy.value.agency
    }
  }

  dynamic "public_access" {
    for_each = var.public_access != null ? [var.public_access] : []
    content {
      bandwidth         = public_access.value.bandwidth
      whitelist_enabled = public_access.value.whitelist_enabled
      whitelist         = public_access.value.whitelist
    }
  }

  dynamic "kibana_public_access" {
    for_each = var.kibana_public_access != null ? [var.kibana_public_access] : []
    content {
      bandwidth         = kibana_public_access.value.bandwidth
      whitelist_enabled = kibana_public_access.value.whitelist_enabled
      whitelist         = kibana_public_access.value.whitelist
    }
  }

  dynamic "vpcep_endpoint" {
    for_each = var.vpcep_endpoint != null ? [var.vpcep_endpoint] : []
    content {
      endpoint_with_dns_name = vpcep_endpoint.value.endpoint_with_dns_name
      whitelist              = vpcep_endpoint.value.whitelist
    }
  }

  enterprise_project_id = var.enterprise_project_id

  charging_mode = var.charging_mode
  period_unit   = var.period_unit
  period        = var.period
  auto_renew    = var.auto_renew

  tags = var.tags

  dynamic "timeouts" {
    for_each = length(var.timeouts) > 0 ? [var.timeouts] : []
    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }
}

################################################################################
# CSS Configuration
################################################################################

resource "huaweicloud_css_configuration" "this" {
  count = local.create_css_config ? 1 : 0

  cluster_id = huaweicloud_css_cluster.this[0].id

  http_cors_enabled          = var.http_cors_enabled
  http_cors_allow_origin     = var.http_cors_allow_origin
  http_cors_max_age          = var.http_cors_max_age
  http_cors_allow_headers    = var.http_cors_allow_headers
  http_cors_allow_methods    = var.http_cors_allow_methods
  http_cors_allow_credetials = var.http_cors_allow_credetials

  reindex_remote_whitelist     = var.reindex_remote_whitelist
  indices_queries_cache_size   = var.indices_queries_cache_size
  thread_pool_force_merge_size = var.thread_pool_force_merge_size

  dynamic "timeouts" {
    for_each = length(var.css_config_timeouts) > 0 ? [var.css_config_timeouts] : []
    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  depends_on = [huaweicloud_css_cluster.this]
}

################################################################################
# CSS Log Setting
################################################################################

resource "huaweicloud_css_log_setting" "this" {
  count = local.create_css_log_setting ? 1 : 0

  cluster_id = huaweicloud_css_cluster.this[0].id
  agency     = var.log_setting_agency
  base_path  = var.log_setting_base_path
  bucket     = var.log_setting_bucket
  period     = var.log_setting_period

  depends_on = [huaweicloud_css_cluster.this]
}
