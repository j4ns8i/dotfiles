return {
  {
    "nvimtools/none-ls.nvim",
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          null_ls.builtins.formatting.black,
          null_ls.builtins.diagnostics.ansiblelint,
        },
      }
    end,
    ft = {
      'python',
      'yaml',
    },
  },
}
