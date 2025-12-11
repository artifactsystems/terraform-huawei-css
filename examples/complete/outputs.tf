################################################################################
# CSS Cluster
################################################################################

output "css_cluster_id" {
  description = "ID of the CSS cluster"
  value       = module.css_cluster.css_cluster_id
}

output "css_cluster_name" {
  description = "Name of the CSS cluster"
  value       = module.css_cluster.css_cluster_name
}

output "css_cluster_endpoint" {
  description = "Endpoint of the CSS cluster"
  value       = module.css_cluster.css_cluster_endpoint
}

output "css_cluster_status" {
  description = "Status of the CSS cluster"
  value       = module.css_cluster.css_cluster_status
}

output "css_cluster_nodes" {
  description = "List of nodes in the CSS cluster"
  value       = module.css_cluster.css_cluster_nodes
}

output "css_cluster_created_at" {
  description = "Creation time of the CSS cluster"
  value       = module.css_cluster.css_cluster_created_at
}

################################################################################
# CSS Configuration
################################################################################

output "css_configuration_id" {
  description = "ID of the CSS configuration"
  value       = module.css_cluster.css_configuration_id
}

################################################################################
# Supporting Resources
################################################################################

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

output "security_group_id" {
  description = "ID of the CSS security group"
  value       = module.security_group.security_group_id
}
