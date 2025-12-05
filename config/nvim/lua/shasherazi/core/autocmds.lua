local group = vim.api.nvim_create_augroup("autosave_on_insert_leave", { clear = true })

local function may_save(buf)
  if not vim.api.nvim_buf_is_loaded(buf) then return end                  -- buffer is unloaded
  local bo = vim.bo[buf]
  if bo.buftype ~= "" or not bo.modifiable or bo.readonly then return end -- not a normal modifiable buffer
  if vim.api.nvim_buf_get_name(buf) == "" then return end                 -- unnamed buffer
  vim.api.nvim_buf_call(buf, function()
    vim.cmd("silent keepalt keepjumps update")
  end)
end

-- Auto-save when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  group = group,
  callback = function(args)
    may_save(args.buf)
  end,
})

-- Auto-save when the editor loses focus or when leaving a buffer
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  group = group,
  callback = function(args)
    may_save(args.buf)
  end,
})

-- Auto-save when text changes in Normal mode (covers undo/redo)
vim.api.nvim_create_autocmd("TextChanged", {
  group = group,
  callback = function(args)
    -- Only save if we're not in Insert/Replace modes
    local mode = vim.api.nvim_get_mode().mode
    if mode:match("^[iR]") then
      return
    end
    may_save(args.buf)
  end,
})

-- autosave
-- vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
--   pattern = { '*' },
--   command = 'silent! wall',
--   nested = true,
-- })

