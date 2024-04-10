local status_ok, indentmini = pcall(require, "indentmini")
if not status_ok then
  return
end

indentmini.setup()
