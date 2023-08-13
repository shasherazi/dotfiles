local opts = { noremap = true, silent = true }
local term_opts = {}

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Move text up and down
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-Down>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-Up>", ":move '<-2<CR>gv-gv", opts)

-- ctrl+w but in opposite direction
keymap("i", "<C-e>", "<ESC>dei", opts)

-- Terminal --
keymap("n", "<C-\\>", "<CMD>lua require('FTerm').toggle()<CR>", opts)
keymap("i", "<C-\\>", "<CMD>lua require('FTerm').toggle()<CR>", opts)
keymap("t", "<C-\\>", "<CMD>lua require('FTerm').toggle()<CR>", opts)
keymap("n", "<C-t>", "<CMD>lua require('FTerm').toggle()<CR>", opts)
keymap("i", "<C-t>", "<CMD>lua require('FTerm').toggle()<CR>", opts)
keymap("t", "<C-t>", "<CMD>lua require('FTerm').toggle()<CR>", opts)
