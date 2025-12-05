return {
  "mason-org/mason.nvim",

  config = function()
    local mason = require("mason")

    mason.setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        },
      },
    })
  end
}
