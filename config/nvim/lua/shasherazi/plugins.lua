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
      { 'hrsh7th/cmp-path' }
    }
  },

  -- dap
  { 'mfussenegger/nvim-dap' },
  { 'rcarriga/nvim-dap-ui' },
  { 'theHamsta/nvim-dap-virtual-text' },

  -- lazy.nvim
  -- {
  --   "folke/noice.nvim",
  --   opts = function(_, opts)
  --     local function setOpts()
  --       if opts.routes == nil then
  --         opts.routes = {}
  --         return
  --       end
  --     end
  --     setOpts()
  --     -- opts = getOpts(opts)
  --     -- opts = opts or { routes = {} }
  --     table.insert(opts.routes, {
  --       filter = {
  --         event = "notify",
  --         find = "No information available",
  --       },
  --       opts = { skip = true },
  --     })
  --   end,
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     "rcarriga/nvim-notify",
  --   }
  -- },

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
  { 'echasnovski/mini.surround', version = false },
  -- { 'echasnovski/mini.indentscope', version = false },

  -- colorschemes
  'folke/tokyonight.nvim',
  'rafamadriz/neon',
  'marko-cerovac/material.nvim',
  'nyoom-engineering/oxocarbon.nvim',
  'sainnhe/edge',
  'Th3Whit3Wolf/space-nvim',
  'sainnhe/gruvbox-material',
  'sainnhe/everforest',
  'dracula/vim',
  'rose-pine/neovim',

  -- misc
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {}
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },
  { 'iamcco/markdown-preview.nvim',        build = "cd app && yarn install" },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl",                                opts = {} },
  { "nvim-lualine/lualine.nvim",           dependencies = "nvim-tree/nvim-web-devicons" },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies =
    'nvim-tree/nvim-web-devicons'
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
  },
  "numToStr/FTerm.nvim",
  'andweeb/presence.nvim',
  "folke/which-key.nvim",
  "Pocco81/auto-save.nvim",
  'lewis6991/gitsigns.nvim',
  'github/copilot.vim',
  'tpope/vim-fugitive',
  'jose-elias-alvarez/null-ls.nvim',
  'famiu/feline.nvim',
  'NvChad/nvim-colorizer.lua',
  'nvim-treesitter/nvim-treesitter-context',
  -- 'is0n/fm-nvim',
  'alexghergh/nvim-tmux-navigation',
  -- 'karb94/neoscroll.nvim',
  'elkowar/yuck.vim',
  'windwp/nvim-ts-autotag',
})
