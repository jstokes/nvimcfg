-- minuet-ai.nvim - Local AI code completions via Ollama (Qwen3-Coder)
return {
  {
    'milanglacier/minuet-ai.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'InsertEnter',
    config = function()
      require('minuet').setup({
        provider = 'openai_compatible',
        throttle = 500,
        debounce = 300,
        context_window = 4000,
        provider_options = {
          openai_compatible = {
            api_key = 'TERM',
            name = 'Ollama',
            end_point = 'http://localhost:11434/v1/chat/completions',
            model = 'qwen3-coder',
            optional = {
              max_tokens = 256,
              top_p = 0.9,
            },
          },
        },
      })
    end,
  },
}
