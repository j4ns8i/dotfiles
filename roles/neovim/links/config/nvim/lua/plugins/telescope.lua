return {
  'nvim-telescope/telescope.nvim',
  version = '0.1.5',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'folke/trouble.nvim' },
  },
  keys = {
    { '<leader>pf', function() require('telescope.builtin').find_files() end },
    { '<leader>ph', function() require('telescope.builtin').highlights() end },
    { '<C-p>',      function() require('telescope.builtin').git_files()  end },
    { '<leader>ps', function() require('telescope.builtin').live_grep()  end },
  },
  opts = function()
    local trouble = require('trouble.providers.telescope')
    return {
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
      },
      defaults = {
        mappings = {
          i = { ["<c-q>"] = trouble.open_with_trouble },
          n = { ["<c-q>"] = trouble.open_with_trouble },
        }
      },
    }
  end,
  config = function(_, opts)
    local plugin = require('telescope')
    plugin.setup(opts)
    plugin.load_extension('fzf')
  end
}
