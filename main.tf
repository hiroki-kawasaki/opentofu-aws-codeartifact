data "aws_caller_identity" "current" {}

locals {
  kms_key_alias = var.kms_key_alias != "" ? var.kms_key_alias : "${var.domain_name}-key"
}

# KMS Customer Managed Key (CMK) for CodeArtifact domain encryption
resource "aws_kms_key" "codeartifact" {
  description             = var.kms_key_description
  enable_key_rotation     = var.kms_enable_key_rotation
  deletion_window_in_days = var.kms_deletion_window_in_days

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "EnableRootAccountAdmin"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root" }
        Action    = "kms:*"
        Resource  = "*"
      }
    ]
  })
}

resource "aws_kms_alias" "codeartifact" {
  name          = "alias/${local.kms_key_alias}"
  target_key_id = aws_kms_key.codeartifact.key_id
}

# CodeArtifact Domain
resource "aws_codeartifact_domain" "this" {
  domain         = var.domain_name
  encryption_key = aws_kms_key.codeartifact.arn
}

# CodeArtifact Repositories
resource "aws_codeartifact_repository" "this" {
  for_each = toset(var.repositories)

  domain      = aws_codeartifact_domain.this.domain
  repository  = each.key
  description = "CodeArtifact package repository for ${each.key}"

  tags = {
    Repository = each.key
  }
}
