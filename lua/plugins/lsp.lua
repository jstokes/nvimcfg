return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- Enable the clojure_lsp config using Neovim's builtin API
      if vim.lsp and vim.lsp.enable then
        vim.lsp.enable 'clojure_lsp'
      else
        -- Fallback for older Neovim (pre-0.11)
        local ok, lspconfig = pcall(require, 'lspconfig')
        if ok and lspconfig.clojure_lsp then
          lspconfig.clojure_lsp.setup {}
        end
      end
    end,
  },
}
