local function set_highlights(c)
  c.hi('LuaLineDiffAdd',         { ctermfg = c.darkgreen, ctermbg = c.lightgray })
  c.hi('LuaLineDiffChange',      { ctermfg = c.darkblue, ctermbg = c.lightgray })
  c.hi('LuaLineDiffDelete',      { ctermfg = c.darkred, ctermbg = c.lightgray })
  c.hi('LuaLineDiagnosticError', { ctermfg = c.darkred, ctermbg = c.lightgray })
  c.hi('LuaLineDiagnosticWarn',  { ctermfg = c.darkyellow, ctermbg = c.lightgray })
  c.hi('LuaLineDiagnosticInfo',  { ctermfg = c.white, ctermbg = c.lightgray })
  c.hi('LuaLineDiagnosticHint',  { ctermfg = c.darkblue, ctermbg = c.lightgray })
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    local c = require('justin.colors')
    set_highlights(c)
    local wal = function()
      return {
        normal = {
          a = { bg = c.darkblue, fg = c.black, gui = 'bold' },
          b = { bg = c.lightgray, fg = c.white },
          c = { bg = c.darkgray, fg = c.lightgray }
        },
        insert = {
          a = { bg = c.darkgreen, fg = c.black, gui = 'bold' },
          b = { bg = c.lightgray, fg = c.white },
          c = { bg = c.darkgray, fg = c.lightgray }
        },
        visual = {
          a = { bg = c.darkyellow, fg = c.black, gui = 'bold' },
          b = { bg = c.lightgray, fg = c.white },
          c = { bg = c.darkgray, fg = c.lightgray }
        },
        replace = {
          a = { bg = c.darkred, fg = c.black, gui = 'bold' },
          b = { bg = c.lightgray, fg = c.white },
          c = { bg = c.darkgray, fg = c.lightgray }
        },
        command = {
          a = { bg = c.darkmagenta, fg = c.black, gui = 'bold' },
          b = { bg = c.lightgray, fg = c.white },
          c = { bg = c.darkgray, fg = c.lightgray }
        },
        inactive = {
          a = { bg = c.darkgray, fg = '#777777', gui = 'bold' },
          b = { bg = c.lightgray, fg = c.white },
          c = { bg = c.darkgray, fg = c.lightgray }
        }
      }
    end
    return {
      options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
        theme = wal,
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
