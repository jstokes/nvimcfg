-- minuet-ai.nvim - Local AI code completions via LM Studio (qwen3.5-35b-a3b)
return {
  {
    'milanglacier/minuet-ai.nvim',
    config = function()
      require('minuet').setup {
        provider = 'openai_compatible',
        n_completions = 1,
        context_window = 512,
        provider_options = {
          openai_compatible = {
            end_point = 'http://localhost:1234/v1/chat/completions',
            api_key = 'lm-studio',
            name = 'LM Studio',
            model = 'qwen3.5-35b-a3b',
            stream = true,
            optional = {
              max_tokens = 256,
              top_p = 0.9,
            },
          },
        },
      }
    end,
  },
}
