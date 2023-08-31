vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(
        vim.lsp.handlers.hover,
        {
            border = "rounded",
        }
    )

vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {
            border = "rounded"
        }
    )


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<c-k>', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<c-j>', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Set "<" prefix before diagnostic virtual text
vim.diagnostic.config({
    virtual_text = {prefix = '<'},
    float = { border = "rounded" },
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gc', vim.lsp.buf.incoming_calls, bufopts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>d', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

-- nvim-cmp configuration
local cmp = require'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    -- window = {},
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
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item) -- This function formats the completion as <icon> <completion> (<source>)
            local kind = require("lspkind").cmp_format({
                maxwidth = 50,
                before = function(e, vi)
                    -- This is a hacky workaround to set the menu highlight group (i.e. the source
                    -- in nvim-cmp) to match the kind highlight (i.e. the symbol).
                    --
                    -- See :help complete-items for understanding menu
                    -- Or :help cmp-config.formatting.format for understanding this override
                    vi.menu_hl_group = 'CmpItemKind' .. vi.kind
                    return vi
                end,
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"
            return kind
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
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

-- Customization for Pmenu (for completion)
-- also from https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-get-types-on-the-left-and-offset-the-menu
vim.api.nvim_set_hl(0, 'Pmenu', { ctermfg = 'White' })
vim.api.nvim_set_hl(0, 'PmenuSel', { ctermbg = 'DarkGray' })
-- vim.api.nvim_set_hl(0, 'CmpItemMenu', { ctermfg = 'Red' })

vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { ctermfg = 'DarkGray', strikethrough = true })

vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bold = true })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpItemAbbrMatch' })

vim.api.nvim_set_hl(0, 'CmpItemKindField', { ctermfg = 'Yellow' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindField' })
vim.api.nvim_set_hl(0, 'CmpItemKindEvent', { link = 'CmpItemKindField' })
vim.api.nvim_set_hl(0, 'CmpItemKindEnumMember', { link = 'CmpItemKindField' })

vim.api.nvim_set_hl(0, 'CmpItemKindText', { ctermfg = 'White' })

vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { ctermfg = 'Red' })
vim.api.nvim_set_hl(0, 'CmpItemKindConstructor', { link = 'CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindReference', { link = 'CmpItemKindKeyword' })

vim.api.nvim_set_hl(0, 'CmpItemKindValue', { ctermfg = 2 }) -- for some reason, "Green" doesn't match this color

vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { ctermfg = 'DarkMagenta' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
vim.api.nvim_set_hl(0, 'CmpItemKindStruct', { link = 'CmpItemKindFunction' })
vim.api.nvim_set_hl(0, 'CmpItemKindClass', { link = 'CmpItemKindFunction' })
vim.api.nvim_set_hl(0, 'CmpItemKindOperator', { link = 'CmpItemKindFunction' })
vim.api.nvim_set_hl(0, 'CmpItemKindEnum', { link = 'CmpItemKindFunction' })

vim.api.nvim_set_hl(0, 'CmpItemKindModule', { ctermfg = 2 }) -- for some reason, "Green" doesn't match this color

vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { ctermfg = 'Blue' })
vim.api.nvim_set_hl(0, 'CmpItemKindConstant', { link = 'CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindFile', { link = 'CmpItemKindVariable' })

-- vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { ctermfg = '#F5EBD9', ctermbg = '#D4A959' })
-- vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { ctermfg = '#F5EBD9', ctermbg = '#D4A959' })
vim.api.nvim_set_hl(0, 'CmpItemKindFolder', { ctermfg = 'Cyan' })

vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { ctermfg = 'Cyan' })
vim.api.nvim_set_hl(0, 'CmpItemKindTypeParameter', { link = 'CmpItemKindInterface' })


-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local lspconfig = require('lspconfig')

lspconfig['gopls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
        gopls = {
            buildFlags = {'-tags', 'functional,integration'}
        }
    }
}

lspconfig['rust_analyzer'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}

lspconfig['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    cmd = {'poetry', 'run', 'pyright-langserver', '--stdio'},
}
