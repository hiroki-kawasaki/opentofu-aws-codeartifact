TOFU := tofu
TOFU_DIR := tofu

.DEFAULT_GOAL := help

.PHONY: help
help: ## Display this help message
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: fmt
fmt: ## Format OpenTofu files
	@$(TOFU) fmt -recursive $(TOFU_DIR)
	@echo "Formatted OpenTofu files."

.PHONY: fmt-check
fmt-check: ## Check OpenTofu formatting
	@$(TOFU) fmt -check -recursive $(TOFU_DIR)

.PHONY: init
init: ## Initialize OpenTofu working directory
	@$(TOFU) -chdir=$(TOFU_DIR) init

.PHONY: validate
validate: fmt-check ## Validate OpenTofu syntax and configuration
	@$(TOFU) -chdir=$(TOFU_DIR) init -backend=false > /dev/null
	@$(TOFU) -chdir=$(TOFU_DIR) validate
	@echo "Validation successful."

.PHONY: plan
plan: init ## Generate and show an execution plan
	@$(TOFU) -chdir=$(TOFU_DIR) plan

.PHONY: apply
apply: init ## Build or change infrastructure
	@$(TOFU) -chdir=$(TOFU_DIR) apply

.PHONY: destroy
destroy: init ## Destroy OpenTofu-managed infrastructure
	@$(TOFU) -chdir=$(TOFU_DIR) destroy

.PHONY: clean
clean: ## Remove local OpenTofu cache and state files
	@rm -rf $(TOFU_DIR)/.terraform
	@echo "Cleaned OpenTofu cache."
