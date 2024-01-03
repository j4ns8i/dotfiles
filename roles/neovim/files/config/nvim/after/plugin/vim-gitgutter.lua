vim.g.gitgutter_map_keys = 0

vim.keymap.set('n', '<leader>ggs', vim.cmd.GitGutterStageHunk)
vim.keymap.set('n', '<leader>ggu', vim.cmd.GitGutterUndoHunk)
vim.keymap.set('n', '<leader>ggp', vim.cmd.GitGutterPreviewHunk)
vim.keymap.set('n', '<leader>j', vim.cmd.GitGutterNextHunk)
vim.keymap.set('n', '<leader>k', vim.cmd.GitGutterPrevHunk)
