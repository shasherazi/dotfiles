local status_ok, mini_misc = pcall(require, "mini.misc")
if not status_ok then
  return
end

mini_misc.setup(
-- No need to copy this inside `setup()`. Will be used automatically.
  {
    -- Array of fields to make global (to be used as independent variables)
    make_global = { 'put', 'put_text', 'setup_auto_root' },
  }
)
