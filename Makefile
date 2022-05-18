.PHONY: diff-alacritty
diff-alacritty:
	ANSIBLE_BECOME_ASK_PASS=false pipenv run ansible-playbook \
		-e "dotfiles_home_dir=$(HOME)" \
		--check \
		--diff \
		playbooks/utilities/diff-alacritty.yaml

.PHONY: bootstrap
bootstrap:
	pipenv run ansible-playbook \
		-e "dotfiles_path=$(PWD)" \
		-e "dotfiles_home_dir=$(HOME)" \
		playbooks/bootstrap.yaml
