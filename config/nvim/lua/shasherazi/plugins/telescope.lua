return {
  "nvim-telescope/telescope.nvim",
  tag = "v0.2.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "andrew-george/telescope-themes",
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
      extensions = {
        themes = {
          enable_previewer = true,
          enable_live_preview = true,
          persist = {
            enabled = true,
            path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua",
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("themes")

    -- keymaps
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Open recent files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "List buffers" })

    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "List keymaps" })
    vim.keymap.set("n", "<leader>fC", builtin.commands, { desc = "List commands" })

    -- vim.keymap.set("n", "<leader>fgc", builtin.git_commits, { desc = "Git commits" })
    -- vim.keymap.set("n", "<leader>fgs", builtin.git_status, { desc = "Git status" })
    -- vim.keymap.set("n", "<leader>fgb", builtin.git_branches, { desc = "Git branches" })

    vim.keymap.set("n", "<leader>fc", "<cmd>Telescope themes<CR>",
      { noremap = true, silent = true, desc = "Colorscheme Switcher" })
  end,
}
