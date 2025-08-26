return {
  {
    'shortcuts/no-neck-pain.nvim',
    version = '*',
    event = 'VeryLazy',
    opts = {
      width = 120, -- main window width
      buffers = {
        right = { enabled = true },
        left = { enabled = true },
      },
      mappings = {
        enabled = false, -- we prefer our own which-key mappings
      },
    },
    config = function(_, opts)
      require('no-neck-pain').setup(opts)

      -- which-key registrations (if which-key is available)
      local ok_wk, which_key = pcall(require, 'which-key')
      if ok_wk then
        which_key.add({
          { '<leader>z', group = 'Zen / NoNeckPain' },
          { '<leader>zn', function() require('no-neck-pain').enable() end, desc = 'NoNeckPain: Enable' },
          { '<leader>ze', function() require('no-neck-pain').toggle() end, desc = 'NoNeckPain: Toggle' },
          { '<leader>zd', function() require('no-neck-pain').disable() end, desc = 'NoNeckPain: Disable' },
          { '<leader>zc', function() require('no-neck-pain').toggleSide('left') end, desc = 'Toggle Left Buffer' },
          { '<leader>zC', function() require('no-neck-pain').toggleSide('right') end, desc = 'Toggle Right Buffer' },
          { '<leader>zw', function() require('no-neck-pain').resize(100) end, desc = 'Set Width 100' },
          { '<leader>zW', function() require('no-neck-pain').resize(140) end, desc = 'Set Width 140' },
        })
      else
        -- Fallback mappings if which-key is missing
        local map = vim.keymap.set
        map('n', '<leader>zn', function() require('no-neck-pain').enable() end, { desc = 'NoNeckPain: Enable' })
        map('n', '<leader>ze', function() require('no-neck-pain').toggle() end, { desc = 'NoNeckPain: Toggle' })
        map('n', '<leader>zd', function() require('no-neck-pain').disable() end, { desc = 'NoNeckPain: Disable' })
        map('n', '<leader>zc', function() require('no-neck-pain').toggleSide('left') end, { desc = 'Toggle Left Buffer' })
        map('n', '<leader>zC', function() require('no-neck-pain').toggleSide('right') end, { desc = 'Toggle Right Buffer' })
        map('n', '<leader>zw', function() require('no-neck-pain').resize(100) end, { desc = 'Set Width 100' })
        map('n', '<leader>zW', function() require('no-neck-pain').resize(140) end, { desc = 'Set Width 140' })
      end
    end,
  },
}
