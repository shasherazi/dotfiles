return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'gruvbox-material'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    'tiagovla/tokyodark.nvim',
    'catppuccin/nvim',
    'rose-pine/neovim',
    'EdenEast/nightfox.nvim',
    'sainnhe/gruvbox-material',
    'sainnhe/everforest',
    'projekt0n/github-nvim-theme',
    'navarasu/onedark.nvim',
    'marko-cerovac/material.nvim',
    'bluz71/vim-nightfly-colors',
    'rmehri01/onenord.nvim',
    'arcticicestudio/nord-vim',
    'shaunsingh/nord.nvim',
    'mhartington/oceanic-next',
    'nyoom-engineering/oxocarbon.nvim',
  },
}
-- vim: ts=2 sts=2 sw=2 et
