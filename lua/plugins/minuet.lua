-- minuet-ai.nvim - Local AI code completions via Ollama (gemma4)
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
            end_point = 'http://localhost:11434/v1/chat/completions',
            api_key = 'TERM',
            name = 'Ollama',
            model = 'gemma4:26b',
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
