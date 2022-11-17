vim.g.mapleader = " "

local k = vim.keymap

k.set("n", "<leader>nh", ":nohl<CR>")
k.set("n", "x", '"_x')

k.set("n", "<leader>sv", "<C-w>v") -- split window vertically
k.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
k.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
k.set("n", "<leader>sx", ":close<CR>") -- close current split window
k.set("n", "<leader>h", "<C-w>h") -- go to split left
k.set("n", "<leader>j", "<C-w>j") -- go to split down
k.set("n", "<leader>k", "<C-w>k") -- go to split above
k.set("n", "<leader>l", "<C-w>l") -- go to split right

k.set("n", "<leader>to", ":tabnew<CR>")  -- open new tab
k.set("n", "<leader>tx", ":tabclose<CR>")  -- close current tab
k.set("n", "H", "gT") -- go to next tab
k.set("n", "L", "gt") -- go to previous tab

