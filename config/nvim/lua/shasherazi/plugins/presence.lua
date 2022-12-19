local setup, presence = pcall(require, "presence")
if not setup then
  return
end

presence:setup({
  main_image = "file",
})
