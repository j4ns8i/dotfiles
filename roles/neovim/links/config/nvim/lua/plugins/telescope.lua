return {
  'nvim-telescope/telescope.nvim',
  version = '0.1.5',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim',     build = 'make', },
    { 'nvim-telescope/telescope-live-grep-args.nvim', version = '^1.0.0', },
    { 'nvim-tree/nvim-web-devicons' },
    { 'folke/trouble.nvim' },
  },
  keys = {
    { '<leader>pf', function() require('telescope.builtin').find_files() end },
    { '<leader>ph', function() require('telescope.builtin').highlights() end },
    { '<leader>pg', function() require('telescope.builtin').git_files() end },
    { '<leader>ps', function() require('telescope').extensions.live_grep_args.live_grep_args() end },
  },
  config = function()
    local trouble = require('trouble.providers.telescope')
    local lga = require('telescope-live-grep-args.actions')
    local opts = {
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ['<c-k>'] = lga.quote_prompt(),
              ['<c-i>'] = lga.quote_prompt({ postfix = ' --iglob ' }),
              ['<c-f>'] = lga.quote_prompt({ postfix = ' -t ' }),
            },
          },
        },
      },
      defaults = {
        mappings = {
          i = {
            ["<c-q>"] = trouble.open_with_trouble,
          },
          n = {
            ["<c-q>"] = trouble.open_with_trouble,
          },
        },
        layout_strategy = 'vertical',
        layout_config = { height = 0.95, preview_height = 0.60 },
      },
    }

    local plugin = require('telescope')
    plugin.setup(opts)
    plugin.load_extension('fzf')
    plugin.load_extension('live_grep_args')

    local c = require('justin.colors')
    c.hi('TelescopeBorder', { ctermfg = c.darkgray })
  end
}
