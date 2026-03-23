return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      vim.lsp.config('clojure_lsp', {
        init_options = {
          ['project-specs'] = {
            {
              ['project-path'] = 'project.clj',
              ['classpath-cmd'] = { 'lein', 'with-all', 'classpath' },
            },
            {
              ['project-path'] = 'deps.edn',
              ['classpath-cmd'] = { 'clojure', '-Spath' },
            },
            {
              ['project-path'] = 'shadow-cljs.edn',
              ['classpath-cmd'] = { 'npx', 'shadow-cljs', 'classpath' },
            },
            {
              ['project-path'] = 'bb.edn',
              ['classpath-cmd'] = { 'bb', 'print-deps', '--format', 'classpath' },
            },
          },
        },
      })
      vim.lsp.enable('clojure_lsp')
    end,
  },
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {},
  },
}
