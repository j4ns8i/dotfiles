local function set_highlights(c)
  c.hi('LuaLineDiffAdd',         { ctermfg = c.darkgreen,  ctermbg = c.lightgray, fg = c.guidarkgreen,  bg = c.guilightgray })
  c.hi('LuaLineDiffChange',      { ctermfg = c.darkblue,   ctermbg = c.lightgray, fg = c.guidarkblue,   bg = c.guilightgray })
  c.hi('LuaLineDiffDelete',      { ctermfg = c.darkred,    ctermbg = c.lightgray, fg = c.guidarkred,    bg = c.guilightgray })
  c.hi('LuaLineDiagnosticError', { ctermfg = c.darkred,    ctermbg = c.lightgray, fg = c.guidarkred,    bg = c.guilightgray })
  c.hi('LuaLineDiagnosticWarn',  { ctermfg = c.darkyellow, ctermbg = c.lightgray, fg = c.guidarkyellow, bg = c.guilightgray })
  c.hi('LuaLineDiagnosticInfo',  { ctermfg = c.white,      ctermbg = c.lightgray, fg = c.guiwhite,      bg = c.guilightgray })
  c.hi('LuaLineDiagnosticHint',  { ctermfg = c.darkblue,   ctermbg = c.lightgray, fg = c.guidarkblue,   bg = c.guilightgray })
end

-- component_colors uses c.<color> if 'termguicolors' is not set, otherwise it
-- uses c.gui<color>.
local function toggled_component_colors(c)
  if vim.opt.termguicolors:get() then
    return {
      black            = c.guiblack,
      darkdarkgray     = c.guidarkdarkgray,
      darkdarkdarkgray = c.guidarkdarkdarkgray,
      darkgray         = c.guidarkgray,
      lightgray        = c.guilightgray,
      white            = c.guiwhite,
      darkred          = c.guidarkred,
      darkgreen        = c.guidarkgreen,
      darkyellow       = c.guidarkyellow,
      darkblue         = c.guidarkblue,
      darkmagenta      = c.guidarkmagenta,
      darkcyan         = c.guidarkcyan,
      darkwhite        = c.guidarkwhite,
    }
  else
    return {
      black            = c.black,
      darkdarkgray     = c.darkgray,
      darkdarkdarkgray = c.darkgray,
      darkgray         = c.darkgray,
      lightgray        = c.lightgray,
      white            = c.white,
      darkred          = c.darkred,
      darkgreen        = c.darkgreen,
      darkyellow       = c.darkyellow,
      darkblue         = c.darkblue,
      darkmagenta      = c.darkmagenta,
      darkcyan         = c.darkcyan,
      darkwhite        = c.darkwhite,
    }
  end
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    local c = require('justin.colors')
    set_highlights(c)
    local tc = toggled_component_colors(c) -- toggled colors dependent on 'termguicolors'
    local wal = function()
      return {
        normal = {
          a = { bg = tc.darkblue, fg = tc.black, gui = 'bold' },
          b = { bg = tc.lightgray, fg = tc.white },
          c = { bg = tc.darkdarkdarkgray, fg = tc.lightgray }
        },
        insert = {
          a = { bg = tc.darkgreen, fg = tc.black, gui = 'bold' },
          b = { bg = tc.lightgray, fg = tc.white },
          c = { bg = tc.darkdarkdarkgray, fg = tc.lightgray }
        },
        visual = {
          a = { bg = tc.darkyellow, fg = tc.black, gui = 'bold' },
          b = { bg = tc.lightgray, fg = tc.white },
          c = { bg = tc.darkdarkdarkgray, fg = tc.lightgray }
        },
        replace = {
          a = { bg = tc.darkred, fg = tc.black, gui = 'bold' },
          b = { bg = tc.lightgray, fg = tc.white },
          c = { bg = tc.darkdarkdarkgray, fg = tc.lightgray }
        },
        command = {
          a = { bg = tc.darkmagenta, fg = tc.black, gui = 'bold' },
          b = { bg = tc.lightgray, fg = tc.white },
          c = { bg = tc.darkdarkdarkgray, fg = tc.lightgray }
        },
        inactive = {
          a = { bg = tc.darkdarkdarkgray, fg = '#777777', gui = 'bold' },
          b = { bg = tc.lightgray, fg = tc.white },
          c = { bg = tc.darkdarkdarkgray, fg = tc.lightgray }
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
