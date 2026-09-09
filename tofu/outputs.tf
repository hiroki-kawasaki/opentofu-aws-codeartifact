output "domain_name" {
  description = "Name of the CodeArtifact domain."
  value       = aws_codeartifact_domain.this.domain
}

output "domain_arn" {
  description = "ARN of the CodeArtifact domain."
  value       = aws_codeartifact_domain.this.arn
}

output "domain_owner" {
  description = "AWS account ID of the domain owner."
  value       = aws_codeartifact_domain.this.owner
}

output "kms_key_arn" {
  description = "ARN of the KMS CMK used to encrypt the CodeArtifact domain."
  value       = aws_kms_key.codeartifact.arn
}

output "kms_key_alias" {
  description = "Alias name of the KMS CMK."
  value       = aws_kms_alias.codeartifact.name
}

output "repository_arns" {
  description = "Map of repository names to their ARNs."
  value       = { for name, repo in aws_codeartifact_repository.this : name => repo.arn }
}

output "repository_endpoints_pypi" {
  description = "Map of repository names to their PyPI simple endpoints."
  value = {
    for name, repo in aws_codeartifact_repository.this :
    name => "https://${aws_codeartifact_domain.this.domain}-${aws_codeartifact_domain.this.owner}.d.codeartifact.${var.aws_region}.amazonaws.com/pypi/${repo.repository}/simple/"
  }
}

output "repository_endpoints_npm" {
  description = "Map of repository names to their npm endpoints."
  value = {
    for name, repo in aws_codeartifact_repository.this :
    name => "https://${aws_codeartifact_domain.this.domain}-${aws_codeartifact_domain.this.owner}.d.codeartifact.${var.aws_region}.amazonaws.com/npm/${repo.repository}/"
  }
}
