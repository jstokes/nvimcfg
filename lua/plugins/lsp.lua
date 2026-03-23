return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- clojure-lsp uses its own defaults for classpath discovery.
      -- For monorepo projects that need a custom classpath command,
      -- create a .lsp/config.edn in the project root:
      --
      --   {:project-specs
      --    [{:project-path "project.clj"
      --      :classpath-cmd ["lein" "monolith" "with-all" "classpath"]}]}
      --
      vim.lsp.enable('clojure_lsp')
    end,
  },
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {},
  },
}
