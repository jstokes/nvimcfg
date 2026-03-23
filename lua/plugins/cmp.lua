return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      'saghen/blink.compat',
      'fang2hou/blink-copilot',
      { 'PaterJason/cmp-conjure', ft = { 'clojure', 'fennel' }, dependencies = { 'Olical/conjure' } },
    },
    event = 'InsertEnter',
    opts = {
      keymap = {
        preset = 'default',
        ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-@>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<Tab>'] = { 'select_and_accept', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<CR>'] = {},
      },
      completion = {
        ghost_text = { enabled = true },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        list = { selection = { preselect = false, auto_insert = false } },
      },
      signature = { enabled = true },
      sources = {
        default = { 'lsp', 'copilot', 'buffer', 'path', 'snippets' },
        per_filetype = {
          -- Copilot excluded for Clojure/Fennel — REPL completions are more accurate
          clojure = { 'conjure', 'lsp', 'buffer', 'path' },
          fennel = { 'conjure', 'lsp', 'buffer', 'path' },
        },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = -1, -- slightly lower priority than LSP
            async = true,
          },
          conjure = {
            name = 'conjure',
            module = 'blink.compat.source',
          },
        },
      },
    },
  },
}
