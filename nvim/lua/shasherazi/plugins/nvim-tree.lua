local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup({
  open_on_setup = true,
  actions = {
    change_dir = {
      restrict_above_cwd = true,
    },
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
  view = {
    side = "right",
  },
  renderer = {
    icons = {
      git_placement = "signcolumn",
      show = {
        folder_arrow = false,
      },
      glyphs = {
        folder = {
          default = '',
          open = '',
          empty = '',
          empty_open = '',
        },
      },
    },
  },
})
