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

vim.api.nvim_set_hl(0, 'MasonHeader', { ctermbg = 'DarkMagenta', ctermfg = 'White', bold = true })
vim.api.nvim_set_hl(0, 'MasonHeaderSecondary', { ctermbg = 'DarkRed', ctermfg = 'White' })

vim.api.nvim_set_hl(0, 'MasonHighlight', { ctermfg = 'DarkCyan' })
vim.api.nvim_set_hl(0, 'MasonHighlightBlock', { ctermbg = 'DarkCyan', ctermfg = 'Black' })
vim.api.nvim_set_hl(0, 'MasonHighlightBlockBold', { ctermbg = 'DarkCyan', ctermfg = 'Black', bold = true })

vim.api.nvim_set_hl(0, 'MasonHighlightSecondary', { ctermfg = 'DarkYellow' })
vim.api.nvim_set_hl(0, 'MasonHighlightSecondaryBlock', { ctermbg = 'DarkYellow', ctermfg = 'Black' })
vim.api.nvim_set_hl(0, 'MasonHighlightSecondaryBlockBold', { ctermbg = 'DarkYellow', ctermfg = 'Black', bold = true })
