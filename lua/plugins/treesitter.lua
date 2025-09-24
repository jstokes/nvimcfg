return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      highlight = { enable = true },
      auto_install = true,
      ensure_installed = {
        'clojure', 'fennel', 'scheme',
        'lua', 'vim', 'vimdoc', 'query',
        'markdown', 'markdown_inline'
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  { 'HiPhish/rainbow-delimiters.nvim' },
}
