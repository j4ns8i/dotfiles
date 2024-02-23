PIPENV           := $(or $(shell which pipenv),$(shell python3 -m site --user-base)/bin/pipenv)
ANSIBLE_PLAYBOOK := ansible-playbook $(ANSIBLE_PLAYBOOK_ARGS)

ANSIBLE_TAGS :=
ifneq ($(TAGS),)
ANSIBLE_TAGS := --tags $(TAGS)
endif

.PHONY: help
help: ## Show this help text
	@grep -E '^[a-z.A-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "; printf "Usage:\n"}; {printf "  \033[36m%-20s\033[0m    %s\n", $$1, $$2}'

.PHONY: deps
deps: $(PIPENV) ## Install dependencies for using this repository

.PHONY: diff-alacritty
diff-alacritty:
	ANSIBLE_BECOME_ASK_PASS=false $(ANSIBLE_PLAYBOOK) \
		-e "dotfiles_home_dir=$(HOME)" \
		--check \
		--diff \
		playbooks/utilities/diff-alacritty.yaml

.PHONY: bootstrap
bootstrap: $(PIPENV) ## Run the main bootstrap playbook to install and configure applications
	$(ANSIBLE_PLAYBOOK) \
		-e "dotfiles_path=$(PWD)" \
		-e "dotfiles_home_dir=$(HOME)" \
		$(ANSIBLE_TAGS) \
		playbooks/bootstrap.yaml

$(PIPENV):
	@echo "Performing user-local installation of pipenv..."
	python3 -m pip install --user pipenv

.PHONY: update
update-deps: $(PIPENV) ## Update dependencies for Ansible playbooks
	$(PIPENV) update
	$(PIPENV) requirements > requirements.txt
