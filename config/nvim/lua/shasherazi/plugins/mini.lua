return {
  "nvim-mini/mini.nvim",
  version = "*",
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring', -- for MiniComment integration
  },

  config = function()
    --                            ▄▄     ▄▄
    --          ▀▀        ▀▀     ██  ▀▀  ██
    -- ███▄███▄ ██  ████▄ ██    ▀██▀ ██  ██ ▄█▀█▄ ▄█▀▀▀
    -- ██ ██ ██ ██  ██ ██ ██     ██  ██  ██ ██▄█▀ ▀███▄
    -- ██ ██ ██ ██▄ ██ ██ ██▄ ██ ██  ██▄ ██ ▀█▄▄▄ ▄▄▄█▀

    local MiniFiles = require("mini.files")
    MiniFiles.setup({
      mappings = {
        go_in = "<CR>",
        go_in_plus = "l",
        go_out = "h",
        go_out_plus = "H",
        show_help = "?",
      },
    })

    -- Open mini files at root directory
    -- root directory is determined by current working directory
    vim.keymap.set("n", "<leader>e", function()
      MiniFiles.open()
    end, { desc = "Open file explorer" })

    -- Open mini files at opening file's directory
    vim.keymap.set("n", "<leader>ef", function()
      MiniFiles.open(vim.api.nvim_buf_get_name(0), false) -- false to not load last explorer state
      MiniFiles.reveal_cwd()
    end, { desc = "Open file explorer at current file's directory" })

    --          ▀▀        ▀▀                                                ██
    -- ███▄███▄ ██  ████▄ ██     ▄████ ▄███▄ ███▄███▄ ███▄███▄ ▄█▀█▄ ████▄ ▀██▀▀
    -- ██ ██ ██ ██  ██ ██ ██     ██    ██ ██ ██ ██ ██ ██ ██ ██ ██▄█▀ ██ ██  ██
    -- ██ ██ ██ ██▄ ██ ██ ██▄ ██ ▀████ ▀███▀ ██ ██ ██ ██ ██ ██ ▀█▄▄▄ ██ ██  ██

    local MiniComment = require("mini.comment")
    MiniComment.setup({
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
        end,
      },
    })

    require('ts_context_commentstring').setup {
      enable_autocmd = false,
    }


    --                                       ▄▄
    --          ▀▀        ▀▀                 ██ ▀▀  ██   ▀▀       ▀▀
    -- ███▄███▄ ██  ████▄ ██     ▄█▀▀▀ ████▄ ██ ██ ▀██▀▀ ██ ▄███▄ ██  ████▄
    -- ██ ██ ██ ██  ██ ██ ██     ▀███▄ ██ ██ ██ ██  ██  ▀██ ██ ██ ██  ██ ██
    -- ██ ██ ██ ██▄ ██ ██ ██▄ ██ ▄▄▄█▀ ████▀ ██ ██▄ ██   ██ ▀███▀ ██▄ ██ ██
    --                                 ██                ██
    --                                 ▀▀              ▀▀▀

    local MiniSplitjoin = require("mini.splitjoin")
    MiniSplitjoin.setup({
      mappings = {
        toggle = "<leader>sj",
      },
    })

    --                                                              ▄▄
    --          ▀▀        ▀▀            ██         ██               ██ ▀▀
    -- ███▄███▄ ██  ████▄ ██     ▄█▀▀▀ ▀██▀▀ ▀▀█▄ ▀██▀▀ ██ ██ ▄█▀▀▀ ██ ██  ████▄ ▄█▀█▄
    -- ██ ██ ██ ██  ██ ██ ██     ▀███▄  ██  ▄█▀██  ██   ██ ██ ▀███▄ ██ ██  ██ ██ ██▄█▀
    -- ██ ██ ██ ██▄ ██ ██ ██▄ ██ ▄▄▄█▀  ██  ▀█▄██  ██   ▀██▀█ ▄▄▄█▀ ██ ██▄ ██ ██ ▀█▄▄▄

    local MiniStatusline = require("mini.statusline")
    MiniStatusline.setup({
      use_icons = vim.g.have_nerd_font
    })
  end,
}
