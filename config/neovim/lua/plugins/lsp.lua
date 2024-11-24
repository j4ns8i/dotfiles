-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>re', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>d', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>K', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- setup an lsp with default and optional custom configuration. opts is
-- a table of elements including an lsp name and the optional config.
local function setup_lsp(module, capabilities, lsp_opts)
  local lsp_name = lsp_opts[1]
  local extra_opts = lsp_opts[2]

  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  if extra_opts ~= nil then
    for k, v in pairs(extra_opts) do
      opts[k] = v
    end
  end

  module[lsp_name].setup(opts)
end

-- config is the lazy config function
local function config()
  vim.api.nvim_set_hl(0, 'LspInfoBorder', { link = 'FloatBorder' })
  vim.lsp.handlers['textDocument/hover'] =
      vim.lsp.with(
        vim.lsp.handlers.hover,
        {
          border = 'rounded',
        }
      )

  vim.lsp.handlers['textDocument/signatureHelp'] =
      vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {
          border = 'rounded',
        }
      )

  require('lspconfig.ui.windows').default_options.border = 'rounded'

  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<M-k>', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', '<M-j>', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

  -- Set "<" prefix before diagnostic virtual text
  vim.diagnostic.config({
    virtual_text = { prefix = '<' },
    float = { border = 'rounded' },
    signs = false, -- disable signs in sign column
  })

  local lsps = {
    {
      'gopls',
      {
        settings = {
          gopls = {
            buildFlags = { '-tags', 'functional,integration' },
            semanticTokens = true,
            usePlaceholders = true,
          },
        }
      },
    },
    { 'dockerls' },
    {
      'starlark_rust',
      { filetypes = { 'starlark' } }
    },
    { 'docker_compose_language_service' },
    { 'rust_analyzer' },
    { 'zls' },
    { 'pyright' },
    { 'volar' },
    { 'terraformls' },
    { 'tflint' },
    { 'bashls' },
    { 'jsonnet_ls' },
    { 'ts_ls' },
    { 'nil_ls' },
    { 'cssls' },
    { 'emmet_language_server' },
    { 'pyright' },
    { 'tailwindcss' },
    { 'eslint' },
    { 'jsonls' },
    { 'html' },
    { 'templ' },
    { 'ansiblels' },
    {
      'lua_ls',
      {
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            return
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              }
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
              -- library = vim.api.nvim_get_runtime_file("", true)
            }
          })
          client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end,
        settings = {
          Lua = {}
        },
      }
    }
  }

  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

  for _, opts in pairs(lsps) do
    setup_lsp(lspconfig, capabilities, opts)
  end
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'justin',
    },
    lazy = false,
    keys = {
      { '<leader>wl', vim.cmd.LspInfo, desc = 'Open LspInfo window' },
    },
    config = config
  },
}
