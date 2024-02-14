return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
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
      vim.keymap.set('n', '<c-k>', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', '<c-j>', vim.diagnostic.goto_next, opts)
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
        cmd = { 'poetry', 'run', 'pyright-langserver', '--stdio' },
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
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'onsails/lspkind.nvim' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-vsnip' },
      {
        'hrsh7th/vim-vsnip',
        config = function()
          vim.cmd([[
            imap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)'  : '<Tab>'
            smap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)'  : '<Tab>'
            imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'  : '<S-Tab>'
            smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'  : '<S-Tab>'
          ]])
          vim.keymap.set('i', '<S-Tab>', '<c-d>', { remap = true })
        end
      },
    },
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
        -- from https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-get-types-on-the-left-and-offset-the-menu
        window = {
          completion = {
            col_offset = -3, -- align completion with cursor, assuming the completion menu contains icon prefixes
            side_padding = 0,
            border = 'rounded',
          },
          documentation = {
            border = 'rounded',
          },
        },
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, vim_item) -- This function formats the completion as <icon> <completion> (<source>)
            local kind = require('lspkind').cmp_format({
              maxwidth = 50,
              before = function(_, vi)
                -- This is a hacky workaround to set the menu highlight group (i.e. the source
                -- in nvim-cmp) to match the kind highlight (i.e. the symbol).
                --
                -- See :help complete-items for understanding menu
                -- Or :help cmp-config.formatting.format for understanding this override
                vi.menu_hl_group = 'CmpItemKind' .. vi.kind
                return vi
              end,
            })(entry, vim_item)
            local strings = vim.split(kind.kind, '%s', { trimempty = true })
            kind.kind = ' ' .. (strings[1] or '') .. ' '
            kind.menu = '    (' .. (strings[2] or '') .. ')'
            return kind
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
        }, {
          { name = 'buffer' },
        }),
        experimental = {
          ghost_text = false,
        },
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end
  },
}
