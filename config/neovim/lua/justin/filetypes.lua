local function add_filetype(pattern, filetype)
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = pattern,
    callback = function() vim.o.filetype = filetype end
  })
end

local filetypes = {
  {
    pattern = "Tiltfile",
    filetype = "starlark",
  },
}

for _, ft in ipairs(filetypes) do
  add_filetype(ft.pattern, ft.filetype)
end
