return {
  -- ALE for linting (clojure: clj-kondo, joker)
  {
    'dense-analysis/ale',
    init = function()
      vim.g.ale_linters = {
        clojure = { 'clj-kondo', 'joker' },
      }
      -- Optional: show signs but don't open loclist automatically
      vim.g.ale_sign_column_always = 1
      vim.g.ale_open_list = 0
    end,
  },
}
