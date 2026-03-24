return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function() require("which-key").show({ global = false }) end,
      desc =
      "Buffer Local Keymaps (which-key)",
    },
  },
  config = function()
    local wk = require("which-key")
    local builtin = require("telescope.builtin")
    local gitsigns = require("gitsigns")

    wk.add({
      { "L",           "<cmd>bnext<CR>",                         desc = "Next buffer" },
      { "H",           "<cmd>bprevious<CR>",                     desc = "Previous buffer" },

      { "<leader>f",   group = "Find" },
      { "<leader>ff",  builtin.find_files,                       desc = "[F]ind [f]iles" },
      { "<leader>fr",  builtin.oldfiles,                         desc = "[F]ind [r]ecent files" },
      { "<leader>fl",  builtin.live_grep,                        desc = "[F]ind by [l]ive grep" },
      { "<leader>fb",  builtin.buffers,                          desc = "[F]ind [b]uffers" },
      { "<leader>fh",  builtin.help_tags,                        desc = "[F]ind [h]elp tags" },
      { "<leader>fk",  builtin.keymaps,                          desc = "[F]ind [k]eymaps" },
      { "<leader>fC",  builtin.commands,                         desc = "[F]ind [C]ommands" },
      { "<leader>fc",  "<cmd>Telescope themes<CR>",              desc = "[F]ind [c]olorscheme" },

      { "<leader>fg",  group = "Find Git" },
      { "<leader>fgc", builtin.git_commits,                      desc = "[F]ind [g]it [c]ommits" },
      { "<leader>fgs", builtin.git_status,                       desc = "[F]ind [g]it [s]tatus" },
      { "<leader>fgb", builtin.git_branches,                     desc = "[F]ind [g]it [b]ranches" },

      { "<leader>l",   group = "LSP" },
      { "<leader>la",  vim.lsp.buf.code_action,                  desc = "[L]SP [a]ction" },
      { "<leader>lr",  "<cmd>LspRestart<CR>",                    desc = "[L]SP [R]estart" },
      { "<leader>lD",  "<cmd>Telescope diagnostics bufnr=0<CR>", desc = "[L]SP [D]iagnostics buffer" },
      {
        "<leader>ld",
        function() vim.diagnostic.open_float { border = "single", source = true } end,
        desc = "[L]SP line [d]iagnostics"
      },
      {
        "<leader>li",
        function()
          if vim.lsp.inlay_hint.is_enabled() then
            vim.lsp.inlay_hint.enable(false)
          else
            vim.lsp.inlay_hint.enable(true)
          end
        end,
        desc = "[L]SP Toggle [I]nlay hints"
      },

      { "<leader>g",  group = "Git" },
      { "<leader>gs", gitsigns.stage_hunk,                desc = "[G]it Toggle [S]tage hunk" },
      { "<leader>gS", gitsigns.stage_buffer,              desc = "[G]it [S]tage buffer" },
      { "<leader>gU", gitsigns.reset_buffer_index,        desc = "[G]it [U]nstage buffer" },
      { "<leader>gr", gitsigns.reset_hunk,                desc = "[G]it [R]eset hunk" },
      { "<leader>gR", gitsigns.reset_buffer,              desc = "[G]it [R]eset buffer" },
      { "<leader>gp", gitsigns.preview_hunk_inline,       desc = "[G]it [P]review hunk inline" },
      { "<leader>gP", gitsigns.preview_hunk,              desc = "[G]it [P]review hunk" },
      { "<leader>gb", gitsigns.toggle_current_line_blame, desc = "[G]it Toggle [B]lame line" },
      { "<leader>gB", gitsigns.blame_line,                desc = "[G]it [B]lame line" },
      { "<leader>gl", gitsigns.diffthis '@',              desc = "[G]it diff against [L]ast commit" },
      { "<leader>gC", gitsigns.diffthis,                  desc = "[G]it diff against [C]ached" },
      {
        mode = "v",
        { "<leader>gs", function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, desc = "[G]it Toggle [S]tage hunk" },
        { "<leader>gr", function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, desc = "[G]it [R]eset hunk" },
      },

      { "<leader>b",  group = "Buffers" },
      { "<leader>bd", "<cmd>bdelete<CR>",            desc = "[B]uffer [D]elete" },
      { "<leader>bc", "<cmd>%bd|e#|bd#<CR>",         desc = "[B]uffer [C]lose all except current" },
      { "<leader>bH", "<cmd>BufferLineMovePrev<CR>", desc = "[B]uffer move [H]left" },
      { "<leader>bL", "<cmd>BufferLineMoveNext<CR>", desc = "[B]uffer move [L]right" },


      { "<leader>t",  group = "Tabs" },
      { "<leader>tn", "<cmd>tabnew<CR>",             desc = "[T]ab [N]ew" },
      { "<leader>tc", "<cmd>tabclose<CR>",           desc = "[T]ab [C]lose" },
      { "<leader>th", "<cmd>tabprevious<CR>",        desc = "[T]ab [H]previous" },
      { "<leader>tl", "<cmd>tabnext<CR>",            desc = "[T]ab [L]next" },
    })
  end,
}
