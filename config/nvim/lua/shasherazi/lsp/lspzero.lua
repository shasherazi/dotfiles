local status_lspzero_ok, lspzero = pcall(require, "lsp-zero")
if not status_lspzero_ok then
  return
end

local status_lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not status_lspconfig_ok then
  return
end

local lsp = lspzero.preset({})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({
    buffer = bufnr,
    preserve_mappings = false,
    omit = { ']d', '[d' }
  })

  vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ float = { source = true } })<CR>')
  vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ float = { source = true } })<CR>')

  if client.name == "html" or client.name == "cssls" or client.name == "tsserver" then
    print("Disabling formatting for " .. client.name)
    client.server_capabilities.documentFormattingProvider = false
  end
end)

lsp.ensure_installed({
  'lua_ls',
  'html',
  'cssls',
  'tsserver',
  'eslint',
  'jsonls',
  'clangd',
  'pyright',
  'tailwindcss',
  'rust_analyzer'
})

vim.diagnostic.config({
  source = true
})

lsp.set_server_config({
  on_init = function(client)
    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_exec(
        [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
        false
      )
    end
  end
})

-- (Optional) Configure lua language server for neovim
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
lspconfig.clangd.setup({ capabilities = capabilities })
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}
local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
  require('lspconfig')[ls].setup({
    capabilities = capabilities
    -- you can add other fields for setting up lsp server in this table
  })
end

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = {
    -- `enter` key to confirm completion
    ['<cr>'] = cmp.mapping.confirm({ select = false }),

    -- ctrl+space to trigger completion menu
    -- ['<c-space>'] = cmp.mapping.complete(),
    ['<c-n>'] = cmp.mapping.complete(),

    -- navigate between snippet placeholder
    ['<c-f>'] = cmp_action.luasnip_jump_forward(),
    ['<c-b>'] = cmp_action.luasnip_jump_backward(),
    -- ['<Tab>'] = cmp_action.luasnip_supertab(),
    -- ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.abbr = string.sub(vim_item.abbr, 1, 69)
      return vim_item
    end
  },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  },
})
