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
      { '<leader>cpc', vim.cmd.CopilotChat,        mode = { 'n', 'v' } },
      { '<leader>cpe', vim.cmd.CopilotChatExplain, mode = { 'v' } },
      {
        '<leader>cp%',
        function()
          vim.cmd('normal! ggVG');
          vim.cmd.CopilotChat();
        end,
        mode = { 'n' }
      },
    },
    cmd = {
      'CopilotChat',
      'CopilotChatExplain',
    }
  },
}
