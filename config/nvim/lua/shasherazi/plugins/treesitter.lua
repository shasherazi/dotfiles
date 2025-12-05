return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  build = ':TSUpdate',
  config = function()
    local treesitter = require('nvim-treesitter.configs')
    treesitter.setup({
      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = {},
      },

      indent = {
        enable = true,
        disable = {}
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          -- node_decremental = "<M-Space>",
        },
      },
    })
  end
}

