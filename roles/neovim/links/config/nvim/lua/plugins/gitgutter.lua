local function set_rounded_window()
  -- Overriding vim dictionaries from lua is a whole song and dance
  local opts = vim.g.gitgutter_floating_window_options
  opts.border = 'rounded'
  vim.g.gitgutter_floating_window_options = opts
end

local function set_highlights()
  local c = require('justin').colorscheme
  c.hi('GitGutterAdd',    { link = 'DiffAdd' })
  c.hi('GitGutterChange', { link = 'DiffChange' })
  c.hi('GitGutterDelete', { link = 'DiffDelete' })
end

return {
  'airblade/vim-gitgutter',
  dependencies = { 'justin' },
  keys = {
    { '<leader>ggs', '<cmd>GitGutterStageHunk<cr>',   desc = 'Stage hunk' },
    { '<leader>ggu', '<cmd>GitGutterUndoHunk<cr>',    desc = 'Undo hunk' },
    { '<leader>ggp', '<cmd>GitGutterPreviewHunk<cr>', desc = 'Preview hunk' },
    { '<leader>j',   '<cmd>GitGutterNextHunk<cr>',    desc = 'GitGutter Next hunk' },
    { '<leader>k',   '<cmd>GitGutterPrevHunk<cr>',    desc = 'GitGutter Previous hunk' },
  },
  event = 'VeryLazy',
  config = function()
    -- Use rounded window for previews
    set_rounded_window()

    set_highlights()

    -- Don't set mappings by default
    vim.g.gitgutter_map_keys = 0
  end
}
