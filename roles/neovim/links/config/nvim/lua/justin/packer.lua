-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    }
  }

  use({
    'nvim-treesitter/nvim-treesitter',
    -- packer fails to install on the first try by default; we have to
    -- specify a run function that imports the install scripts then runs
    -- the update
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end
  })

  -- Provides :TSPlaygroundToggle to debug treesitter attributes
  use({ 'nvim-treesitter/playground' })
  -- use({ 'theprimeagen/harpoon' })
  use({ 'mbbill/undotree' })

  use({ 'nvim-tree/nvim-web-devicons' })

  use({ 'neovim/nvim-lspconfig' })
  use({ 'onsails/lspkind.nvim' })
  use({
    'williamboman/mason.nvim',
    requires = { { 'williamboman/mason-lspconfig.nvim' } }
  })

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- Use ys<motion><char> to surround with <char>
  -- Use ds<char> to delete surrounding <char>
  -- Use cs<char><char> to replace surrounding <char>s
  use({ 'tpope/vim-surround' })

  -- Easy commenting
  use({
    'preservim/nerdcommenter',
    config = function()
      -- Must be run early
      vim.g.NERDCreateDefaultMappings = 0
    end
  })

  -- Git commands (primarily for git blame)
  use({ 'tpope/vim-fugitive' })

  -- Git status in column
  use({ 'airblade/vim-gitgutter' })

  -- TODO
  -- use({ 'preservim/tagbar' })

  -- Manual alignment with ga and gA
  use({ 'echasnovski/mini.align' })

  -- Add indent guides
  use({ 'preservim/vim-indent-guides' })

  use({
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
  })

  use({ 'preservim/nerdtree' })

  use({ 'lukas-reineke/indent-blankline.nvim' })

  use({ 'airblade/vim-rooter' })

  use({ 'RRethy/vim-illuminate' })

  use({
    'folke/trouble.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  })
end)
