return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
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
      { '<leader>cpc', vim.cmd.CopilotChat,        mode = { 'n', 'v' }, desc = 'Copilot Chat' },
      { '<leader>cpe', vim.cmd.CopilotChatExplain, mode = { 'v' }, desc = 'Copilot Explain' },
      {
        '<leader>cp%',
        function()
          vim.cmd('normal! ggVG');
          vim.cmd.CopilotChat();
        end,
        mode = { 'n' },
        desc = 'Copilot chat (with entire buffer)',
      },
    },
    cmd = {
      'CopilotChat',
      'CopilotChatExplain',
      'CopilotChatFix',
      'CopilotChatFixDiagnostic',
      'CopilotChatReview',
      'CopilotChatTests',
      'CopilotChatDocs',
      'CopilotChatOptimize',
    }
  },
}
