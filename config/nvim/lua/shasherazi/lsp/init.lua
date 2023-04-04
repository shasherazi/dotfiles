local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "shasherazi.lsp.mason"
require("shasherazi.lsp.handlers").setup()
require "shasherazi.lsp.null-ls"
