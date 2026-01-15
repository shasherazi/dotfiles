return {
  "nvim-mini/mini.nvim",
  version = "*",
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring', -- for MiniComment integration
  },

  config = function()
    --                            ▄▄     ▄▄             this font is Coder Mini
    --          ▀▀        ▀▀     ██  ▀▀  ██             on https://patorjk.com/software/taag/
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


    --                                                                        ▄▄
    --          ▀▀        ▀▀                                                  ██
    -- ███▄███▄ ██  ████▄ ██     ▄█▀▀▀ ██ ██ ████▄ ████▄ ▄███▄ ██ ██ ████▄ ▄████
    -- ██ ██ ██ ██  ██ ██ ██     ▀███▄ ██ ██ ██ ▀▀ ██ ▀▀ ██ ██ ██ ██ ██ ██ ██ ██
    -- ██ ██ ██ ██▄ ██ ██ ██▄ ██ ▄▄▄█▀ ▀██▀█ ██    ██    ▀███▀ ▀██▀█ ██ ██ ▀████
    --
    local MiniSurround = require("mini.surround")
    MiniSurround.setup({})

    --          ▀▀        ▀▀            ██               ██
    -- ███▄███▄ ██  ████▄ ██     ▄█▀▀▀ ▀██▀▀ ▀▀█▄ ████▄ ▀██▀▀ ▄█▀█▄ ████▄
    -- ██ ██ ██ ██  ██ ██ ██     ▀███▄  ██  ▄█▀██ ██ ▀▀  ██   ██▄█▀ ██ ▀▀
    -- ██ ██ ██ ██▄ ██ ██ ██▄ ██ ▄▄▄█▀  ██  ▀█▄██ ██     ██   ▀█▄▄▄ ██
    local MiniStarter = require("mini.starter")
    MiniStarter.setup({
      header = table.concat({
        "It is not the critic who counts; not the man who points out",
        "how the  strong man stumbles,  or  where the doer  of deeds",
        "could have done them better. The  credit belongs to the man",
        "who is actually in the arena, whose face  is marred by dust",
        "and  sweat and blood; who strives valiantly; who  errs, who",
        "comes short again  and   again, because there is  no effort",
        "without error and shortcoming; but who does actually strive",
        "to  do  the deeds; who   knows great enthusiasms, the great",
        "devotions; who spends himself in a worthy cause; who at the",
        "best knows in the end the triumph of high  achievement, and",
        "who at the worst, if he  fails, at least fails while daring",
        "greatly,  so that his place shall never  be with those cold",
        "and  timid  souls  who   neither know victory   nor defeat.",
        "                                       — Theodore Roosevelt",
      }, "\n"),

      content_hooks = {
        MiniStarter.gen_hook.adding_bullet(),
        MiniStarter.gen_hook.indexing("all", { "actions" }),
        MiniStarter.gen_hook.aligning('center', 'center'),
      },
      items = {
        { name = 'Find Files', action = ':Telescope find_files', section = 'actions' },
        { name = 'Quit',       action = ':q',                    section = 'actions' },
      },
      footer = "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+",
    })
  end,
}
