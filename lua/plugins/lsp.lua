return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- LSP servers can be enabled here
      -- Example: vim.lsp.enable 'lua_ls'
    end,
  },
}
