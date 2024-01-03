local wal = function()
  local colors = {
    black        = 0,
    red          = 1,
    green        = 2,
    yellow       = 3,
    blue         = 4,
    magenta      = 5,
    cyan         = 6,
    white        = 7,
    gray         = 8,
    darkgray     = '#333333',
    lightgray    = '#555555',
    inactivegray = '#777777',
  }
  return {
    normal = {
      a = {bg = colors.blue, fg = colors.black, gui = 'bold'},
      b = {bg = colors.lightgray, fg = colors.white},
      c = {bg = colors.darkgray, fg = colors.gray}
    },
    insert = {
      a = {bg = colors.green, fg = colors.black, gui = 'bold'},
      b = {bg = colors.lightgray, fg = colors.white},
      c = {bg = colors.darkgray, fg = colors.gray}
    },
    visual = {
      a = {bg = colors.yellow, fg = colors.black, gui = 'bold'},
      b = {bg = colors.lightgray, fg = colors.white},
      c = {bg = colors.darkgray, fg = colors.gray}
    },
    replace = {
      a = {bg = colors.red, fg = colors.black, gui = 'bold'},
      b = {bg = colors.lightgray, fg = colors.white},
      c = {bg = colors.darkgray, fg = colors.gray}
    },
    command = {
      a = {bg = colors.magenta, fg = colors.black, gui = 'bold'},
      b = {bg = colors.lightgray, fg = colors.white},
      c = {bg = colors.darkgray, fg = colors.gray}
    },
    inactive = {
      a = {bg = colors.darkgray, fg = colors.gray, gui = 'bold'},
      b = {bg = colors.lightgray, fg = colors.white},
      c = {bg = colors.darkgray, fg = colors.gray}
    }
  }
end

require('lualine').setup {
  options = {
    icons_enabled = false,
    component_separators = '|',
    section_separators = '',
    theme = wal,
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
}
