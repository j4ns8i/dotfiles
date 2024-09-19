local function set_highlights()
  local c = require('justin').colorscheme
  c.hi('CmpItemAbbrDeprecated',    { ctermfg = c.lightgray, strikethrough = true, fg = c.guilightgray })
  c.hi('CmpItemAbbrMatch',         { bold = true })
  c.hi('CmpItemAbbrMatchFuzzy',    { link = 'CmpItemAbbrMatch' })
  c.hi('CmpItemKindModule',        { ctermfg = c.darkblue, fg = c.guidarkblue })
  c.hi('CmpItemKindField',         { ctermfg = c.darkblue, fg = c.guidarkblue })
  c.hi('CmpItemKindProperty',      { link = 'CmpItemKindField' })
  c.hi('CmpItemKindEvent',         { link = 'CmpItemKindField' })
  c.hi('CmpItemKindEnumMember',    { link = 'CmpItemKindField' })
  c.hi('CmpItemKindText',          { ctermfg = c.white, fg = c.guiwhite })
  c.hi('CmpItemKindKeyword',       { link = 'Keyword' })
  c.hi('CmpItemKindConstructor',   { link = 'Keyword' })
  c.hi('CmpItemKindReference',     { link = 'Keyword' })
  c.hi('CmpItemKindValue',         { ctermfg = c.darkgreen, fg = c.guidarkgreen })
  c.hi('CmpItemKindFunction',      { link = 'Function' })
  c.hi('CmpItemKindMethod',        { link = 'CmpItemKindFunction' })
  c.hi('CmpItemKindStruct',        { link = 'Type' })
  c.hi('CmpItemKindClass',         { link = 'CmpItemKindStruct' })
  c.hi('CmpItemKindEnum',          { link = 'CmpItemKindStruct' })
  c.hi('CmpItemKindInterface',     { link = 'CmpItemKindStruct' })
  c.hi('CmpItemKindTypeParameter', { link = 'CmpItemKindStruct' })
  c.hi('CmpItemKindOperator',      { link = 'Operator' })
  c.hi('CmpItemKindVariable',      { ctermfg = c.darkcyan, fg = c.guidarkcyan })
  c.hi('CmpItemKindConstant',      { link = 'CmpItemKindVariable' })
  c.hi('CmpItemKindFile',          { link = 'CmpItemKindVariable' })
  c.hi('CmpItemKindFolder',        { link = 'CmpItemKindModule' })
end

return {
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
      { 'justin' },
    },
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = function()
      set_highlights()
      vim.opt.completeopt = { 'menu', 'menuone', 'preview' }
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
            col_offset = -4, -- align completion with cursor, assuming the completion menu contains icon prefixes
            side_padding = 0,
            border = 'rounded',
            winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
          },
          documentation = {
            border = 'rounded',
            winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
          },
        },
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, vim_item) -- This function formats the completion as <icon> <completion> (<type>)
            local kind = require('lspkind').cmp_format({
              before = function(_, vi)
                -- Set the kind icon and type (menu) highlight groups to match
                -- See :help complete-items for understanding menu
                -- Or :help cmp-config.formatting.format for understanding this override
                vi.menu_hl_group = 'CmpItemKind' .. vi.kind
                vi.abbr_hl_group = 'CmpItemAbbr'
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
