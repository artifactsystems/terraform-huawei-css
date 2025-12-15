# Basic CSS Cluster

This directory contains a basic CSS (Cloud Search Service) Elasticsearch cluster configuration suitable for development or testing environments.

This example creates a single-node Elasticsearch cluster with minimal configuration.

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
- Basic CSS Elasticsearch cluster with single data node

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

This example does not require any inputs. All configuration is handled through locals in main.tf.

## Outputs

| Name | Description |
|------|-------------|
| css_cluster_id | ID of the CSS cluster |
| css_cluster_name | Name of the CSS cluster |
| css_cluster_endpoint | Endpoint of the CSS cluster |
| css_cluster_status | Status of the CSS cluster |
