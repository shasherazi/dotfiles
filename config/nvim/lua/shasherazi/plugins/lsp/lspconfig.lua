return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
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

      clangd = {},
      ts_ls = {},
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            telemetry = { enable = false },
          },
        },
      },
      nixd = {},
      ty = {},
    }

    -- 2. Loop through the list and enable them
    for name, opts in pairs(servers) do
      -- Add completion capabilities to every server
      opts.capabilities = capabilities

      vim.lsp.config(name, opts)
      vim.lsp.enable(name)
    end

    -- 3. Keymaps (Standard LspAttach config)
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
        vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "LSP: Code action"
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "LSP: Rename"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Diagnostics: Buffer"
        vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Diagnostics: Line"
        vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float { border = "single" } end, opts)

        opts.desc = "LSP: Restart"
        vim.keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)

        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
      end,
    })

    -- 4. Cosmetics (Signs and Virtual Text)
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
