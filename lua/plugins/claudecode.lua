-- claudecode.nvim - Claude Code integration for Neovim
return {
  {
    'coder/claudecode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    config = true,
    cmd = {
      'ClaudeCode',
      'ClaudeCodeFocus',
      'ClaudeCodeOpen',
      'ClaudeCodeClose',
      'ClaudeCodeSend',
      'ClaudeCodeTreeAdd',
      'ClaudeCodeAdd',
      'ClaudeCodeDiffAccept',
      'ClaudeCodeDiffDeny',
      'ClaudeCodeStart',
      'ClaudeCodeStop',
      'ClaudeCodeStatus',
      'ClaudeCodeSelectModel',
    },
    init = function()
      -- Register which-key group before plugin loads
      local ok, wk = pcall(require, 'which-key')
      if ok then
        wk.add({ { '<leader>a', group = 'AI (Claude)' } })
      end
    end,
    keys = {
      { '<leader>ac', '<cmd>ClaudeCode<cr>', desc = 'Claude: Toggle' },
      { '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = 'Claude: Focus' },
      { '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Claude: Select model' },
      { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Claude: Send selection' },
      { '<leader>ad', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Claude: Accept diff' },
      { '<leader>aD', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Claude: Deny diff' },
    },
    opts = {
      auto_start = true,
      terminal = {
        split_side = 'right',
        split_width_percentage = 0.35,
        provider = 'snacks',
        auto_close = true,
      },
      diff_opts = {
        auto_close_on_accept = true,
        vertical_split = true,
      },
    },
  },
}
