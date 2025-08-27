return {
  {
    'dense-analysis/ale',
    init = function()
      vim.g.ale_enabled = 1
      vim.g.ale_linters = {
        clojure = { 'clj-kondo' },
      }
      vim.g.ale_change_directory = 1
      vim.g.ale_disable_lsp = 1
      vim.g.ale_clojure_clj_kondo_use_stdin = 0
    end,
  },
}
