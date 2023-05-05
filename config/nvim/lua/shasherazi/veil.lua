local status_veil_ok, veil = pcall(require, "veil")
if not status_veil_ok then
  return
end

local status_builtin_ok, builtin = pcall(require, "veil.builtin")
if not status_builtin_ok then
  return
end

local default = {
  sections = {
    builtin.sections.animated(builtin.headers.frames_nvim, {
      hl = { fg = "#5de4c7" },
    }),
    builtin.sections.buttons({
      {
        icon = "",
        text = "Quit",
        shortcut = "q",
        callback = function()
          vim.cmd("qa")
        end,
      }
    }),
  },
  mappings = {},
  startup = true,
  listed = true
}

veil.setup(default)
