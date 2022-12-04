local o = vim.opt

-- line numbers
o.relativenumber = true
o.number = true

-- tabs and indentation
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.autoindent = true

-- cursor line  
o.cursorline = true

-- undo files even after closing
o.undofile = true

-- line wrapping
o.wrap = false

-- keep lines in scroll
o.scrolloff= 5

-- searching
o.ignorecase = true
o.smartcase = true

-- appearnance
o.termguicolors = true
o.background = "dark"

-- backspace
o.backspace = "indent,eol,start"

-- arrow keys can move through lines
o.whichwrap:append("<,>,[,]")

-- clipboard
o.clipboard:append("unnamedplus")

-- split windows
o.splitright = true
o.splitbelow = true

-- autocompletion menus
o.completeopt = "menu,menuone"

-- set buffers hidden
o.hidden = true
