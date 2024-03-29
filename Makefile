KERNEL := $(shell uname -s | tr '[:upper:]' '[:lower:]')

TMP_VENV         := $(if $(shell which poetry),,.venv)
POETRY           := $(or $(shell which poetry),$(TMP_VENV)/bin/poetry)
NEED_VENV        := $(if $(POETRY_ACTIVE),,poetry run)
ANSIBLE_TAGS     := $(if $(TAGS),--tags $(TAGS),)
ANSIBLE_PLAYBOOK := $(NEED_VENV) ansible-playbook $(ANSIBLE_PLAYBOOK_ARGS)
SYNC_PLAYBOOK    := $(or $(wildcard playbooks/$(KERNEL).yaml),playbooks/sync.yaml)

.PHONY: help
help: ## Show this help text
	@grep -E '^[a-z.A-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "; printf "Usage:\n"}; {printf "  \033[36m%-20s\033[0m    %s\n", $$1, $$2}'

.PHONY: deps
deps: $(POETRY) install-ansible-collections ## Install dependencies for using this repository

# Poetry is expected to be installed system-wide via pipx, but for convenience
# while bootstrapping, it will be installed in a virtualenv if needed.
$(POETRY): $(TMP_VENV)
	@echo "Performing virtualenv installation of poetry..."
	@echo "After bootstrapping, it's recommended to delete .venv and use the pipx-installed poetry."
	python3 -m pip install poetry

.venv:
	python3 -m venv $@

.PHONY: install-ansible-collections
install-ansible-collections:
	@echo "Installing Ansible collections..."
	$(NEED_VENV) ansible-galaxy collection install -r requirements.yml

.PHONY: diff-alacritty
diff-alacritty:
	ANSIBLE_BECOME_ASK_PASS=false $(ANSIBLE_PLAYBOOK) \
		-e "dotfiles_home_dir=$(HOME)" \
		--check \
		--diff \
		playbooks/utilities/diff-alacritty.yaml

.PHONY: sync
sync: $(POETRY) ## Run the main sync playbook to install and configure applications
	$(ANSIBLE_PLAYBOOK) \
		-e "dotfiles_path=$(CURDIR)" \
		-e "dotfiles_home_dir=$(HOME)" \
		$(ANSIBLE_TAGS) \
		$(SYNC_PLAYBOOK)

.PHONY: update-deps
update-deps: $(POETRY) ## Update dependencies for Ansible playbooks
	$(POETRY) update
	$(POETRY) export -f requirements.txt > requirements.txt
