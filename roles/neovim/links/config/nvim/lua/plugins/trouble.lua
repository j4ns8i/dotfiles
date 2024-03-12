return {
  'folke/trouble.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  keys = {
    { '<leader>xx', function() require('trouble').close() end },
    { '<leader>xw', function() require('trouble').open('workspace_diagnostics') end },
    { '<leader>xc', function()
      vim.lsp.buf.incoming_calls()
      -- hack: wait for the previous call to finish because it's async and can't be awaited
      vim.cmd.sleep('50m')
      vim.cmd.cclose()
      require('trouble').open('quickfix')
    end },
    { '<leader>xd', function() require('trouble').open('document_diagnostics') end },
    { '<leader>xq', function() require('trouble').open('quickfix') end },
    { '<leader>xl', function() require('trouble').open('loclist') end },
    { 'gR',         function() require('trouble').open('lsp_references') end },
    { '<leader>xi', function() require('trouble').open('lsp_implementations') end },
  },
}
