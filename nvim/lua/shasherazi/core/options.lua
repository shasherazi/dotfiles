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

-- line wrapping
o.wrap = false

-- searching
o.ignorecase = true
o.smartcase = true

-- appearnance
o.termguicolors = true
o.background = "dark"

-- backspace
o.backspace = "indent,eol,start"

-- clipboard
o.clipboard:append("unnamedplus")

-- split windows
o.splitright = true
o.splitbelow = true
