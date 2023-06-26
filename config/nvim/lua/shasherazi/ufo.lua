local status_ufo, ufo = pcall(require, "ufo")
if not status_ufo then
  return
end

ufo.setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end
})
