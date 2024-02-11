return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    lazy = false,
    keys = {
      { '<leader>ntf', '<cmd>Neotree<cr>' },
      { '<leader>ntt', '<cmd>Neotree toggle<cr>' },
    },
    opts = {
      filesystem = {
        hijack_netrw_behavior = 'open_current',
      },
    }
  },
}
