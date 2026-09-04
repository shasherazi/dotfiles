local autosave_group = vim.api.nvim_create_augroup("autosave", { clear = true })
local autosave_timer = nil
local DELAY = 1000

local function save()
  local buf = vim.api.nvim_get_current_buf()

  -- Check conditions (modifiable, has filename, not read-only)
  if not vim.api.nvim_buf_is_valid(buf) then return end
  local bo = vim.bo[buf]
  if bo.buftype ~= "" or not bo.modifiable or bo.readonly then return end
  if vim.api.nvim_buf_get_name(buf) == "" then return end

  vim.cmd("silent! update")
end

local function debounce_save()
  if autosave_timer then
    autosave_timer:stop()
    autosave_timer:close()
  end

  autosave_timer = vim.uv.new_timer()
  if not autosave_timer then return end -- nil check
  autosave_timer:start(DELAY, 0, vim.schedule_wrap(function()
    save()
    autosave_timer = nil
  end))
end

vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost", "BufLeave" }, {
  group = autosave_group,
  callback = save
})

vim.api.nvim_create_autocmd("TextChanged", {
  group = autosave_group,
  callback = debounce_save,
})

-- autosave
-- vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
--   pattern = { '*' },
--   command = 'silent! wall',
--   nested = true,
-- })
