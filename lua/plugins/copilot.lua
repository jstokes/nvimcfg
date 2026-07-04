-- GitHub Copilot - AI completions via blink.cmp (manually triggered with <C-x><C-a>)
return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        enabled = false, -- completions shown through blink.cmp, not inline suggestions
      },
      panel = { enabled = false },
      filetypes = {
        clojure = false,
        fennel = false,
      },
    },
  },
  {
    'fang2hou/blink-copilot',
    dependencies = { 'zbirenbaum/copilot.lua' },
  },
}
