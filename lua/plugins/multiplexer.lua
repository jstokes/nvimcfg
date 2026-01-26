-- multiplexer.nvim - seamless navigation between nvim and terminal multiplexers
return {
  {
    'stevalkr/multiplexer.nvim',
    lazy = false, -- Must load at startup for proper integration
    opts = {
      muxes = { 'nvim', 'tmux', 'zellij', 'kitty', 'wezterm' },
      on_init = function()
        local multiplexer = require('multiplexer')
        -- hjkl navigation
        vim.keymap.set({ 'n', 'i', 't' }, '<C-h>', multiplexer.activate_pane_left, { desc = 'Focus pane left' })
        vim.keymap.set({ 'n', 'i', 't' }, '<C-j>', multiplexer.activate_pane_down, { desc = 'Focus pane down' })
        vim.keymap.set({ 'n', 'i', 't' }, '<C-k>', multiplexer.activate_pane_up, { desc = 'Focus pane up' })
        vim.keymap.set({ 'n', 'i', 't' }, '<C-l>', multiplexer.activate_pane_right, { desc = 'Focus pane right' })
        -- Arrow key navigation
        vim.keymap.set({ 'n', 'i', 't' }, '<C-Left>', multiplexer.activate_pane_left, { desc = 'Focus pane left' })
        vim.keymap.set({ 'n', 'i', 't' }, '<C-Down>', multiplexer.activate_pane_down, { desc = 'Focus pane down' })
        vim.keymap.set({ 'n', 'i', 't' }, '<C-Up>', multiplexer.activate_pane_up, { desc = 'Focus pane up' })
        vim.keymap.set({ 'n', 'i', 't' }, '<C-Right>', multiplexer.activate_pane_right, { desc = 'Focus pane right' })
        -- Resize with Shift
        vim.keymap.set({ 'n', 'i', 't' }, '<C-S-h>', multiplexer.resize_pane_left, { desc = 'Resize pane left' })
        vim.keymap.set({ 'n', 'i', 't' }, '<C-S-j>', multiplexer.resize_pane_down, { desc = 'Resize pane down' })
        vim.keymap.set({ 'n', 'i', 't' }, '<C-S-k>', multiplexer.resize_pane_up, { desc = 'Resize pane up' })
        vim.keymap.set({ 'n', 'i', 't' }, '<C-S-l>', multiplexer.resize_pane_right, { desc = 'Resize pane right' })
        vim.keymap.set({ 'n', 'i', 't' }, '<C-S-Left>', multiplexer.resize_pane_left, { desc = 'Resize pane left' })
        vim.keymap.set({ 'n', 'i', 't' }, '<C-S-Down>', multiplexer.resize_pane_down, { desc = 'Resize pane down' })
        vim.keymap.set({ 'n', 'i', 't' }, '<C-S-Up>', multiplexer.resize_pane_up, { desc = 'Resize pane up' })
        vim.keymap.set({ 'n', 'i', 't' }, '<C-S-Right>', multiplexer.resize_pane_right, { desc = 'Resize pane right' })
      end,
    },
  },
}
