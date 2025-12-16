# HuaweiCloud CSS Terraform Module

Terraform module which creates CSS (Cloud Search Service) resources on HuaweiCloud.

## Usage

```hcl
module "css_cluster" {
  source = "github.com/artifactsystems/terraform-huawei-css?ref=v1.0.0"

  name           = "my-elasticsearch-cluster"
  engine_type    = "elasticsearch"
  engine_version = "7.10.2"

  ess_node_config = {
    flavor          = "ess.spec-4u8g"
    instance_number = 3
    volume = {
      volume_type = "HIGH"
      size        = 100
    }
  }

  availability_zone = "tr-west-1a"
  vpc_id            = "your-vpc-id"
  subnet_id         = "your-subnet-id"
  security_group_id = "your-security-group-id"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Features

This module supports the following CSS features:

### Core Features
- ✅ **CSS Cluster**: Create and manage Elasticsearch/OpenSearch clusters
- ✅ **Multiple Engine Types**: Support for both Elasticsearch (7.6.2, 7.9.3, 7.10.2) and OpenSearch (1.3.6, 2.3.0)
- ✅ **Multi-Node Architecture**: Configure ESS (data), master, client, and cold data nodes
- ✅ **Security Mode**: Enable authentication with username/password
- ✅ **HTTPS Support**: Encrypted cluster connections
- ✅ **Log Management**: Configure log storage in OBS buckets with automated backup

### Node Configuration
- ✅ **ESS (Data) Nodes**: Primary data storage nodes with configurable flavor, count, and volume
- ✅ **Master Nodes**: Dedicated master nodes for cluster management
- ✅ **Client Nodes**: Dedicated client nodes for query coordination
- ✅ **Cold Data Nodes**: Cost-effective storage for infrequently accessed data

### Backup & Recovery
- ✅ **Backup Strategy**: Automated backup with configurable schedule, retention, and OBS storage
- ✅ **Snapshot Management**: Store backups in OBS buckets with custom prefixes and paths

### Network & Access
- ✅ **Public Access**: Internet access with bandwidth control and IP whitelist
- ✅ **Kibana Public Access**: Separate public access for Kibana dashboard
- ✅ **VPC Endpoint**: Private endpoint service for secure VPC connectivity

### Cluster Configuration
- ✅ **CORS Settings**: Cross-origin resource sharing configuration
- ✅ **Performance Tuning**: Query cache size, thread pool configuration
- ✅ **Reindex Whitelist**: Remote cluster whitelist for data migration

### Enterprise & Billing
- ✅ **Enterprise Project Integration**: Support for HuaweiCloud Enterprise Projects
- ✅ **Flexible Billing**: Pay-per-use (postPaid) or subscription (prePaid) modes
- ✅ **Auto Renewal**: Automatic subscription renewal for prePaid instances
- ✅ **Tag Management**: Comprehensive tagging support for all resources

## Examples

- [basic](./examples/basic) - Basic Elasticsearch cluster with single data node
- [complete](./examples/complete) - Complete cluster with security mode, HTTPS, master nodes, backup strategy, and performance tuning

## Node Architecture

The module supports four types of nodes for building production-ready clusters:

### ESS (Data) Nodes
Primary nodes that store data and handle indexing/search operations. Required for all clusters.

```hcl
ess_node_config = {
  flavor          = "ess.spec-4u8g"
  instance_number = 3
  volume = {
    volume_type = "HIGH"  # HIGH or ULTRAHIGH
    size        = 100     # GB
  }
}
```

### Master Nodes (Optional)
Dedicated nodes for cluster management in production environments.

```hcl
master_node_config = {
  flavor          = "ess.spec-4u8g"
  instance_number = 3  # Always use odd numbers (3, 5, 7)
  volume = {
    volume_type = "HIGH"
    size        = 40
  }
}
```

### Client Nodes (Optional)
Coordinate queries and aggregate results from data nodes.

```hcl
client_node_config = {
  flavor          = "ess.spec-4u8g"
  instance_number = 2
  volume = {
    volume_type = "HIGH"
    size        = 40
  }
}
```

### Cold Data Nodes (Optional)
Cost-effective storage for historical or infrequently accessed data.

```hcl
cold_node_config = {
  flavor          = "ess.spec-4u8g"
  instance_number = 2
  volume = {
    volume_type = "HIGH"
    size        = 500
  }
}
```

## Security Configuration

### Enable Security Mode with HTTPS

```hcl
module "css_cluster" {
  source = "github.com/artifactsystems/terraform-huawei-css?ref=v1.0.0"

  name           = "secure-cluster"
  engine_version = "7.10.2"

  security_mode = true
  password      = "YourSecurePassword@123"
  https_enabled = true

  # ... other configuration
}
```

## Backup Configuration

```hcl
module "css_cluster" {
  source = "github.com/artifactsystems/terraform-huawei-css?ref=v1.0.0"

  name           = "backup-enabled-cluster"
  engine_version = "7.10.2"

  backup_strategy = {
    start_time  = "00:00 GMT+08:00"
    keep_days   = 7
    prefix      = "daily-backup"
    bucket      = "my-backup-bucket"      # Optional: OBS bucket
    backup_path = "css-backups/"          # Optional: OBS path
    agency      = "css-agency"            # Optional: IAM agency
  }

  # ... other configuration
}
```

## Cluster Configuration (Performance Tuning)

```hcl
module "css_cluster" {
  source = "github.com/artifactsystems/terraform-huawei-css?ref=v1.0.0"

  name           = "tuned-cluster"
  engine_version = "7.10.2"

  # Enable cluster configuration
  create_css_config = true

  # CORS configuration
  http_cors_enabled      = "true"
  http_cors_allow_origin = "*"
  http_cors_max_age      = "86400"
  http_cors_allow_methods = "GET,POST,PUT,DELETE,OPTIONS"

  # Performance tuning
  indices_queries_cache_size   = "15%"
  thread_pool_force_merge_size = "2"

  # Reindex whitelist for data migration
  reindex_remote_whitelist = "192.168.0.*:9200"

  # ... other configuration
}
```

## Conditional Creation

Toggle resource creation using the `create` variable:

```hcl
module "css_cluster" {
  source = "github.com/artifactsystems/terraform-huawei-css?ref=v1.0.0"

  create = false  # Disable all resource creation
  # ... other configuration
}
```

Or disable specific resources:

```hcl
module "css_cluster" {
  source = "github.com/artifactsystems/terraform-huawei-css?ref=v1.0.0"

  create_css_cluster     = true   # Create the cluster
  create_css_config      = false  # Skip configuration resource
  create_css_log_setting = false  # Skip log setting resource

  # ... other configuration
}
```

## Log Management

Configure log storage and backup to OBS buckets for monitoring and compliance:

```hcl
module "css_cluster" {
  source = "github.com/artifactsystems/terraform-huawei-css?ref=v1.0.0"

  name           = "log-enabled-cluster"
  engine_version = "7.10.2"

  # Enable log setting
  create_css_log_setting = true
  log_setting_agency     = "css-log-agency"
  log_setting_bucket     = "my-css-logs-bucket"
  log_setting_base_path  = "elasticsearch/logs/"
  log_setting_period     = "00:00 GMT+08:00"

  # ... other configuration
}
```

## Contributing

Report issues/questions/feature requests in the [issues](https://github.com/artifactsystems/terraform-huawei-css/issues/new) section.

Full contributing [guidelines are covered here](.github/CONTRIBUTING.md).
