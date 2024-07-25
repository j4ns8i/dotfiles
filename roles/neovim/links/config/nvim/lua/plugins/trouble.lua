return {
  'folke/trouble.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  keys = {
    {
      '<leader>xx',
      function() require('trouble').close() end,
      desc = "Close Trouble",
    },
    {
      '<leader>xc',
      function() require('trouble').open('lsp_incoming_calls') end,
      desc = "LSP Incoming Calls",
    },
    {
      '<leader>xd',
      function() require('trouble').open('diagnostics') end,
      desc = "Diagnostics",
    },
    {
      '<leader>xq',
      function() require('trouble').open('quickfix') end,
      desc = "Quickfix",
    },
    {
      '<leader>xl',
      function() require('trouble').open('loclist') end,
      desc = "Location List",
    },
    {
      'gR',
      function() require('trouble').open('lsp_references') end,
      desc = "LSP References",
    },
    {
      '<leader>xi',
      function() require('trouble').open('lsp_implementations') end,
      desc = "LSP Implementations",
    },
    {
      '<leader>xs',
      function() require('trouble').open('lsp_document_symbols') end,
      desc = "LSP Document Symbols",
    },
  },
  opts = {
    focus = true,
  },
}
