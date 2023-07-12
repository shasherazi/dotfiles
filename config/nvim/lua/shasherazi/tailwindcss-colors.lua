local status_ok, taiwindcssColors = pcall(require, "tailwindcss-colors")
if not status_ok then
  return
end

taiwindcssColors.setup()
