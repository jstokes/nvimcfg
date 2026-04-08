-- GitHub Copilot - AI inline completions (disabled for Clojure to preserve REPL workflow)
return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        enabled = false, -- we use blink.cmp to display completions instead
      },
      panel = { enabled = false },
      filetypes = {},
    },
  },
  {
    'fang2hou/blink-copilot',
    dependencies = { 'zbirenbaum/copilot.lua' },
  },
}
