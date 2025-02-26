local function is_quickfix_open()
  return vim.fn.getqflist({winid = 0}).winid ~= 0
end

local function next_list_entry()
  -- If the quickfix list is open, jump to next entry
  if is_quickfix_open() then
    vim.cmd('cn<cr>zz')
    return
  end
  -- otherwise, use trouble
  require('trouble').next({ jump = true, focus = false })
end

local function previous_list_entry()
  -- If the quickfix list is open, jump to previous entry
  if is_quickfix_open() then
    vim.cmd('cp<cr>zz')
    return
  end
  -- otherwise, use trouble
  require('trouble').prev({ jump = true, focus = false })
end

vim.keymap.set('n', '<up>', previous_list_entry, { desc = "Next quickfix / trouble entry" })
vim.keymap.set('n', '<down>', next_list_entry, { desc = "Previous quickfix / trouble entry" })

vim.keymap.set('n', '<leader>q<bs>', vim.cmd.cclose, { desc = "Close quickfix window" })
vim.keymap.set('n', '<leader>qd', vim.diagnostic.setqflist, { desc = "Open diagnostics in quickfix list" })
