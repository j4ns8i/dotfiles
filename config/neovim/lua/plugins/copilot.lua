return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
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
