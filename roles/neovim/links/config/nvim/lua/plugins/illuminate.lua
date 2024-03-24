local filetypes = {
  'lua',
  'javascript',
  'jsx',
  'typescript',
  'typescriptreact',
  'css',
  'go',
  'rust',
  'python',
  'make',
  'jsonnet'
}

return {
  'RRethy/vim-illuminate',
  ft = filetypes,
  config = function()
    local c = require('justin.colors')
    c.hi('IlluminatedWordText', { ctermbg = c.darkgray })
    c.hi('IlluminatedWordRead', { link = 'IlluminatedWordText' })
    c.hi('IlluminatedWordWrite', { link = 'IlluminatedWordText' })
    local opts = {
      delay = 750,
      filetypes_allowlist = filetypes,
      filetypes_denylist = {},
      min_count_to_highlight = 2,
    }
    require('illuminate').configure(opts)
  end
}
