TOFU := tofu

.DEFAULT_GOAL := help

.PHONY: help
help: ## Display this help message
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: fmt
fmt: ## Format OpenTofu files
	@$(TOFU) fmt -recursive .
	@echo "Formatted OpenTofu files."

.PHONY: fmt-check
fmt-check: ## Check OpenTofu formatting
	@$(TOFU) fmt -check -recursive .

.PHONY: init
init: ## Initialize OpenTofu working directory
	@$(TOFU) init

.PHONY: validate
validate: fmt-check ## Validate OpenTofu syntax and configuration
	@$(TOFU) init -backend=false > /dev/null
	@$(TOFU) validate
	@echo "Validation successful."

.PHONY: plan
plan: init ## Generate and show an execution plan
	@$(TOFU) plan

.PHONY: apply
apply: init ## Build or change infrastructure
	@$(TOFU) apply

.PHONY: destroy
destroy: init ## Destroy OpenTofu-managed infrastructure
	@$(TOFU) destroy

.PHONY: clean
clean: ## Remove local OpenTofu cache and state files
	@rm -rf .terraform .terraform.lock.hcl
	@echo "Cleaned OpenTofu cache."
