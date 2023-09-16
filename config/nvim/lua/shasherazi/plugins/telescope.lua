local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
  return
end

telescope.setup {
  pickers = {
    find_files = { hidden = true },
    colorscheme = { enable_preview = true },
  }
}
