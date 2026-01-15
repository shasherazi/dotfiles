return {
  'mfussenegger/nvim-lint',
  event = { "BufReadPost", "BufNewFile" },

  config = function()
    local lint = require('lint')
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      python = { 'flake8' },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave", "TextChanged" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set('n', '<leader>l', function()
      lint.try_lint()
    end, { desc = "Run linter" })
  end,
}
