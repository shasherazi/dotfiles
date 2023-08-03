local status_ok, fterm = pcall(require, "FTerm")
if not status_ok then
  return
end

fterm.setup(
  {
    dimensions = {
      height = 0.9,
      width = 0.9,
      x = 0.5,
      y = 0.5
    },
    border = "single" -- or 'double'
  }
)
