return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'justin',
    },
    lazy = false,
    keys = {
      { '<leader>wl', vim.cmd.LspInfo },
    },
    config = function()
      local c = require('justin.colors')
      c.hi('LspInfoBorder', { link = 'FloatBorder' })
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

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(_, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', 'gc', vim.lsp.buf.incoming_calls, bufopts)
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>re', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>d', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<leader>K', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
      end

      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      lspconfig['gopls'].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          gopls = {
            buildFlags = { '-tags', 'functional,integration' },
            semanticTokens = true,
            usePlaceholders = true,
          }
        }
      }

      lspconfig['dockerls'].setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      lspconfig['rust_analyzer'].setup {
        on_attach = on_attach,
        capabilities = capabilities
      }

      lspconfig['pyright'].setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      lspconfig['volar'].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig['terraformls'].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig['jsonnet_ls'].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig['tsserver'].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig['cssls'].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig['emmet_language_server'].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig['tailwindcss'].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig['jsonls'].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig['html'].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig['lua_ls'].setup({
        on_attach = on_attach,
        on_init = (function(client)
          local path = client.workspace_folders[1].name
          if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
              Lua = {
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
              }
            })

            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
          end
          return true
        end),
        capabilities = capabilities,
      })
    end
  },
}
