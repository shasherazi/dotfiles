return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config

  config = function()
    local ibl = require("ibl")
    ibl.setup({})
  end
}

