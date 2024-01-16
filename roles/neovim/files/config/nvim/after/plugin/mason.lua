require('mason').setup({
  ui = {
    border = 'rounded'
  }
})

require('mason-lspconfig').setup({
  ensure_installed = {
    'lua_ls',
    'gopls',
    'pyright',
    'rust_analyzer',
    'terraformls',
    'docker_compose_language_service',
    'dockerls',
  }
})
