return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },

  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        css = { "prettierd" },
        html = { "prettierd" },
        javascript = { "prettierd" },
        json = { "prettierd" },
        markdown = { "prettierd" },
        python = { "black" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
      },
    })

    vim.keymap.set("n", "<leader>=", function()
      conform.format({
        lsp_fallback = true,
        async = true,
        timeout_ms = 2000,
      })
    end, { desc = "Format buffer or range with conform.nvim" })
  end,
}
