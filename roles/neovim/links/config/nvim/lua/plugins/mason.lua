local function set_highlights()
  local c = require('justin').colorscheme
  c.hi('MasonHeader',                      { ctermfg = c.white, ctermbg = c.darkmagenta, bold = true, fg = c.guiwhite, bg = c.guidarkmagenta })
  c.hi('MasonHeaderSecondary',             { ctermfg = c.white, ctermbg = c.darkred, fg = c.guiwhite, bg = c.guidarkred })
  c.hi('MasonHighlight',                   { ctermfg = c.darkcyan, fg = c.guidarkcyan })
  c.hi('MasonHighlightBlock',              { ctermfg = c.black, ctermbg = c.darkcyan, fg = c.guiblack, bg = c.guidarkcyan })
  c.hi('MasonHighlightBlockBold',          { ctermfg = c.black, ctermbg = c.darkcyan, bold = true, fg = c.guiblack, bg = c.guidarkcyan })
  c.hi('MasonHighlightSecondary',          { ctermfg = c.darkyellow, fg = c.guidarkyellow })
  c.hi('MasonHighlightSecondaryBlock',     { ctermfg = c.black, ctermbg = c.darkyellow, fg = c.guiblack, bg = c.guidarkyellow})
  c.hi('MasonHighlightSecondaryBlockBold', { ctermfg = c.black, ctermbg = c.darkyellow, bold = true, fg = c.guiblack, bg = c.guidarkyellow })
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
      { '<leader>wm', '<cmd>Mason<cr>', desc = 'Open Mason window'},
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
        'bashls',
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
