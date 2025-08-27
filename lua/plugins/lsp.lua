return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local ok, lspconfig = pcall(require, 'lspconfig')
      if not ok then
        return
      end
      lspconfig.clojure_lsp.setup {}
    end,
  },
}
