local o = vim.opt

o.mouse = 'a'                        -- Enable mouse support in all modes (helpful for resizing splits, etc.)
o.number = true                      -- Enable line numbers
o.relativenumber = true              -- Enable relative line numbers

o.tabstop = 2                        -- Number of spaces that a <Tab> counts for
o.softtabstop = 2                    -- Number of spaces to use for (auto)indent
o.shiftwidth = 2                     -- Number of spaces to use for each step of (auto)
o.expandtab = true                   -- Use spaces instead of tabs
o.autoindent = true                  -- Enable automatic indentation
o.smartindent = true                 -- Enable smart indentation
vim.cmd('filetype plugin indent on') -- Enable filetype detection and plugins
o.wrap = false                       -- Disable line wrapping
o.breakindent = true                 -- Enable break indent (indent wrapped lines)

o.swapfile = false                   -- Disable swap files
o.backup = false                     -- Disable backup files
o.undofile = true                    -- Enable persistent undo

o.hlsearch = true                    -- Highlight search results
o.incsearch = true                   -- Enable incremental search (show matches as you type)
o.ignorecase = true                  -- Ignore case in search patterns
o.smartcase = true                   -- Override 'ignorecase' if search pattern contains uppercase letters

o.termguicolors = true               -- Enable 24-bit RGB colors
o.cursorline = true                  -- Highlight the current line
o.signcolumn = "yes"                 -- Always show the sign column
o.colorcolumn = "80"                 -- Highlight column 80 (useful for code width)
o.scrolloff = 8                      -- Minimum number of screen lines to keep above and below the cursor
o.sidescrolloff = 7                  -- Minimum number of screen columns to keep to the left

-- allows backspacing over everything in insert mode
-- indent: allow backspacing over autoindent
-- eol: allow backspacing over line breaks
-- start: allow backspacing over the start of insert
o.backspace = "indent,eol,start" -- Configure backspace behavior
o.iskeyword:append("-")          -- Treat words with '-' as a single word

o.splitright = true              -- Open new vertical splits to the right
o.splitbelow = true              -- Open new horizontal splits below

o.updatetime = 250               -- Faster completion (default is 4000ms)
o.timeoutlen = 400               -- Time to wait for a mapped sequence to complete (in milliseconds)

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  o.clipboard = 'unnamedplus'
end)

-- Completion options
-- menu: use a popup menu to show the completion matches
-- menuone: show the menu even if there is only one match
-- noselect: do not select a match in the menu automatically
o.completeopt = { 'menu', 'menuone', 'noselect' }

o.list = true -- Show whitespace characters
o.listchars = {
  tab = "» ", -- Character to show for tabs
  trail = "·", -- Character to show for trailing spaces
  nbsp = "␣", -- Character to show for non-breaking spaces
  extends = "→", -- Character to show when a line extends beyond the screen
  precedes = "←", -- Character to show when a line precedes the screen
}
