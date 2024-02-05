vim.cmd [[setlocal scl=auto]]

vim.fn.NERDTreeAddKeyMap {
  key = 'e',
  callback = 'NERDTreeMapChangeRoot',
  quickhelpText = 'change tree root to the selected dir',
  override = 1,
  scope = 'Node'
}

vim.b.undo_ftplugin = 'setlocal scl<'
