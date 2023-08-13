local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

lazy.setup({
  'nvim-lua/plenary.nvim', -- plugins need it or smth

  -- lsp zero
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    }
  },

  -- lazy.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },

  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- mini
  { 'echasnovski/mini.comment',  version = false },
  { 'echasnovski/mini.move',     version = false },
  { 'echasnovski/mini.pairs',    version = false },
  { 'uchaunovski/mini.surround', version = false },

  -- colorschemes
  'folke/tokyonight.nvim',

  -- misc
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },
  "numToStr/FTerm.nvim",
  'andweeb/presence.nvim',
  "folke/which-key.nvim",
  "Pocco81/auto-save.nvim",
  'lewis6991/gitsigns.nvim',
  'github/copilot.vim',
  'tpope/vim-fugitive',
})
