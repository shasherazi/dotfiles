vim.g.mapleader = " "

local k = vim.keymap

k.set("n", "<leader>nh", ":nohl<CR>") -- clear search highlights
k.set("n", "x", '"_x')

k.set("n", "<A><Up>", "ddkP") -- move line up
k.set("n", "<A><Down>", "ddp") -- move line down

k.set("n", "<A-Up>", "ddkP") -- move line up by one line
k.set("n", "<A-Down>", "ddp") -- move line down by one line

k.set("n", "<leader>sv", "<C-w>v") -- split window vertically
k.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
k.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
k.set("n", "<leader>sx", ":close<CR>") -- close current split window
k.set("n", "<leader>h", "<C-w>h") -- go to split left
k.set("n", "<leader>j", "<C-w>j") -- go to split down
k.set("n", "<leader>k", "<C-w>k") -- go to split above
k.set("n", "<leader>l", "<C-w>l") -- go to split right

k.set("n", "<leader>to", ":tabnew<CR>")  -- open new tab
k.set("n", "<leader>tx", "<Cmd>BufferClose<CR>")  -- close current tab
k.set("n", "H", "gT") -- go to next tab
k.set("n", "L", "gt") -- go to previous tab

k.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
k.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
k.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
k.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
k.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
k.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
