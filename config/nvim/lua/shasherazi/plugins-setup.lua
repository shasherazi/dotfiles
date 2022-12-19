local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
  use("wbthomason/packer.nvim")

  -- plenary plugin which is a dependency for many others
  use("nvim-lua/plenary.nvim")

  -- colorscheme
  use ("ellisonleao/gruvbox.nvim")

  -- commenting with gc
  use("numToStr/Comment.nvim")

  -- file explorer
  use("nvim-tree/nvim-tree.lua")

  -- discord presence
  use("andweeb/presence.nvim")

  -- web dev icons
  use("nvim-tree/nvim-web-devicons")

  -- lualine
  use("nvim-lualine/lualine.nvim")

  -- nvim treesitter, does something
  use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})

  -- telescope for fuzzy finding
  use({'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }) -- dependency
  use({"nvim-telescope/telescope.nvim", branch = "0.1.x"})

  -- autocompletion
  use("hrsh7th/nvim-cmp") -- completion plugin
  use("hrsh7th/cmp-buffer") -- source for text in buffer
  use("hrsh7th/cmp-path") -- source for file system paths

  -- snippets
  use("L3MON4D3/LuaSnip") -- snippet engine
  use("saadparwaiz1/cmp_luasnip") -- for autocompletion
  use("rafamadriz/friendly-snippets") -- useful snippets

  -- managing & installing lsp servers, linters & formatters
  use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
  use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

  -- configuring lsp servers
  use("neovim/nvim-lspconfig") -- easily configure language servers
  use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
  use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
  use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

  -- gitsigns
  use("lewis6991/gitsigns.nvim")

  -- good looking tabs
  use('romgrk/barbar.nvim')

  -- terminal
  use("akinsho/toggleterm.nvim")

  if packer_bootstrap then
    require("packer").sync()
  end
end)
