return {
  'nvim-treesitter/nvim-treesitter-context',
  config = function()
    require('treesitter-context').setup {
      max_lines = 5,
    }
  end,
}
