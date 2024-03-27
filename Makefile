KERNEL := $(shell uname -s | tr '[:upper:]' '[:lower:]')

SYNC_PLAYBOOK            := $(or $(wildcard playbooks/$(KERNEL).yaml),playbooks/sync.yaml)
ANSIBLE_COLLECTIONS_PATH := .collections/

PIPENV           := $(or $(shell which pipenv),$(shell python3 -m site --user-base)/bin/pipenv)
ENVSETTER        := $(if $(PIPENV_ACTIVE),,pipenv run)
ANSIBLE_TAGS     := $(if $(TAGS),--tags $(TAGS),)
ANSIBLE_PLAYBOOK := $(ENVSETTER) ansible-playbook $(ANSIBLE_PLAYBOOK_ARGS)

.PHONY: help
help: ## Show this help text
	@grep -E '^[a-z.A-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "; printf "Usage:\n"}; {printf "  \033[36m%-20s\033[0m    %s\n", $$1, $$2}'

.PHONY: deps
deps: $(PIPENV) $(ANSIBLE_COLLECTIONS_PATH) ## Install dependencies for using this repository

.PHONY: diff-alacritty
diff-alacritty:
	ANSIBLE_BECOME_ASK_PASS=false $(ANSIBLE_PLAYBOOK) \
		-e "dotfiles_home_dir=$(HOME)" \
		--check \
		--diff \
		playbooks/utilities/diff-alacritty.yaml

.PHONY: sync
sync: $(PIPENV) ## Run the main sync playbook to install and configure applications
	$(ANSIBLE_PLAYBOOK) \
		-e "dotfiles_path=$(PWD)" \
		-e "dotfiles_home_dir=$(HOME)" \
		$(ANSIBLE_TAGS) \
		$(SYNC_PLAYBOOK)

$(PIPENV):
	@echo "Performing user-local installation of pipenv..."
	python3 -m pip install --user pipenv

$(ANSIBLE_COLLECTIONS_PATH):
	@echo "Installing Ansible collections..."
	$(ENVSETTER) ansible-galaxy collection install -r requirements.yml

.PHONY: update
update-deps: $(PIPENV) ## Update dependencies for Ansible playbooks
	$(PIPENV) update
	$(PIPENV) requirements > requirements.txt
