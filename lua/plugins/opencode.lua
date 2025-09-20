-- stylua: ignore

return {
  {
    'NickvanDyke/opencode.nvim',
    dependencies = {
      { 'folke/snacks.nvim', opts = { input = { enabled = true } } },
    },
    init = function()
      vim.opt.autoread = true
      vim.g.opencode_opts = vim.tbl_deep_extend('force', {
        auto_reload = true,
        
      }, vim.g.opencode_opts or {})
    end,
    config = function()
      local map = vim.keymap.set
      map('n', '<leader>ot', function() require('opencode').toggle() end, { desc = 'Toggle opencode' })
      map('n', '<leader>oA', function() require('opencode').ask() end, { desc = 'Ask opencode' })
      map('n', '<leader>oa', function() require('opencode').ask('@cursor: ') end, { desc = 'Ask opencode about this' })
      map('v', '<leader>oa', function() require('opencode').ask('@selection: ') end, { desc = 'Ask opencode about selection' })
      map('n', '<leader>on', function() require('opencode').command('session_new') end, { desc = 'New opencode session' })
      map('n', '<leader>oy', function() require('opencode').command('messages_copy') end, { desc = 'Copy last opencode response' })
      map('n', '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end, { desc = 'Messages half page up' })
      map('n', '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end, { desc = 'Messages half page down' })
      map({ 'n', 'v' }, '<leader>os', function() require('opencode').select() end, { desc = 'Select opencode prompt' })

      local ok_wk, wk = pcall(require, 'which-key')
      if ok_wk then
        wk.add({ { '<leader>o', group = 'opencode' } })
      end
    end,
  },
}
