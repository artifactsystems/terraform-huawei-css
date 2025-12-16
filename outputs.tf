################################################################################
# CSS Cluster
################################################################################

output "css_cluster_id" {
  description = "The CSS cluster ID"
  value       = try(huaweicloud_css_cluster.this[0].id, null)
}

output "css_cluster_name" {
  description = "The CSS cluster name"
  value       = try(huaweicloud_css_cluster.this[0].name, null)
}

output "css_cluster_endpoint" {
  description = "The CSS cluster endpoint"
  value       = try(huaweicloud_css_cluster.this[0].endpoint, null)
}

output "css_cluster_status" {
  description = "The CSS cluster status"
  value       = try(huaweicloud_css_cluster.this[0].status, null)
}

output "css_cluster_engine_type" {
  description = "The CSS cluster engine type"
  value       = try(huaweicloud_css_cluster.this[0].engine_type, var.engine_type)
}

output "css_cluster_engine_version" {
  description = "The CSS cluster engine version"
  value       = try(huaweicloud_css_cluster.this[0].engine_version, var.engine_version)
}

output "css_cluster_vpc_id" {
  description = "The VPC ID of the CSS cluster"
  value       = try(huaweicloud_css_cluster.this[0].vpc_id, null)
}

output "css_cluster_subnet_id" {
  description = "The subnet ID of the CSS cluster"
  value       = try(huaweicloud_css_cluster.this[0].subnet_id, null)
}

output "css_cluster_security_group_id" {
  description = "The security group ID of the CSS cluster"
  value       = try(huaweicloud_css_cluster.this[0].security_group_id, null)
}

output "css_cluster_nodes" {
  description = "List of nodes in the CSS cluster"
  value       = try(huaweicloud_css_cluster.this[0].nodes, [])
}

output "css_cluster_created_at" {
  description = "The creation time of the CSS cluster"
  value       = try(huaweicloud_css_cluster.this[0].created_at, null)
}

output "css_cluster_updated_at" {
  description = "The last update time of the CSS cluster"
  value       = try(huaweicloud_css_cluster.this[0].updated_at, null)
}

output "css_cluster_backup_available" {
  description = "Whether the snapshot function is enabled"
  value       = try(huaweicloud_css_cluster.this[0].backup_available, null)
}

output "css_cluster_disk_encrypted" {
  description = "Whether disks are encrypted"
  value       = try(huaweicloud_css_cluster.this[0].disk_encrypted, null)
}

output "css_cluster_is_period" {
  description = "Whether the cluster is billed on yearly/monthly mode"
  value       = try(huaweicloud_css_cluster.this[0].is_period, null)
}

output "css_cluster_bandwidth_resource_id" {
  description = "The resource ID of bandwidth"
  value       = try(huaweicloud_css_cluster.this[0].bandwidth_resource_id, null)
}

################################################################################
# VPC Endpoint
################################################################################

output "css_cluster_vpcep_endpoint_id" {
  description = "The VPC endpoint service ID"
  value       = try(huaweicloud_css_cluster.this[0].vpcep_endpoint_id, null)
}

output "css_cluster_vpcep_ip" {
  description = "The private IP address of VPC endpoint service"
  value       = try(huaweicloud_css_cluster.this[0].vpcep_ip, null)
}

################################################################################
# Public Access
################################################################################

output "css_cluster_public_ip" {
  description = "The public IP address of the CSS cluster"
  value       = try(huaweicloud_css_cluster.this[0].public_access[0].public_ip, null)
}

output "css_cluster_kibana_public_ip" {
  description = "The Kibana public IP address"
  value       = try(huaweicloud_css_cluster.this[0].kibana_public_access[0].public_ip, null)
}

################################################################################
# CSS Configuration
################################################################################

output "css_configuration_id" {
  description = "The CSS configuration ID"
  value       = try(huaweicloud_css_configuration.this[0].id, null)
}

output "css_configuration_cluster_id" {
  description = "The cluster ID associated with the CSS configuration"
  value       = try(huaweicloud_css_configuration.this[0].cluster_id, null)
}

################################################################################
# CSS Log Setting
################################################################################

output "css_log_setting_id" {
  description = "The CSS log setting ID"
  value       = try(huaweicloud_css_log_setting.this[0].id, null)
}

output "css_log_setting_cluster_id" {
  description = "The cluster ID associated with the CSS log setting"
  value       = try(huaweicloud_css_log_setting.this[0].cluster_id, null)
}

output "css_log_setting_updated_at" {
  description = "The update time of the CSS log setting"
  value       = try(huaweicloud_css_log_setting.this[0].updated_at, null)
}

output "css_log_setting_auto_enabled" {
  description = "Whether to enable automatic backup for CSS logs"
  value       = try(huaweicloud_css_log_setting.this[0].auto_enabled, null)
}

output "css_log_setting_log_switch" {
  description = "Whether to enable the log function for CSS"
  value       = try(huaweicloud_css_log_setting.this[0].log_switch, null)
}
