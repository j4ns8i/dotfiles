return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    version = '*',
    dependencies = {
      'zbirenbaum/copilot.lua',
      'nvim-lua/plenary.nvim',
    },
    opts = {
      model = 'claude-sonnet-4.5',
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
      'CopilotChatModels',
      'CopilotChatAgents',
      'CopilotChatPrompts',
      'CopilotChatSave',
      'CopilotChatLoad',
      'CopilotChatReset',
      'CopilotChatStop',
      'CopilotChatToggle',
      'CopilotChatOptimize',
    }
  },
}
