local status_ok, nvim_lint = pcall(require, "lint")
if not status_ok then
  return
end

nvim_lint.linters_by_ft = {
  python = { "flake8" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
