local function set_rounded_window()
  -- Overriding vim dictionaries from lua is a whole song and dance
  local opts = vim.g.gitgutter_floating_window_options
  opts.border = 'rounded'
  vim.g.gitgutter_floating_window_options = opts
end

local function set_highlights()
  local c = require('justin.colors')
  c.hi('GitGutterAdd', { ctermfg = c.darkgreen })
  c.hi('GitGutterChange', { ctermfg = c.darkyellow })
  c.hi('GitGutterDelete', { ctermfg = c.darkred })
end

return {
  'airblade/vim-gitgutter',
  dependencies = { 'justin' },
  config = function()
    -- Use rounded window for previews
    set_rounded_window()

    set_highlights()

    -- Don't set mappings by default
    vim.g.gitgutter_map_keys = 0

    vim.keymap.set('n', '<leader>ggs', vim.cmd.GitGutterStageHunk)
    vim.keymap.set('n', '<leader>ggu', vim.cmd.GitGutterUndoHunk)
    vim.keymap.set('n', '<leader>ggp', vim.cmd.GitGutterPreviewHunk)
    vim.keymap.set('n', '<leader>j',   vim.cmd.GitGutterNextHunk)
    vim.keymap.set('n', '<leader>k',   vim.cmd.GitGutterPrevHunk)
  end
}
