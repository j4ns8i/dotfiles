local function set_highlights()
  local c = require('justin.colors')
  c.hi('MasonHeader',                      { ctermfg = c.white, ctermbg = c.darkmagenta, bold = true })
  c.hi('MasonHeaderSecondary',             { ctermfg = c.white, ctermbg = c.darkred })
  c.hi('MasonHighlight',                   { ctermfg = c.darkcyan })
  c.hi('MasonHighlightBlock',              { ctermfg = c.black, ctermbg = c.darkcyan })
  c.hi('MasonHighlightBlockBold',          { ctermfg = c.black, ctermbg = c.darkcyan, bold = true })
  c.hi('MasonHighlightSecondary',          { ctermfg = c.darkyellow })
  c.hi('MasonHighlightSecondaryBlock',     { ctermfg = c.black, ctermbg = c.darkyellow })
  c.hi('MasonHighlightSecondaryBlockBold', { ctermfg = c.black, ctermbg = c.darkyellow, bold = true })
end

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
    dependencies = { 'justin' },
    config = function(_, opts)
      require('mason').setup(opts)
      set_highlights()
    end
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
        'tflint',
        'docker_compose_language_service',
        'dockerls',
        'tailwindcss',
        'emmet_language_server',
        'cssls',
        'tsserver',
        'jsonls',
        'html',
      },
    },
  },
}
