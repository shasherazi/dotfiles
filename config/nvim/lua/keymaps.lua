-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local k = vim.keymap

-- [[ Basic Keymaps ]]
--  See `:help k.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
k.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
k.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- k.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- k.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- k.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- k.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
k.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
k.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
k.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
k.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- vim: ts=2 sts=2 sw=2 et

-- center screen after going half page up or down
k.set('n', '<C-d>', '<C-d>zz')
k.set('n', '<C-u>', '<C-u>zz')

-- vscode like move line/block up down
k.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
k.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
k.set('n', '<A-j>', ':m .+1<CR>==')
k.set('n', '<A-k>', ':m .-2<CR>==')
k.set('v', '<A-k>', ":m '<-2<CR>gv-gv")
k.set('v', '<A-j>', ":m '>+1<CR>gv-gv")

-- resize windows
k.set('n', '<C-Up>', ':resize -2<CR>')
k.set('n', '<C-Down>', ':resize +2<CR>')
k.set('n', '<C-Left>', ':vertical resize -2<CR>')
k.set('n', '<C-Right>', ':vertical resize +2<CR>')

-- better offset
k.set('v', '>', '>gv')
k.set('v', '<', '<gv')

k.set('n', '<leader>q', '<cmd>confirm q<CR>', { desc = 'Quit' })
k.set('n', '<leader>w', '<cmd>w!<CR>', { desc = 'Save' })

-- bufferline
k.set('n', '<leader>c', '<cmd>bdelete<CR>', { desc = 'Close buffer' })
k.set('n', '<leader>bp', '<cmd>BufferLineTogglePin<CR>', { desc = 'Toggle Pin' })
k.set('n', '<leader>bP', '<cmd>BufferLineGroupClose ungrouped<CR>', { desc = 'Delete Non-Pinned Buffers' })
k.set('n', '<leader>bo', '<cmd>BufferLineCloseOthers<CR>', { desc = 'Delete Other Buffers' })
k.set('n', '<leader>bl', '<cmd>BufferLineCloseRight<CR>', { desc = 'Delete Buffers to the Right' })
k.set('n', '<leader>bh', '<cmd>BufferLineCloseLeft<CR>', { desc = 'Delete Buffers to the Left' })
k.set('n', '<leader>bj', '<cmd>BufferLinePick<CR>', { desc = 'Pick a buffer' })
k.set('n', '<leader>bf', '<cmd>Telescope buffers<CR>', { desc = 'Search buffers' })
k.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Prev Buffer' })
k.set('n', '<S-l>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next Buffer' })
k.set('n', '[b', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Prev Buffer' })
k.set('n', ']b', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next Buffer' })
k.set('n', '[B', '<cmd>BufferLineMovePrev<CR>', { desc = 'Move buffer prev' })
k.set('n', ']B', '<cmd>BufferLineMoveNext<CR>', { desc = 'Move buffer next' })

-- git
k.set('n', '<leader>gg', "<cmd>lua require 'lvim.core.terminal'.lazygit_toggle()<cr>", { desc = 'Lazygit' })
k.set('n', '<leader>gj', "<cmd>lua require 'gitsigns'.nav_hunk('next', {navigation_message = false})<cr>", { desc = 'Next Hunk' })
k.set('n', '<leader>gk', "<cmd>lua require 'gitsigns'.nav_hunk('prev', {navigation_message = false})<cr>", { desc = 'Prev Hunk' })
k.set('n', '<leader>gl', "<cmd>lua require 'gitsigns'.blame_line()<cr>", { desc = 'Blame' })
k.set('n', '<leader>gL', "<cmd>lua require 'gitsigns'.blame_line({full=true})<cr>", { desc = 'Blame Line (full)' })
k.set('n', '<leader>gp', "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", { desc = 'Preview Hunk' })
k.set('n', '<leader>gr', "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", { desc = 'Reset Hunk' })
k.set('n', '<leader>gR', "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", { desc = 'Reset Buffer' })
k.set('n', '<leader>gs', "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", { desc = 'Stage Hunk' })
k.set('n', '<leader>gu', "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", { desc = 'Undo Stage Hunk' })
k.set('n', '<leader>go', '<cmd>Telescope git_status<cr>', { desc = 'Open Changed File' })
k.set('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', { desc = 'Checkout Branch' })
k.set('n', '<leader>gc', '<cmd>Telescope git_commits<cr>', { desc = 'Checkout Commit' })
k.set('n', '<leader>gC', '<cmd>Telescope git_bcommits<cr>', { desc = 'Checkout Commit (for Current File)' })
k.set('n', '<leader>gd', '<cmd>Gitsigns diffthis HEAD<cr>', { desc = 'Git Diff' })

-- lsp
k.set('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'Code Action' })
k.set('n', '<leader>lc', function()
  local float = vim.diagnostic.config().float

  if float then
    local config = type(float) == 'table' and float or {}
    config.scope = 'line'

    vim.diagnostic.open_float(config)
  end
end, { desc = 'Current Line Diagnostics' })
k.set('n', '<leader>ld', '<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>', { desc = 'Buffer Diagnostics' })
k.set('n', '<leader>lD', function()
  require('telescope.builtin').lsp_type_definitions()
end, { desc = 'Type Definitions' })
k.set('n', '<leader>lw', '<cmd>Telescope diagnostics<cr>', { desc = 'Diagnostics' })
k.set('n', '<leader>li', '<cmd>LspInfo<cr>', { desc = 'Info' })
k.set('n', '<leader>lI', '<cmd>Mason<cr>', { desc = 'Mason Info' })
k.set('n', '<leader>lj', '<cmd>lua vim.diagnostic.goto_next()<cr>', { desc = 'Next Diagnostic' })
k.set('n', '<leader>lk', '<cmd>lua vim.diagnostic.goto_prev()<cr>', { desc = 'Prev Diagnostic' })
k.set('n', '<leader>ll', '<cmd>lua vim.lsp.codelens.run()<cr>', { desc = 'CodeLens Action' })
k.set('n', '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<cr>', { desc = 'Quickfix' })
k.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'Rename' })
k.set('n', '<leader>ls', '<cmd>Telescope lsp_document_symbols<cr>', { desc = 'Document Symbols' })
k.set('n', '<leader>lS', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', { desc = 'Workspace Symbols' })
k.set('n', '<leader>le', '<cmd>Telescope quickfix<cr>', { desc = 'Telescope Quickfix' })
k.set('n', '<leader>=', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = 'Format Buffer' })

-- search
k.set('n', '<leader>sb', '<cmd>Telescope git_branches<cr>', { desc = 'Checkout Branch' })
k.set('n', '<leader>sc', '<cmd>Telescope colorscheme<cr>', { desc = 'Colorscheme' })
k.set('n', '<leader>sf', '<cmd>Telescope find_files<cr>', { desc = 'Find File' })
k.set('n', '<leader>f', '<cmd>Telescope find_files<cr>', { desc = 'Find File' })
k.set('n', '<leader>sh', '<cmd>Telescope help_tags<cr>', { desc = 'Find Help' })
k.set('n', '<leader>sH', '<cmd>Telescope highlights<cr>', { desc = 'Find Highlight Groups' })
k.set('n', '<leader>sM', '<cmd>Telescope man_pages<cr>', { desc = 'Man Pages' })
k.set('n', '<leader>sr', '<cmd>Telescope oldfiles<cr>', { desc = 'Open Recent File' })
k.set('n', '<leader>sR', '<cmd>Telescope registers<cr>', { desc = 'Registers' })
k.set('n', '<leader>st', '<cmd>Telescope live_grep<cr>', { desc = 'Text' })
k.set('n', '<leader>sk', '<cmd>Telescope keymaps<cr>', { desc = 'Keymaps' })
k.set('n', '<leader>sC', '<cmd>Telescope commands<cr>', { desc = 'Commands' })
k.set('n', '<leader>sl', '<cmd>Telescope resume<cr>', { desc = 'Resume Last Search' })
k.set('n', '<leader>sp', "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", { desc = 'Colorscheme with Preview' })
k.set('n', '<leader>s/', function()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = 'Search in Open Files' })
