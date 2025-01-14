-- [[ Setting options ]]
-- See `:help o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`
local o = vim.opt

-- Make line numbers default
o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  o.clipboard = 'unnamedplus'
end)

-- Enable break indent
o.breakindent = true

-- Save undo history
o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
o.ignorecase = true
o.smartcase = true

-- Keep signcolumn on by default
o.signcolumn = 'yes'

-- Decrease update time
o.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
o.timeoutlen = 300

-- Configure how new splits should be opened
o.splitright = true
o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
o.inccommand = 'split'

-- Show which line your cursor is on
o.cursorline = true

o.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.

o.smartindent = true -- make indenting smarter again
o.relativenumber = true -- set relative numbered lines
o.wrap = false -- display lines as one long line
o.expandtab = true -- convert tabs to spaces
o.termguicolors = true -- set term gui colors most terminals support this

-- vim: ts=2 sts=2 sw=2 et
