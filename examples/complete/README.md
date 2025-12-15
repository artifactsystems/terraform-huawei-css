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
- CSS Elasticsearch cluster with:
  - Security mode enabled (authentication required)
  - HTTPS enabled
  - Data nodes (ESS) and dedicated master nodes
  - Backup strategy with retention policy
  - CSS configuration with performance tuning

## Features Demonstrated

- **Security Mode**: Authentication with username/password
- **HTTPS**: Encrypted cluster connections
- **Master Nodes**: Dedicated master nodes for cluster management
- **Backup Strategy**: Automated backups with 30-day retention
- **CSS Configuration**: Query cache and thread pool tuning
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

## Resources

| Name | Type |
|------|------|
| huaweicloud_availability_zones.available | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster_password | Password for the CSS cluster administrator | `string` | `"MyP@ssw0rd123!"` | no |
| enterprise_project_id | The enterprise project ID for resource management | `string` | `null` | no |

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
| vpc_id | ID of the VPC |
| private_subnets | List of private subnet IDs |
| security_group_id | ID of the CSS security group |
