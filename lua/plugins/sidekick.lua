-- sidekick.nvim - Neovim AI sidekick by Folke (CLI terminal, context sending, diffs)
-- Zero API tokens required: integrates directly with your Antigravity subscription
return {
  {
    'folke/sidekick.nvim',
    event = 'VeryLazy',
    cmd = { 'Sidekick' },
    dependencies = { 'folke/snacks.nvim' },
    init = function()
      local ok, wk = pcall(require, 'which-key')
      if ok then
        wk.add({ { '<leader>A', group = 'AI (Antigravity)' } })
      end
    end,
    opts = {
      nes = {
        enabled = false, -- CLI-focused; disable Copilot LSP Next Edit Suggestions
      },
      cli = {
        watch = true, -- Automatically watch and reload files modified by AI CLI tools
        win = {
          layout = 'right',
          split = {
            width = 80,
          },
        },
        tools = {
          antigravity = {
            cmd = { 'agy' },
            url = 'https://antigravity.google',
            format = function(text)
              local Text = require('sidekick.text')
              Text.transform(text, function(str)
                return str:find('[^%w/_%.%-]') and ('"' .. str .. '"') or str
              end, 'SidekickLocFile')

              local ret = Text.to_string(text)
              -- Format into standard CLI file location: @file:start-end or @file:line
              ret = ret:gsub('@([^@%s]+)%s*:L(%d+)%-L(%d+)', '@%1:%2-%3')
              ret = ret:gsub('@([^@%s]+)%s*:L(%d+)', '@%1:%2')
              return ret
            end,
          },
        },
      },
    },
    keys = {
      {
        '<c-.>',
        function() require('sidekick.cli').focus() end,
        desc = 'Sidekick: Focus CLI',
        mode = { 'n', 't', 'i', 'x' },
      },
      {
        '<leader>Aa',
        function() require('sidekick.cli').toggle({ name = 'antigravity', focus = true }) end,
        desc = 'Antigravity: Toggle CLI',
      },
      {
        '<leader>As',
        function() require('sidekick.cli').select() end,
        desc = 'Sidekick: Select CLI Tool',
      },
      -- Smart file/location sender: sends @file:start-end in visual, @file in normal
      {
        '<leader>Af',
        function()
          local is_visual = require('sidekick.util').visual_mode() ~= nil
          local msg = is_visual and '{line}' or '{file}'
          require('sidekick.cli').send({ msg = msg })
        end,
        mode = { 'n', 'x' },
        desc = 'Antigravity: Send File / Location Marker',
      },
      -- Explicit line/location range marker (@file:start-end or @file:line)
      {
        '<leader>Al',
        function() require('sidekick.cli').send({ msg = '{line}' }) end,
        mode = { 'n', 'x' },
        desc = 'Antigravity: Send Line Marker (@file:line)',
      },
      -- Literal code text selection (raw content)
      {
        '<leader>Av',
        function() require('sidekick.cli').send({ msg = '{selection}' }) end,
        mode = { 'x' },
        desc = 'Antigravity: Send Literal Selection',
      },
      -- Enclosing function / symbol / class
      {
        '<leader>At',
        function() require('sidekick.cli').send({ msg = '{this}' }) end,
        mode = { 'n', 'x' },
        desc = 'Antigravity: Send This (Symbol/Function)',
      },
      {
        '<leader>Ap',
        function() require('sidekick.cli').prompt() end,
        mode = { 'n', 'x' },
        desc = 'Antigravity: Select Prompt',
      },
      {
        '<leader>Ad',
        function() require('sidekick.cli').close() end,
        desc = 'Antigravity: Detach/Close CLI Session',
      },
    },
  },
}
