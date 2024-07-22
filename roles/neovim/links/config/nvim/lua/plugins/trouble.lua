return {
  'folke/trouble.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  keys = {
    { '<leader>xx', function() require('trouble').close() end },
    { '<leader>xw', function() require('trouble').open('workspace_diagnostics') end },
    { '<leader>xc', function() require('trouble').open('lsp_incoming_calls') end },
    { '<leader>xd', function() require('trouble').open('document_diagnostics') end },
    { '<leader>xq', function() require('trouble').open('quickfix') end },
    { '<leader>xl', function() require('trouble').open('loclist') end },
    { 'gR',         function() require('trouble').open('lsp_references') end },
    { '<leader>xi', function() require('trouble').open('lsp_implementations') end },
    { '<leader>xs', function() require('trouble').open('lsp_document_symbols') end },
  },
}
