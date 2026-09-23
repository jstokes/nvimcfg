return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      -- New nvim-treesitter API - parsers must be installed explicitly
      local ensure_installed = {
        'clojure', 'fennel', 'scheme',
        'lua', 'vim', 'vimdoc', 'query',
        'markdown', 'markdown_inline',
        'zig',
      }

      require('nvim-treesitter').install(ensure_installed)

      -- Enable treesitter highlighting for supported filetypes
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })

      -- Start treesitter for current buffer (in case FileType already fired)
      pcall(vim.treesitter.start)
    end,
  },
  { 'HiPhish/rainbow-delimiters.nvim' },
}
