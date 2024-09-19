KERNEL := $(shell uname -s | tr '[:upper:]' '[:lower:]')

TMP_POETRY    := .venv/bin/poetry
NEED_VENV     := $(if $(POETRY_ACTIVE),,poetry run)
ANSIBLE_TAGS  := $(if $(TAGS),--tags $(TAGS),)
SYNC_PLAYBOOK := $(or $(wildcard playbooks/$(KERNEL).yaml),playbooks/sync.yaml)

.PHONY: help
help: ## Show this help text
	@grep -E '^[a-z.A-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "; printf "Usage:\n"}; {printf "  \033[36m%-20s\033[0m    %s\n", $$1, $$2}'

.PHONY: deps
deps: $(POETRY) has-poetry has-poetry-project has-ansible-collections ## Install dependencies for using this repository

# Poetry is expected to be installed system-wide via pipx, but for convenience
# while bootstrapping, it will be installed in a virtualenv if needed.
$(TMP_POETRY): .venv
	@echo "INFO: Performing virtualenv installation of poetry..."
	@echo "INFO: After bootstrapping, it's recommended to delete .venv and use the pipx-installed poetry."
	python3 -m pip install poetry

.venv:
	python3 -m venv $@

.PHONY: has-poetry
has-poetry:
	@echo "Checking for Poetry..."
	(which poetry && echo "Poetry already installed") || $(MAKE) $(TMP_POETRY)

.PHONY: has-poetry-project
has-poetry-project:
	@echo "Installing Poetry project..."
	poetry install

.PHONY: has-ansible-collections
has-ansible-collections:
	@echo "Installing Ansible collections..."
	$(NEED_VENV) ansible-galaxy collection install -r requirements.yml

.PHONY: sync
sync: ## Run the main sync playbook to install and configure applications
	$(NEED_VENV) ansible-playbook \
		-e "dotfiles_path=$(CURDIR)" \
		-e "dotfiles_home_dir=$(HOME)" \
		$(ARGS) \
		$(ANSIBLE_TAGS) \
		$(SYNC_PLAYBOOK)

.PHONY: lock
lock:
	poetry lock
	poetry export -f requirements.txt > requirements.txt

.PHONY: update-deps
update-deps: ## Update dependencies for Ansible playbooks
	poetry update
	poetry export -f requirements.txt > requirements.txt

.PHONY: update-colors
update-colors:
ifeq ($(COLORSCHEME),)
	@echo "ERROR: COLORSCHEME must be set to a valid value."
	@exit 1
endif
	@echo "Updating colorscheme to $(COLORSCHEME)..."
	gomplate -c .=colors/$(COLORSCHEME).yaml -f roles/alacritty/links/colors.toml.tmpl -o roles/alacritty/links/colors.toml
	gomplate -c .=colors/$(COLORSCHEME).yaml -f roles/neovim/links/config/nvim/lua/justin/colorscheme/colors.lua.tmpl -o roles/neovim/links/config/nvim/lua/justin/colorscheme/colors.lua
