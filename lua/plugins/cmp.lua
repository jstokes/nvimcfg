return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      'saghen/blink.compat',
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
        ['<C-x><C-a>'] = {
          function(cmp) return cmp.show({ sources = { 'copilot', 'minuet' } }) end,
          desc = 'AI completions (Copilot + minuet)',
        },
      },
      completion = {
        ghost_text = { enabled = true },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        list = { selection = { preselect = false, auto_insert = false } },
      },
      signature = { enabled = true },
      sources = {
        default = { 'lsp', 'buffer', 'path', 'snippets' },
        per_filetype = {
          clojure = { 'conjure', 'lsp', 'buffer', 'path' },
          fennel = { 'conjure', 'lsp', 'buffer', 'path' },
          markdown = { 'lsp', 'buffer', 'path', 'snippets' },
        },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 50,
            async = true,
          },
          minuet = {
            name = 'minuet',
            module = 'minuet.blink',
            score_offset = 50,
            async = true,
            timeout_ms = 3000,
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
