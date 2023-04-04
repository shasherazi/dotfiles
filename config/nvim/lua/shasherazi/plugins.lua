local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- packer itself

  use "nvim-lua/plenary.nvim"  -- Useful lua functions used ny lots of plugins
  use 'folke/tokyonight.nvim'  -- colorscheme

  -- cmp plugins
  use "hrsh7th/nvim-cmp"         -- The completion plugin
  use "hrsh7th/cmp-buffer"       -- buffer completions
  use "hrsh7th/cmp-path"         -- path completions
  use "hrsh7th/cmp-cmdline"      -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/LuaSnip"             --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig"             -- enable LSP
  use "williamboman/mason.nvim"           -- simple to use language server installer
  use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer
  use 'jose-elias-alvarez/null-ls.nvim'   -- LSP diagnostics and code actions

  use "nvim-telescope/telescope.nvim"

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use "p00f/nvim-ts-rainbow"  -- rainbow brackets

  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter

  use "github/copilot.vim"    -- github copilot

  use "numToStr/Comment.nvim" -- Easily comment stuff
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- nvim tree
  use 'kyazdani42/nvim-web-devicons'
  use 'DaikyXendo/nvim-material-icon'
  use 'kyazdani42/nvim-tree.lua'

  -- bufferline
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"

  -- lualne
  use 'nvim-lualine/lualine.nvim'

  -- toggleterm
  use "akinsho/toggleterm.nvim"

  -- impatient
  use 'lewis6991/impatient.nvim'

  -- indentline
  use "lukas-reineke/indent-blankline.nvim"

  -- greeter
  use 'goolord/alpha-nvim'

  -- discord rich presence
  use 'andweeb/presence.nvim'

  -- whichkey
  use "folke/which-key.nvim"

  if packer_bootstrap then
    require('packer').sync()
  end
end)
