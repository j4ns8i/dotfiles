vim.g.mapleader = " "

vim.keymap.set('n', '<leader>pv', vim.cmd.Texplore)

vim.keymap.set('o', 'i<space>', ':<c-u>normal! T_vt_<cr>')
vim.keymap.set('o', 'a<space>', ':<c-u>normal! F_vf_<cr>')

-- Indent conveniences
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('n', '<Tab>', '>>')
vim.keymap.set('n', '<S-Tab>', '<<')
vim.keymap.set('i', '<S-Tab>', '<c-d>')
vim.keymap.set('v', '<Tab>', '>', { remap = true })
vim.keymap.set('v', '<S-Tab>', '<', { remap = true })

-- Restore jump forward after mapping <Tab> (which == <C-i>)
vim.keymap.set('n', '<C-h>', '<C-i>')

vim.keymap.set('n', '<leader>[', ':bp<cr>')
vim.keymap.set('n', '<leader>]', ':bn<cr>')
vim.keymap.set('n', '<leader><bs>', '<c-^>')

vim.keymap.set('n', 'Q', '@q')

vim.keymap.set('n', '<leader>mks', ':mksession!<cr>')

vim.keymap.set('n', '<leader>sar', ':%s/<c-r><c-w>//gc<left><left><left>')
vim.keymap.set('v', '<leader>sar', '"sy:%s/\\<<c-r>s\\>//gc<left><left><left>')

vim.keymap.set('v', '<leader>64d', 'c<c-r>=system(\'base64 --decode\', @")<cr><esc>')
vim.keymap.set('v', '<leader>64e', 'c<c-r>=system(\'base64\', @")<cr><esc>')

vim.keymap.set('n', 'gg', 'mjgg')
vim.keymap.set('n', 'G', 'mkG')

vim.keymap.set('n', '<up>', ':cp<cr>')
vim.keymap.set('n', '<down>', ':cn<cr>')

vim.keymap.set('n', '<leader>in', ':Inspect<cr>')

--vim.keymap.set("o", "in("
