local status_ok, mini_statusline = pcall(require, "mini.statusline")
if not status_ok then
  return
end

mini_statusline.setup(
-- No need to copy this inside `setup()`. Will be used automatically.
  {
    -- Content of statusline as functions which return statusline string. See
    -- `:h statusline` and code of default contents (used instead of `nil`).
    content = {
      -- Content for active window
      active = nil,
      -- Content for inactive window(s)
      inactive = nil,
    },

    -- Whether to use icons by default
    use_icons = true,

    -- Whether to set Vim's settings for statusline (make it always shown with
    -- 'laststatus' set to 2). To use global statusline in Neovim>=0.7.0, set
    -- this to `false` and 'laststatus' to 3.
    set_vim_settings = true,
  }
)
