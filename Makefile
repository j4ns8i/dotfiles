.PHONY: help
help: ## Show this help text
	@grep -E '^[a-z.A-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "; printf "Usage:\n"}; {printf "  \033[36m%-20s\033[0m    %s\n", $$1, $$2}'

.PHONY: update-colors
update-colors:
ifeq ($(COLORSCHEME),)
	@echo "ERROR: COLORSCHEME must be set to a valid value."
	@exit 1
endif
	@echo "Updating colorscheme to $(COLORSCHEME)..."
	gomplate -c .=colors/$(COLORSCHEME).yaml -f roles/alacritty/links/colors.toml.tmpl -o roles/alacritty/links/colors.toml
	gomplate -c .=colors/$(COLORSCHEME).yaml -f roles/neovim/links/config/nvim/lua/justin/colorscheme/colors.lua.tmpl -o roles/neovim/links/config/nvim/lua/justin/colorscheme/colors.lua
