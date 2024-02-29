local function set_highlights()
  local c = require('justin.colors')
  c.hi('@diff.plus.diff',          { link = 'DiffAdd' })
  c.hi('@diff.minus.diff',         { link = 'DiffDelete' })
  c.hi('@lsp.type.lifetime',       { link = 'Statement' })
  c.hi('@lsp.type.keyword',        { link = 'Keyword' })
  c.hi('@lsp.type.namespace',      { ctermfg = c.darkblue })
  c.hi('@lsp.mod.readonly',        { ctermfg = c.darkred })
  c.hi('@function.make',           { link = 'Normal' })
  c.hi('@function.call.bash',      { link = 'Normal' })
  c.hi('@text.reference',          { ctermfg = c.darkcyan })
  c.hi('@text.literal',            { ctermfg = c.green })
  c.hi('@markup.list',             { link = 'Delimiter' })
  c.hi('@markup.link.vimdoc',      { ctermfg = c.darkcyan })
  c.hi('@markup.heading',          { link = 'Title' })
  c.hi('@markup.heading.1.vimdoc', { ctermfg = c.darkblue })
  c.hi('@markup.heading.2.vimdoc', { link = '@markup.heading.1.vimdoc' })
  c.hi('@markup.heading.3.vimdoc', { link = '@markup.heading.1.vimdoc' })
  c.hi('@markup.heading.4.vimdoc', { link = '@markup.heading.1.vimdoc' })
  c.hi('@tag.html',                { ctermfg = c.darkred, bold = true })
  c.hi('@tag.tsx',                 { link = '@tag.html' })
  c.hi('@tag.builtin.tsx',         { link = '@tag.html' })
  c.hi('@tag.attribute.html',      { ctermfg = c.darkblue })
  c.hi('@tag.attribute.html',      { ctermfg = c.darkblue })
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    opts = {
      ensure_installed = {
        "typescript",
        "tsx",
        "javascript",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "rust",
        "toml",
        "python",
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "make",
        "dockerfile",
        "terraform",
        "yaml",
        "markdown",
        "jsonnet",
        "json",
        "html",
        "gitcommit",
        "git_rebase",
        "bash",
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      -- List of parsers to ignore installing (or "all")
      -- ignore_install = { "javascript" }

      ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
      -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

      highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        -- disable = function(lang, buf)
        --     local max_filesize = 100 * 1024 -- 100 KB
        --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --     if ok and stats and stats.size > max_filesize then
        --         return true
        --     end
        -- end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
    },
    dependencies = { 'justin' },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
      set_highlights()
    end
  },
  {
    'nvim-treesitter/playground',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    keys = {
      { '<leader>tsp', "TSPlaygroundToggle<cr>" },
    },
  }
}
