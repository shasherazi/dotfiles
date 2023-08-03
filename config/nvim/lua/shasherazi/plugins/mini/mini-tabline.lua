local status_ok, mini_tabline = pcall(require, "mini.tabline")
if not status_ok then
  return
end

mini_tabline.setup(
-- No need to copy this inside `setup()`. Will be used automatically.
  {
    -- Whether to show file icons (requires 'nvim-tree/nvim-web-devicons')
    show_icons = true,

    -- Whether to set Vim's settings for tabline (make it always shown and
    -- allow hidden buffers)
    set_vim_settings = true,

    -- Where to show tabpage section in case of multiple vim tabpages.
    -- One of 'left', 'right', 'none'.
    tabpage_section = 'left',
  }
)
