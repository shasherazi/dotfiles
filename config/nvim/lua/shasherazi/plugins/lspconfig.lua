return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "mason-org/mason.nvim",
  },
  config = function()
    local mason = require("mason")

    mason.setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        },
      },
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    --    Key:   The server name (e.g., 'lua_ls', 'nixd', 'clangd')
    --    Value: A table of settings to OVERRIDE defaults.
    --           Pass an empty table {} to accept all defaults.
    local servers = {
      -- AUTOMATED: These use default cmd, root_dir, etc.
      -- nixd = {},    -- If you use nixd
      -- nil_ls = {},  -- If you use nil
      -- clangd = {},
      -- pyright = {},

      astro = {},
      clangd = {},
      emmet_language_server = {},
      jsonls = {},
      hyprls = {},
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
          },
        },
      },
      nil_ls = {},
      nixd = {},
      ron_lsp = { filetypes = { "ron" } },
      tailwindcss = {},
      ty = {}, -- python type checker written in rust
      vtsls = {},
    }

    -- 2. Loop through the list and enable them
    for name, opts in pairs(servers) do
      -- Add completion capabilities to every server
      opts.capabilities = capabilities

      vim.lsp.config(name, opts)
      vim.lsp.enable(name)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "LSP: Hover"
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover { border = "single" } end, opts)

        opts.desc = "LSP: Go to definition"
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "LSP: Go to declaration"
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "LSP: Type definition"
        vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "LSP: Implementations"
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "LSP: References"
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "LSP: Code action"
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "LSP: Rename"
        vim.keymap.set("n", "<leader>rn", function() return ":IncRename " .. vim.fn.expand("<cword>") end,
          { expr = true, buffer = ev.buf, desc = "LSP: Rename" })

        opts.desc = "Diagnostics: Buffer"
        vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Diagnostics: Line"
        vim.keymap.set(
          "n",
          "<leader>d",
          function() vim.diagnostic.open_float { border = "single", source = true } end,
          opts
        )

        opts.desc = "LSP: Restart"
        vim.keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)

        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, ev.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })

          vim.api.nvim_create_autocmd({ "CursorHold" }, {
            buffer = ev.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufLeave" }, {
            buffer = ev.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references
          })
        end

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, ev.buf) then
          vim.lsp.inlay_hint.enable()

          -- toggle with <leader>ih
          opts.desc = "LSP: Toggle Inlay Hints"
          vim.keymap.set("n", "<leader>ih", function()
            if vim.lsp.inlay_hint.is_enabled() then
              vim.lsp.inlay_hint.enable(false)
            else
              vim.lsp.inlay_hint.enable(true)
            end
          end, opts)
        end
      end,
    })

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
      virtual_text = true,
      underline = true,
      update_in_insert = false,
    })
  end,
}
