################################################################################
# General
################################################################################

variable "create" {
  description = "Whether to create CSS resources"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# CSS Cluster
################################################################################

variable "create_css_cluster" {
  description = "Whether to create a CSS cluster"
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the CSS cluster"
  type        = string
}

variable "engine_type" {
  description = "Specifies the engine type. Valid values: elasticsearch, opensearch"
  type        = string
  default     = "elasticsearch"
}

variable "engine_version" {
  description = "Specifies the engine version. For elasticsearch: 7.6.2, 7.9.3, 7.10.2. For opensearch: 1.3.6, 2.3.0"
  type        = string
}

variable "security_mode" {
  description = "Specifies whether to enable authentication. Valid values: true, false"
  type        = bool
  default     = false
}

variable "password" {
  description = "Specifies the password of the cluster administrator in security mode. Required when security_mode is true. Must be 8-32 characters and contain at least 3 character types: uppercase, lowercase, digits, special characters"
  type        = string
  default     = null
  sensitive   = true
}

variable "https_enabled" {
  description = "Specifies whether to enable HTTPS. When enabled, security_mode must be true"
  type        = bool
  default     = false
}

################################################################################
# Network Configuration
################################################################################

variable "vpc_id" {
  description = "The VPC ID where the CSS cluster will be created"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID where the CSS cluster will be created"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID to associate with the CSS cluster"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone for the CSS cluster. Separate multiple AZs with commas"
  type        = string
}

################################################################################
# Node Configuration
################################################################################

variable "ess_node_config" {
  description = "Configuration for ESS (data) nodes"
  type = object({
    flavor          = string
    instance_number = number
    type            = optional(string)
    volume = optional(object({
      volume_type = string
      size        = number
    }))
  })
}

variable "master_node_config" {
  description = "Configuration for master nodes"
  type = object({
    flavor          = string
    instance_number = number
    volume = object({
      volume_type = string
      size        = number
    })
  })
  default = null
}

variable "client_node_config" {
  description = "Configuration for client nodes"
  type = object({
    flavor          = string
    instance_number = number
    volume = object({
      volume_type = string
      size        = number
    })
  })
  default = null
}

variable "cold_node_config" {
  description = "Configuration for cold data nodes"
  type = object({
    flavor          = string
    instance_number = number
    volume = optional(object({
      volume_type = string
      size        = number
    }))
  })
  default = null
}

################################################################################
# Backup Configuration
################################################################################

variable "backup_strategy" {
  description = "Backup strategy configuration"
  type = object({
    start_time  = string
    keep_days   = optional(number)
    prefix      = optional(string)
    bucket      = optional(string)
    backup_path = optional(string)
    agency      = optional(string)
  })
  default = null
}

################################################################################
# Public Access Configuration
################################################################################

variable "public_access" {
  description = "Public network access configuration"
  type = object({
    bandwidth         = number
    whitelist_enabled = bool
    whitelist         = optional(string)
  })
  default = null
}

variable "kibana_public_access" {
  description = "Kibana public network access configuration"
  type = object({
    bandwidth         = number
    whitelist_enabled = bool
    whitelist         = string
  })
  default = null
}

################################################################################
# VPC Endpoint Configuration
################################################################################

variable "vpcep_endpoint" {
  description = "VPC endpoint service configuration"
  type = object({
    endpoint_with_dns_name = bool
    whitelist              = optional(list(string))
  })
  default = null
}

################################################################################
# Enterprise Configuration
################################################################################

variable "enterprise_project_id" {
  description = "The enterprise project ID for the CSS cluster"
  type        = string
  default     = null
}

################################################################################
# Billing Configuration
################################################################################

variable "charging_mode" {
  description = "Specifies the charging mode. Valid values: prePaid, postPaid"
  type        = string
  default     = "postPaid"
}

variable "period_unit" {
  description = "Specifies the charging period unit. Required when charging_mode is prePaid. Valid values: month, year"
  type        = string
  default     = null
}

variable "period" {
  description = "Specifies the charging period. Required when charging_mode is prePaid"
  type        = number
  default     = null
}

variable "auto_renew" {
  description = "Specifies whether auto renew is enabled. Valid values: true, false"
  type        = string
  default     = null
}

################################################################################
# Timeouts
################################################################################

variable "timeouts" {
  description = "Terraform resource management timeouts for CSS cluster"
  type        = map(string)
  default     = {}
}

################################################################################
# CSS Configuration
################################################################################

variable "create_css_config" {
  description = "Whether to create CSS cluster configuration"
  type        = bool
  default     = false
}

variable "http_cors_enabled" {
  description = "Whether to allow cross-domain access. Valid values: true, false"
  type        = string
  default     = null
}

variable "http_cors_allow_origin" {
  description = "Origin IP address allowed for cross-domain access"
  type        = string
  default     = null
}

variable "http_cors_max_age" {
  description = "Cache duration of the browser in seconds"
  type        = string
  default     = null
}

variable "http_cors_allow_headers" {
  description = "Headers allowed for cross-domain access"
  type        = string
  default     = null
}

variable "http_cors_allow_methods" {
  description = "Methods allowed for cross-domain access"
  type        = string
  default     = null
}

variable "http_cors_allow_credetials" {
  description = "Whether to return the Access-Control-Allow-Credentials header during cross-domain access. Valid values: true, false"
  type        = string
  default     = null
}

variable "reindex_remote_whitelist" {
  description = "Configured for migrating data from current cluster to target cluster through reindex API"
  type        = string
  default     = null
}

variable "indices_queries_cache_size" {
  description = "Cache size in the query phase. Value range: 1% to 100%"
  type        = string
  default     = null
}

variable "thread_pool_force_merge_size" {
  description = "Queue size in the force merge thread pool"
  type        = string
  default     = null
}

variable "css_config_timeouts" {
  description = "Terraform resource management timeouts for CSS configuration"
  type        = map(string)
  default     = {}
}

################################################################################
# CSS Log Setting
################################################################################

variable "create_css_log_setting" {
  description = "Whether to create CSS log setting"
  type        = bool
  default     = false
}

variable "log_setting_agency" {
  description = "The agency name. You can create an agency to allow CSS to call other cloud services"
  type        = string
  default     = null
}

variable "log_setting_base_path" {
  description = "The storage path of backed up logs in the OBS bucket"
  type        = string
  default     = null
}

variable "log_setting_bucket" {
  description = "The name of the OBS bucket for storing logs"
  type        = string
  default     = null
}

variable "log_setting_period" {
  description = "The backup start time. Format: GMT"
  type        = string
  default     = null
}
