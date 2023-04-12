local status_ok, nonicons = pcall(require, "nonicons")
if not status_ok then
  return
end

nonicons.setup()
