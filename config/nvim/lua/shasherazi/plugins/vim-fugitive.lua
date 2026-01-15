return {
  "tpope/vim-fugitive",
  config = function()
    -- Top-level keymap to open :Git status
    vim.keymap.set("n", "<leader>gg", vim.cmd.Git, { desc = "Open Git fugitive" })

    local myFugitive = vim.api.nvim_create_augroup("myFugitive", { clear = true })

    vim.api.nvim_create_autocmd("BufWinEnter", {
      group = myFugitive,
      callback = function()
        -- Only set these maps inside Fugitive buffers
        if vim.bo.filetype ~= "fugitive" then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, noremap = true, silent = true }

        -- Push
        vim.keymap.set("n", "<leader>P", function()
          vim.cmd.Git("push")
        end, opts)

        -- Pull
        vim.keymap.set("n", "<leader>p", function()
          vim.cmd.Git("pull")
        end, opts)

        -- Prepare a push -u mapping (leaves cursor to type branch)
        vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
      end,
    })
  end,
}
