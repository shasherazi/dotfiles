return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",                     -- suggestions from current buffer
    "hrsh7th/cmp-path",                       -- suggestions from file system paths
    "hrsh7th/cmp-nvim-lsp",                   -- suggestions from nvim lsp
    "rafamadriz/friendly-snippets",           -- a collection of snippets
    "nvim-treesitter/nvim-treesitter",        -- for better syntax awareness
    "onsails/lspkind-nvim",                   -- pictograms for cmp
    "roobert/tailwindcss-colorizer-cmp.nvim", -- color preview for tailwind classes
    'saadparwaiz1/cmp_luasnip',               -- for luasnip integration
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp"
    },
  },

  config = function()
    vim.g.copilot_no_tab_map = true

    local cmp = require("cmp")
    local has_luasnip, luasnip = pcall(require, "luasnip")
    local lspkind = require("lspkind")
    local colorizer = require("tailwindcss-colorizer-cmp").formatter

    local rhs = function(keys)
      return vim.api.nvim_replace_termcodes(keys, true, true, true)
    end

    local lsp_kinds = {
      Class = ' ',
      Color = ' ',
      Constant = ' ',
      Constructor = ' ',
      Enum = ' ',
      EnumMember = ' ',
      Event = ' ',
      Field = ' ',
      File = ' ',
      Folder = ' ',
      Function = ' ',
      Interface = ' ',
      Keyword = ' ',
      Method = ' ',
      Module = ' ',
      Operator = ' ',
      Property = ' ',
      Reference = ' ',
      Snippet = ' ',
      Struct = ' ',
      Text = ' ',
      TypeParameter = ' ',
      Unit = ' ',
      Value = ' ',
      Variable = ' ',
    }

    -- Returns the current column number.
    local column = function()
      table.unpack = table.unpack or unpack -- 5.1 compatibility
      local _line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
      return col
    end


    -- luasnip custom function
    local in_snippet = function()
      local session = require('luasnip.session')
      local node = session.current_nodes[vim.api.nvim_get_current_buf()]
      if not node then
        return false
      end
      local snippet = node.parent.snippet
      local snip_begin_pos, snip_end_pos = snippet.mark:pos_begin_end()
      local pos = vim.api.nvim_win_get_cursor(0)
      if pos[1] - 1 >= snip_begin_pos[1] and pos[1] - 1 <= snip_end_pos[1] then
        return true
      end
    end

    -- returns true if the cursor is in leftmost column or at a whitespace char
    local in_whitespace = function()
      local col = column()
      return col == 0 or vim.api.nvim_get_current_line():sub(col, col):match('%s')
    end

    local in_leading_indent = function()
      local col = column()
      local line = vim.api.nvim_get_current_line()
      local prefix = line:sub(1, col)
      return prefix:find('^%s*$')
    end

    -- custom shift width
    local shift_width = function()
      if vim.o.softtabstop <= 0 then
        return vim.fn.shiftwidth()
      else
        return vim.o.softtabstop
      end
    end

    -- custom smart backspace
    local smart_bs = function(dedent)
      local keys = nil
      if vim.o.expandtab then
        if dedent then
          keys = rhs('<C-D>')
        else
          keys = rhs('<BS>')
        end
      else
        local col = column()
        local line = vim.api.nvim_get_current_line()
        local prefix = line:sub(1, col)
        if in_leading_indent() then
          keys = rhs('<BS>')
        else
          local previous_char = prefix:sub(#prefix, #prefix)
          if previous_char ~= ' ' then
            keys = rhs('<BS>')
          else
            keys = rhs('<C-\\><C-o>:set expandtab<CR><BS><C-\\><C-o>:set noexpandtab<CR>')
          end
        end
      end
      vim.api.nvim_feedkeys(keys, 'nt', true)
    end

    -- custom smart tabs function
    local smart_tab = function(opts)
      local keys = nil
      if vim.o.expandtab then
        keys = '<Tab>' -- Neovim will insert spaces.
      else
        local col = column()
        local line = vim.api.nvim_get_current_line()
        local prefix = line:sub(1, col)
        local in_leading_indent = prefix:find('^%s*$')
        if in_leading_indent then
          -- inserts a hard tab.
          keys = '<Tab>'
        else
          local sw = shift_width()
          local previous_char = prefix:sub(#prefix, #prefix)
          local previous_column = #prefix - #previous_char + 1
          local current_column = vim.fn.virtcol({ vim.fn.line('.'), previous_column }) + 1
          local remainder = (current_column - 1) % sw
          local move = remainder == 0 and sw or sw - remainder
          keys = (' '):rep(move)
        end
      end

      vim.api.nvim_feedkeys(rhs(keys), 'nt', true)
    end

    local select_next_item = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end

    local select_prev_item = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end


    -- NOTE: Until https://github.com/hrsh7th/nvim-cmp/issues/1716
    -- (cmp.ConfirmBehavior.MatchSuffix) gets implemented, use this local wrapper
    -- to choose between `cmp.ConfirmBehavior.Insert` and `cmp.ConfirmBehavior.Replace`:
    local confirm = function(entry)
      local behavior = cmp.ConfirmBehavior.Replace
      if entry then
        local completion_item = entry.completion_item
        local newText = ''
        if completion_item.textEdit then
          newText = completion_item.textEdit.newText
        elseif type(completion_item.insertText) == 'string' and completion_item.insertText ~= '' then
          newText = completion_item.insertText
        else
          newText = completion_item.word or completion_item.label or ''
        end

        -- checks how many characters will be different after the cursor position if we replace?
        local diff_after = math.max(0, entry.replace_range['end'].character + 1) - entry.context.cursor.col

        -- does the text that will be replaced after the cursor match the suffix
        -- of the `newText` to be inserted ? if not, then `Insert` instead.
        if entry.context.cursor_after_line:sub(1, diff_after) ~= newText:sub(-diff_after) then
          behavior = cmp.ConfirmBehavior.Insert
        end
      end
      cmp.confirm({ select = true, behavior = behavior })
    end

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered(),
      },

      -- config nvim cmp to work with snippet engine
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- autocompletion sources
      sources = cmp.config.sources({
        { name = "luasnip" }, -- snippets
        { name = "lazydev" },
        { name = "nvim_lsp" },
        { name = "buffer" }, -- text within current buffer
        { name = "path" },   -- file system paths
        { name = "tailwindcss-colorizer-cmp" },
      }),

      mapping = cmp.mapping.preset.insert({
        ['<BS>'] = cmp.mapping(function(_fallback)
          smart_bs()
        end, { 'i', 's' }),

        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ['<C-d>'] = cmp.mapping(function()
          cmp.close_docs()
        end, { 'i', 's' }),

        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-j>'] = cmp.mapping(select_next_item),
        ['<C-k>'] = cmp.mapping(select_prev_item),
        ['<C-n>'] = cmp.mapping(select_next_item),
        ['<C-p>'] = cmp.mapping(select_prev_item),
        ['<Down>'] = cmp.mapping(select_next_item),
        ['<Up>'] = cmp.mapping(select_prev_item),

        ['<C-y>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            confirm(entry)
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<CR>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            confirm(entry)
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif has_luasnip and in_snippet() and luasnip.jumpable(-1) then
            luasnip.jump(-1)
          elseif in_leading_indent() then
            smart_bs(true) -- true means to dedent
          elseif in_whitespace() then
            smart_bs()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<Tab>'] = cmp.mapping(function(_fallback)
          local copilot_keys = vim.fn["copilot#Accept"]("")
          if copilot_keys ~= "" and type(copilot_keys) == "string" then
            vim.api.nvim_feedkeys(copilot_keys, "i", true)
            -- 2. Check for nvim-cmp completion
          elseif cmp.visible() then
            -- if there is only one completion candidate then use it.
            local entries = cmp.get_entries()
            if #entries == 1 then
              confirm(entries[1])
            else
              cmp.select_next_item()
            end
          elseif has_luasnip and luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif in_whitespace() then
            smart_tab()
          else
            cmp.complete()
          end
        end, { 'i', 's' }),
      }),

      -- setup lspkind for vscode pictograms in autocompletion dropdown menu
      formatting = {
        format = function(entry, vim_item)
          -- Add custom lsp_kinds icons
          vim_item.kind = string.format('%s %s', lsp_kinds[vim_item.kind] or '', vim_item.kind)


          -- add menu tags (e.g., [Buffer], [LSP])
          vim_item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[LaTeX]",
          })[entry.source.name]

          -- use lspkind and tailwindcss-colorizer-cmp for additional formatting
          vim_item = lspkind.cmp_format({
            maxwidth = 25,
            ellipsis_char = "...",
          })(entry, vim_item)

          if entry.source.name == "nvim_lsp" then
            vim_item = colorizer(entry, vim_item)
          end

          return vim_item
        end,
        -- format = lspkind.cmp_format({
        --         maxwidth = 30,
        --         ellipsis_char = "...",
        --         before = require("tailwindcss-colorizer-cmp").formatter
        -- }),
        -- format = require("tailwindcss-colorizer-cmp").formatter
      },
    })
  end
}
