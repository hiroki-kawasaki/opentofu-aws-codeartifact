variable "aws_region" {
  description = "AWS region for provisioning CodeArtifact and KMS."
  type        = string
  default     = "ap-northeast-1"
}

variable "aws_profile" {
  description = "AWS named profile for authentication (leave empty to use default credential chain)."
  type        = string
  default     = ""
}

variable "domain_name" {
  description = "Name of the CodeArtifact domain."
  type        = string
  default     = "artifacts"
}

variable "kms_key_alias" {
  description = "Alias name for the KMS CMK (without 'alias/' prefix). If empty, defaults to '<domain_name>-key'."
  type        = string
  default     = ""
}

variable "kms_key_description" {
  description = "Description for the KMS CMK."
  type        = string
  default     = "KMS CMK for CodeArtifact domain encryption"
}

variable "kms_enable_key_rotation" {
  description = "Enable automatic annual key rotation for the KMS CMK."
  type        = bool
  default     = true
}

variable "kms_deletion_window_in_days" {
  description = "Duration in days after which the key is deleted when scheduled for deletion."
  type        = number
  default     = 30
}

variable "repositories" {
  description = "List of CodeArtifact repository names to create within the domain."
  type        = list(string)
  default     = ["dev", "stg", "prd"]
}

variable "default_tags" {
  description = "Default resource tags applied to all supported resources."
  type        = map(string)
  default = {
    ManagedBy = "OpenTofu"
  }
}
