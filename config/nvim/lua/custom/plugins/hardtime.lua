return {
  'm4xshen/hardtime.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  opts = {
    restricted_keys = {
      ['h'] = { 'n', 'x' },
      ['j'] = {},
      ['k'] = {},
      ['l'] = { 'n', 'x' },
      ['+'] = { 'n', 'x' },
      ['gj'] = { 'n', 'x' },
      ['gk'] = { 'n', 'x' },
      ['<C-M>'] = { 'n', 'x' },
      ['<C-N>'] = { 'n', 'x' },
      ['<C-P>'] = { 'n', 'x' },
    },
  },
}
