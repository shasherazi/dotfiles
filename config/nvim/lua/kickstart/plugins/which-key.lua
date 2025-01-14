-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end

return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
      },
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
      },
      -- Document existing key chains
      spec = {
        { '<leader>b', group = '[B]uffers', mode = { 'n' } },
        --   { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        --   { '<leader>d', group = '[D]ocument' },
        { '<leader>g', group = '[G]it' },
        { '<leader>l', group = '[L]SP' },
        --   { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        --   { '<leader>w', group = '[W]orkspace' },
        --   { '<leader>t', group = '[T]oggle' },
        --   { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
