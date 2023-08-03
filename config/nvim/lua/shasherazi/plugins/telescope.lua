local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
  return
end

local fb_actions_status_ok, fb_actions = pcall(require, "telescope.extensions.file_browser.actions")
if not fb_actions_status_ok then
  return
end

telescope.setup {
  pickers = {
    find_files = { hidden = true },
  }
}

telescope.load_extension('fzf')
