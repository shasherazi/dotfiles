local status_ok, shade = pcall(require, "shade")
if not status_ok then
  return
end

shade.setup({
  overlay_opacity = 60,
})
