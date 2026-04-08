return {
  'ThePrimeagen/99',
  dependencies = {
    'saghen/blink.cmp',
  },
  config = function()
    local _99 = require('99')
    _99.setup({
      provider = _99.Providers.ClaudeCodeProvider,
      completion = {
        source = 'blink',
      },
      md_files = { 'AGENT.md', 'CLAUDE.md' },
    })

    local map = vim.keymap.set

    -- which-key group
    local ok_wk, wk = pcall(require, 'which-key')
    if ok_wk then
      wk.add { { '<leader>9', group = '99 (AI)' } }
    end

    map('n', '<leader>9s', function() _99.search() end, { desc = '99: Search' })
    map('v', '<leader>9v', function() _99.visual() end, { desc = '99: Visual replace' })
    map('n', '<leader>9b', function() _99.vibe() end, { desc = '99: Vibe' })
    map('n', '<leader>9t', function() _99.tutorial() end, { desc = '99: Tutorial' })
    map('n', '<leader>9o', function() _99.open() end, { desc = '99: Open last result' })
    map('n', '<leader>9l', function() _99.view_logs() end, { desc = '99: View logs' })
    map('n', '<leader>9x', function() _99.stop_all_requests() end, { desc = '99: Stop all' })
  end,
}
