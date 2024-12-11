local function set_highlights()
  -- cannot link to groups because they will not properly sit on top of bg color
  local colors = require('base16-colorscheme').colors
  vim.api.nvim_set_hl(0, 'LuaLineDiffAdd',         { fg = colors.base0B, bg = colors.base02 })
  vim.api.nvim_set_hl(0, 'LuaLineDiffChange',      { fg = colors.base0D, bg = colors.base02 })
  vim.api.nvim_set_hl(0, 'LuaLineDiffDelete',      { fg = colors.base08, bg = colors.base02 })
  vim.api.nvim_set_hl(0, 'LuaLineDiagnosticError', { fg = colors.base08, bg = colors.base02 })
  vim.api.nvim_set_hl(0, 'LuaLineDiagnosticWarn',  { fg = colors.base0A, bg = colors.base02 })
  vim.api.nvim_set_hl(0, 'LuaLineDiagnosticInfo',  { fg = colors.base06, bg = colors.base02 })
  vim.api.nvim_set_hl(0, 'LuaLineDiagnosticHint',  { fg = colors.base04, bg = colors.base02 })
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'rrethy/base16-nvim',
  },
  opts = function()
    set_highlights()
    return {
      options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_b = {
          { 'branch' },
          {
            'diff',
            diff_color = {
              added    = 'LuaLineDiffAdd',
              modified = 'LuaLineDiffChange',
              removed  = 'LuaLineDiffDelete',
            },
          },
          {
            'diagnostics',
            diagnostics_color = {
              error = 'LuaLineDiagnosticError',
              warn  = 'LuaLineDiagnosticWarn',
              info  = 'LuaLineDiagnosticInfo',
              hint  = 'LuaLineDiagnosticHint',
            },
          },
        },
      },
      -- Note: relative paths in filename component seems to be broken...
      -- sections = {
      --   lualine_a = {'mode'},
      --   lualine_b = {'branch', 'diff', 'diagnostics'},
      --   lualine_c = {{'filename', path = 1}},
      --   lualine_x = {'encoding', 'fileformat', 'filetype'},
      --   lualine_y = {'progress'},
      --   lualine_z = {'location'}
      -- },
      -- inactive_sections = {
      --   lualine_a = {},
      --   lualine_b = {},
      --   lualine_c = {{'filename', path = 2}},
      --   lualine_x = {'location'},
      --   lualine_y = {},
      --   lualine_z = {}
      -- },
      -- section_sep
    }
  end
}
