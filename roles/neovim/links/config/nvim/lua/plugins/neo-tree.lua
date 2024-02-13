return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    lazy = false, -- because it needs to be loaded in order to check if we're opening a directory
    keys = {
      { '<leader>ntf', '<cmd>Neotree<cr>' },
      { '<leader>ntt', '<cmd>Neotree toggle<cr>' },
    },
    opts = {
      filesystem = {
        hijack_netrw_behavior = 'open_default',
        window = {
          mappings = {
            ["gs"] = function()
              vim.cmd [[ Neotree float git_status ]]
            end,
          },
        },
      },
      popup_border_style = "rounded",
      window = {
        position = "left",
        width = 40,
      },
    }
  },
}
