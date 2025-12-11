################################################################################
# CSS Cluster Configuration
################################################################################

variable "cluster_password" {
  description = "Password for the CSS cluster administrator. Must be 8-32 characters and contain at least 3 character types: uppercase, lowercase, digits, special characters"
  type        = string
  sensitive   = true
  default     = "MyP@ssw0rd123!"
}

################################################################################
# Enterprise Configuration
################################################################################

variable "enterprise_project_id" {
  description = "The enterprise project ID for resource management"
  type        = string
  default     = null
}
