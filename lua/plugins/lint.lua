return {
  {
    'dense-analysis/ale',
    init = function()
      -- Core ALE behavior
      vim.g.ale_enabled = 1
      vim.g.ale_linters = {
        clojure = { 'clj-kondo' },
      }
      vim.g.ale_change_directory = 1
      vim.g.ale_disable_lsp = 1
      vim.g.ale_clojure_clj_kondo_use_stdin = 0

      -- Use Neovim's diagnostic API so ALE respects vim.diagnostic.config
      vim.g.ale_use_neovim_diagnostic_api = 1

      -- Remove gutter signs and any ALE-driven inline/echo noise
      vim.g.ale_set_signs = 0
      vim.g.ale_sign_column_always = 0
      vim.g.ale_virtualtext_cursor = 0
      vim.g.ale_virtualtext = 0
      vim.g.ale_echo_cursor = 0
      vim.g.ale_set_highlights = 0

      -- Optional: if you still want minimal echo when moving the cursor, set ale_echo_cursor = 1
      -- and customize the format to be short. Keeping it off for a calmer UI.
    end,
  },
}
