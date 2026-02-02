local opts = { noremap = true, silent = true }
local k = vim.keymap

vim.g.mapleader = " "      -- Set <Space> as the leader key
vim.g.maplocalleader = " " -- Set <Space> as the local leader key

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      timeout = 100
    })
  end,
})

-- fix j and k for wrapped lines
k.set({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
k.set({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Clear search highlighting with <Esc> in normal mode
k.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

--  See `:help wincmd` for a list of all window commands
k.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
k.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
k.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
k.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Center cursor when scrolling half-page up/down
k.set('n', '<C-d>', '<C-d>zz')
k.set('n', '<C-u>', '<C-u>zz')

-- Move selected lines up/down in visual and insert modes like in vscode
k.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
k.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
k.set('n', '<A-j>', ':m .+1<CR>==')
k.set('n', '<A-k>', ':m .-2<CR>==')
k.set('v', '<A-k>', ":m '<-2<CR>gv-gv")
k.set('v', '<A-j>', ":m '>+1<CR>gv-gv")

-- Resize windows using Ctrl + Arrow keys
k.set('n', '<C-Up>', ':resize -2<CR>')
k.set('n', '<C-Down>', ':resize +2<CR>')
k.set('n', '<C-Left>', ':vertical resize -2<CR>')
k.set('n', '<C-Right>', ':vertical resize +2<CR>')

-- Stay in indent mode when indenting in visual mode
k.set('v', '>', '>gv', opts)
k.set('v', '<', '<gv', opts)

-- Quick save and quit
k.set('n', '<leader>q', '<cmd>confirm q<CR>', { desc = 'Quit' })
k.set('n', '<leader>w', '<cmd>w!<CR>', { desc = 'Save' })

k.set('n', 'J', 'mzJ`z')      -- Keep cursor in place when joining lines
k.set('n', 'n', 'nzzzv')      -- Center cursor when navigating to next search result
k.set('n', 'N', 'Nzzzv')      -- Center cursor when navigating to previous search result

k.set('v', 'p', '"_dP', opts) -- Paste over selected text without yanking it
k.set('n', 'x', '"_x', opts)  -- Delete character without yanking it

-- tab stuff
k.set('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = 'New tab' })
k.set('n', '<leader>tc', '<cmd>tabclose<CR>', { desc = 'Close tab' })
k.set('n', '<leader>th', '<cmd>tabprevious<CR>', { desc = 'Previous tab' })
k.set('n', '<leader>tl', '<cmd>tabnext<CR>', { desc = 'Next tab' })

-- buffer stuff
k.set('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Delete buffer' })
k.set('n', 'L', '<cmd>bnext<CR>', { desc = 'Next buffer' })
k.set('n', 'H', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
k.set('n', '<leader>bl', '<cmd>ls<CR>', { desc = 'List buffers' })
k.set('n', '<leader>bc', '<cmd>%bd|e#|bd#<CR>', { desc = 'Close all buffers except current' })

-- todo-comments
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
