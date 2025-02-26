return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    keys = {
      { '<leader>cld', '<cmd>Copilot disable<cr>', { desc = "Copilot disable" } },
      { '<leader>cle', '<cmd>Copilot enable<cr>',  { desc = "Copilot enable" } },
      { '<leader>cls', '<cmd>Copilot status<cr>',  { desc = "Copilot status" } },
    },
    opts = {
      panel = {
        enabled = false
      },
      suggestion = {
        auto_trigger = true,
        keymap = {
          next = '<a-n>',
          prev = '<a-p>',
        },
      },
      filetypes = {
        yaml = true,
      },
    },
  }
}
