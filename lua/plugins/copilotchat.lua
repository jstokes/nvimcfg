-- stylua: ignore

return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'zbirenbaum/copilot.lua' },
      'zbirenbaum/copilot-cmp',
    },
    cmd = { 'CopilotChat' },
     keys = {
       { '<leader>co', function() vim.cmd('CopilotChat') end, desc = 'CopilotChat: Open' },
       { '<leader>cQ', function() vim.cmd('CopilotChatClose') end, desc = 'CopilotChat: Close' },
       { '<leader>cR', function() vim.cmd('CopilotChatReset') end, desc = 'CopilotChat: Reset' },
       { '<leader>cE', function() vim.cmd('CopilotChatExplain') end, desc = 'CopilotChat: Explain' },
       { '<leader>cF', function() vim.cmd('CopilotChatFix') end, desc = 'CopilotChat: Fix' },
       { '<leader>cT', function() vim.cmd('CopilotChatToggle') end, desc = 'CopilotChat: Toggle' },
     },
    config = function(_, opts)
      local ok, chat = pcall(require, 'CopilotChat')
      if not ok then return end
      chat.setup(vim.tbl_deep_extend('force', {
        mappings = {
          complete = false,
          close = { normal = 'q', insert = '<C-c>' },
        },
      }, opts or {}))
      local ok_wk, wk = pcall(require, 'which-key')
      if ok_wk then
        wk.add({
          { '<leader>c', group = 'Code' },
          { '<leader>co', desc = 'CopilotChat: Open' },
          { '<leader>cQ', desc = 'CopilotChat: Close' },
          { '<leader>cR', desc = 'CopilotChat: Reset' },
          { '<leader>cE', desc = 'CopilotChat: Explain' },
          { '<leader>cF', desc = 'CopilotChat: Fix' },
          { '<leader>cT', desc = 'CopilotChat: Toggle' },
        })
      end
    end,
  },
}
