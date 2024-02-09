return {
  'lukas-reineke/indent-blankline.nvim',
  opts = function()
    -- TODO: lazy.nvim seems to really make it difficult to set highlights
    -- outside of a colorscheme file, but I can't figure out why that is.
    return {
      indent = { char = '┆' },
      scope = { enabled = false },
    }
  end,
  config = function (_, opts)
    require('ibl').setup(opts)
  end
}
