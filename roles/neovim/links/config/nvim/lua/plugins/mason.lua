return {
  {
    'williamboman/mason.nvim',
    opts = {
      ui = {
        border = 'rounded',
      },
    },
    lazy = false,
    keys = {
      { '<leader>wm', '<cmd>Mason<cr>' },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      ensure_installed = {
        'lua_ls',
        'gopls',
        'pyright',
        'rust_analyzer',
        'terraformls',
        'docker_compose_language_service',
        'dockerls',
        'tailwindcss',
        'emmet_language_server',
        'cssls',
        'tsserver',
      },
    },
  },
}
