-- stylua: ignore

return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Optional: render markdown in chat buffer
      -- 'MeanderingProgrammer/render-markdown.nvim',
    },
    keys = {
      { '<leader>cc', function() require('codecompanion').chat() end, desc = 'CodeCompanion: Chat' },
      { '<leader>ci', function() require('codecompanion').inline() end, desc = 'CodeCompanion: Inline' },
      { '<leader>cA', function() require('codecompanion').actions() end, desc = 'CodeCompanion: Action Palette' },
    },
    opts = {
      strategies = {
        chat = { adapter = 'litellm' }, -- change to your preferred default
        inline = { adapter = 'litellm' },
        cmd = { adapter = 'litellm' },
      },
      adapters = {
        http = {
          litellm = function()
            return require('codecompanion.adapters').extend('openai_compatible', {
              opts = { stream = true, tools = true },
              url = "http://localhost:4000/v1/chat/completions",
              schema = {
                model = {
                  default = "gpt-5",
                }
              }
            })
          end,
        },
      },
    },
  },
}
