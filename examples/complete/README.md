# Complete CSS Cluster

This directory contains a complete CSS (Cloud Search Service) Elasticsearch cluster configuration with security features and advanced settings suitable for production environments.

## Usage

To run this example, execute:

```bash
terraform init
terraform plan
terraform apply
```

**Note:** This example may create billable resources (CSS cluster, VPC, etc.). Run `terraform destroy` when you no longer need these resources.

## Configuration

This example creates:

- VPC and private subnet
- Security group with Elasticsearch ports (9200, 9300)
- IAM agency for CSS to access OBS
- OBS bucket for CSS logs storage
- CSS Elasticsearch cluster with:
  - Security mode enabled (authentication required)
  - HTTPS enabled
  - Data nodes (ESS) and dedicated master nodes
  - Backup strategy with retention policy
  - CSS configuration with performance tuning
  - Log management with OBS storage

## Features Demonstrated

- **Security Mode**: Authentication with username/password
- **HTTPS**: Encrypted cluster connections
- **Master Nodes**: Dedicated master nodes for cluster management
- **Backup Strategy**: Automated backups with 30-day retention
- **CSS Configuration**: Query cache and thread pool tuning
- **Log Management**: Log storage in OBS buckets for monitoring and compliance
- **Enterprise Project**: Optional enterprise project association

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| huaweicloud | >= 1.79.0 |

## Providers

| Name | Version |
|------|---------|
| huaweicloud | >= 1.79.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| css_cluster | ../../ | n/a |
| vpc | github.com/artifactsystems/terraform-huawei-vpc | v1.0.0 |
| security_group | github.com/artifactsystems/terraform-huawei-security-group | v1.0.0 |
| iam_agency | ../../../terraform-huawei-iam | n/a |
| obs_logs_bucket | github.com/artifactsystems/terraform-huawei-obs | v1.0.0 |

## Resources

| Name | Type |
|------|------|
| huaweicloud_availability_zones.available | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster_password | Password for the CSS cluster administrator | `string` | `"MyP@ssw0rd123!"` | no |
| enterprise_project_id | The enterprise project ID for resource management | `string` | `null` | no |
| log_setting_base_path | The storage path of backed up logs in the OBS bucket | `string` | `"elasticsearch/logs/"` | no |

## Outputs

| Name | Description |
|------|-------------|
| css_cluster_id | ID of the CSS cluster |
| css_cluster_name | Name of the CSS cluster |
| css_cluster_endpoint | Endpoint of the CSS cluster |
| css_cluster_status | Status of the CSS cluster |
| css_cluster_nodes | List of nodes in the CSS cluster |
| css_cluster_created_at | Creation time of the CSS cluster |
| css_configuration_id | ID of the CSS configuration |
| css_log_setting_id | ID of the CSS log setting |
| css_log_setting_auto_enabled | Whether automatic backup is enabled for CSS logs |
| css_log_setting_log_switch | Whether the log function is enabled for CSS |
| vpc_id | ID of the VPC |
| private_subnets | List of private subnet IDs |
| security_group_id | ID of the CSS security group |

## Prerequisites

This example is fully automated and creates all required resources:

- **IAM Agency**: Automatically created with OBS access permissions
- **OBS Bucket**: Automatically created for log storage
- **Network Resources**: VPC, subnet, and security group are created automatically

No manual setup required!
