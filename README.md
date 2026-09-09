# opentofu-codeartifact

OpenTofu configuration for provisioning an AWS CodeArtifact domain with KMS customer-managed key (CMK) encryption and configurable package repositories.

## Overview

This repository provides self-contained infrastructure-as-code (IaC) to create:

- **AWS KMS Customer Managed Key (CMK)**: Dedicated KMS key and alias for encrypting CodeArtifact packages with annual key rotation enabled.
- **AWS CodeArtifact Domain**: Secure artifact repository domain encrypted with the KMS CMK.
- **AWS CodeArtifact Repositories**: Polyglot package repositories (supporting PyPI, npm, Maven, etc.) configured via input variables (defaults to `dev`, `stg`, `prd`).

## Prerequisites

- [OpenTofu](https://opentofu.org/) >= 1.12
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate IAM permissions to manage CodeArtifact and KMS resources.

## Usage

### 1. Configure Variables

Copy the example variable definitions file and adjust it to your environment:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars`:

```hcl
aws_region   = "ap-northeast-1"
domain_name  = "my-artifacts"

repositories = [
  "dev",
  "stg",
  "prd"
]
```

### 2. OpenTofu Commands

Run operations using OpenTofu or Make:

```bash
# Show available targets
make help

# Format configuration
make fmt

# Validate syntax
make validate

# Preview execution plan
make plan

# Apply infrastructure changes
make apply

# Destroy infrastructure
make destroy
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `aws_region` | AWS region for CodeArtifact and KMS | `string` | `"ap-northeast-1"` | no |
| `aws_profile` | AWS named profile for authentication | `string` | `""` | no |
| `domain_name` | Name of the CodeArtifact domain | `string` | `"artifacts"` | no |
| `kms_key_alias` | Alias name for the KMS key (without `alias/` prefix) | `string` | `""` | no |
| `kms_key_description` | Description for the KMS CMK | `string` | `"KMS CMK for CodeArtifact domain encryption"` | no |
| `kms_enable_key_rotation` | Enable annual key rotation | `bool` | `true` | no |
| `kms_deletion_window_in_days` | Key deletion waiting period in days | `number` | `30` | no |
| `repositories` | List of package repositories to create | `list(string)` | `["dev", "stg", "prd"]` | no |
| `default_tags` | Default tags applied to all resources | `map(string)` | `{ ManagedBy = "OpenTofu" }` | no |

## Outputs

| Name | Description |
|------|-------------|
| `domain_name` | Name of the CodeArtifact domain |
| `domain_arn` | ARN of the CodeArtifact domain |
| `domain_owner` | AWS account ID of the domain owner |
| `kms_key_arn` | ARN of the KMS CMK |
| `kms_key_alias` | Alias name of the KMS CMK |
| `repository_arns` | Map of repository names to their ARNs |
| `repository_endpoints_pypi` | Map of repository names to their PyPI endpoints |
| `repository_endpoints_npm` | Map of repository names to their npm endpoints |
