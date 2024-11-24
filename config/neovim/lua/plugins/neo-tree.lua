local function set_highlights()
  local colors = require('base16-colorscheme').colors
  vim.api.nvim_set_hl(0, 'NeoTreeDirectoryName', { fg = colors.base0C, bold = true })
  vim.api.nvim_set_hl(0, 'NeoTreeFloatTitle',    { link = 'FloatTitle' })
  vim.api.nvim_set_hl(0, 'NeoTreeModified',      { link = 'DiffChange' })
  vim.api.nvim_set_hl(0, 'NeoTreeGitModified',   { link = 'DiffChange' })
  vim.api.nvim_set_hl(0, 'NeoTreeGitConflict',   { fg = colors.base14, bold = true, italic = true })
  vim.api.nvim_set_hl(0, 'NeoTreeGitUnstaged',   { link = 'DiffChange' })
  vim.api.nvim_set_hl(0, 'NeoTreeGitUntracked',  { link = 'DiffChange' })
end

return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      'folke/which-key.nvim',
    },
    keys = {
      { '<leader>n<leader>', '<cmd>Neotree reveal_file=%s<cr>', desc = "Reveal file" },
      { '<leader>nt',        '<cmd>Neotree toggle<cr>',         desc = "Toggle" },
    },
    cmd = 'Neotree',
    init = function()
      vim.api.nvim_create_autocmd('BufEnter', {
        group = vim.api.nvim_create_augroup('NeoTreeInit', { clear = true }),
        callback = function()
          local f = vim.fn.expand('%:p')
          if vim.fn.isdirectory(f) ~= 0 then
            vim.cmd('Neotree left dir=' .. f)
            vim.o.number = false
            vim.o.relativenumber = false
            vim.api.nvim_clear_autocmds { group = 'NeoTreeInit' }
          end
        end
      })

      local wk = require('which-key')
      wk.add({
        { "<leader>n", desc = "Neotree" },
      })
    end,
    opts = function()
      set_highlights()
      return {
        filesystem = {
          hijack_netrw_behavior = 'open_default',
          window = {
            mappings = {
              ["gs"] = {
                function()
                  vim.cmd('Neotree float git_status')
                end,
                desc = "git status"
              },
              ["ga"] = {
                "git_add_file",
                desc = "git add file"
              },
              [","] = {
                'toggle_node',
                desc = 'toggle node',
              },
              ["<C-x>"] = {
                'open_split',
                desc = 'open split',
              },
              ["<C-v>"] = {
                'open_vsplit',
                desc = 'open vsplit',
              },
            },
          },
        },
        popup_border_style = "rounded",
        window = {
          position = "left",
          width = 40,
        },
      }
    end
  },
}
