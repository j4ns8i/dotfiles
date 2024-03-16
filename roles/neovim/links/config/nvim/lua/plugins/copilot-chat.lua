return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      'zbirenbaum/copilot.lua',
      'nvim-lua/plenary.nvim',
    },
    opts = {
      window = {
        layout = 'float',
        border = 'rounded',
      },
    },
    keys = {
      { '<leader>cpc', vim.cmd.CopilotChat },
      { '<leader>cpe', vim.cmd.CopilotChatExplain },
    },
    cmd = {
      'CopilotChat',
      'CopilotChatExplain',
    }
  },
}
